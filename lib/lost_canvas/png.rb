require_relative 'png/chunk'
require_relative 'png/filter'

module LostCanvas

  class PNG

    # PNG signature
    #
    # @return [String] encoded PNG signature.
    SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10].pack('C8')

    # The size of a pixel (in bytes) for every color type.
    #
    # @return [{Fixnum=>Fixnum}] the pixel size of every color type.
    PIXEL_SIZE = {
      0 => 1,
      2 => 3,
      3 => nil,
      4 => 2,
      6 => 4
    }
        
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
    
      encoding = self.parse_encoding(chunks['IHDR'].data.unpack('N2C5'))


      pixels = self.parse_pixels(encoding, chunks['IDAT'])
      LostCanvas::Image.new(pixels, encoding)
    end

    def self.parse_pixels(encoding, chunks)
      pixel_size = LostCanvas::PNG.pixel_size(encoding.color_type)
   
      data = chunks.collect do |chunk| 
        Zlib::Inflate.inflate(chunk.data).bytes.each_slice(1+pixel_size*encoding.width).inject([]) do |memo, scanline|
          filter_type, *data = scanline

          memo << LostCanvas::PNG.revert_filter(filter_type, encoding.color_type, data, memo.last)
        end
      end.flatten

      Matrix[*data.each_slice(pixel_size).to_a.each_slice(encoding.width).to_a]
    end

    # Returns the encoding header information as en OpenStruct.
    #
    # @param [Array] header the header as an array of values.
    # @return [OpenStruct] the header information as an OpenStruct instance.
    def self.parse_encoding(header)
      height, width, bit_depth, color_type, compression_method, filter_method, interlace_method = header

      OpenStruct.new({
        bit_depth: bit_depth,
        color_type: color_type,
        compression_method: compression_method,
        filter_method: filter_method,
        format: 'png',
        height: height,
        interlace_method: interlace_method,
        width: width
      })
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
    
    def self.filter(type, color_type, data, previous=[])
      LostCanvas::PNG::Filter.get(type, color_type).apply(data, previous)
    end

    def self.revert_filter(type, color_type, data, previous=[])
      LostCanvas::PNG::Filter.get(type, color_type).revert(data, previous)
    end

    def self.pixel_size(color_type)
      PIXEL_SIZE[color_type]
    end


  end

end
