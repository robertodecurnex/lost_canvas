require_relative 'png/chunk.rb'

module LostCanvas

  class PNG

    # PNG signature
    #
    # @return [String] encoded PNG signature.
    SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10].pack('C8')

    module Filters
       
      NONE = 0
      SUB = 1
      UP = 2
      AVERAGE = 3
      PAETH = 4

    end

    def self.decode stream
      raise 'Invalid PNG signature' if stream.read(8) != LostCanvas::PNG::SIGNATURE

      chunks = {}

      until stream.eof?
         chunk = self.decode_chunk(stream)

         if chunk.type == 'IDAT'
           chunks['IDAT'] ||= []
           chunks['IDAT'] << chunk
         else
           chunks[chunk.type] = chunk
         end
      end
     
      height, width, bit_depth, color_type, compression_method, filter_method, interlace_method = chunks['IHDR'].data.unpack('N2C5')

      encoding = OpenStruct.new({
        bit_depth: bit_depth,
        color_type: color_type,
        compression_method: compression_method,
        filter_method: filter_method,
        format: 'png',
        height: height,
        interlace_method: interlace_method,
        width: width
      })

      data = chunks['IDAT'].collect do |chunk| 
        Zlib::Inflate.inflate(chunk.data).bytes.each_slice(1+4*encoding.width).inject([]) do |memo, scanline|
          filter_type, *data = scanline

          memo << LostCanvas::PNG::reverse_filter(filter_type, data, memo.last)
        end
      end.flatten


      data_filters = chunks['IDAT'].collect { |chunk| Zlib::Inflate.inflate(chunk.data).bytes.first }
      
      pixels = Matrix[*data.each_slice(4).to_a.each_slice(encoding.width).to_a]
 
      LostCanvas::Image.new(pixels, encoding)
    end

    def self.decode_chunk stream
      chunk = Chunk.new

      chunk.size = stream.read(4).unpack('N').first
      chunk.type = stream.read(4)
      chunk.data = stream.read(chunk.size)
      chunk.crc = stream.read(4)

      raise 'Invalid CRC' if [Zlib.crc32(chunk.type + chunk.data)].pack('N') != chunk.crc
     
      return chunk
    end
    
    def self.filter(type, data)
      return data if type == 0

      data.inject([]) do |memo, byte|
        memo << byte - (memo[-4] || 0)
      end
    end

    def self.reverse_filter(type, data, previous=nil)
      return data if type == 0
      case type
      when Filters::NONE then
        data
      when Fitlers::SUB then
        data.inject([]) do |memo, byte|
          memo << byte + (memo[-4] || 0)
        end
      when Filters::UP then
        data.inject([]) do |memo, byte|
          memo << byte + (previous[memo.length] || 0)
        end
      when Filters::AVERAGE then
        data.inject([]) do |memo, byte|
          memo << byte + (((memo[-4] || 0) + (previous[memo.length] || 0) / 2)
        end
      when Filters::PAETH then
        data.inject([]) do |memo, byte|
          a = (memo[-4] || 0)  
          b = (previous[memo.length] || 0) 
          c = (previous[memo.length-4] || 0)
          p = a + b - c

          memo << byte + [a,b,c].sort {|x,y| (p-x).abs <=> (p-y).abs}.first
        end
      else
        raise "Filter #{type} not supported"
      end
    end

  end

end
