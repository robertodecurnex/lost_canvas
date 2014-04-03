require_relative 'png/chunk.rb'

module LostCanvas

  class PNG

    # PNG signature
    #
    # @return [String] encoded PNG signature.
    SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10].pack('C8')

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

      data = chunks['IDAT'].collect { |chunk| Zlib::Inflate.inflate(chunk.data).bytes[1..-1] }.flatten

      height, width = chunks['IHDR'].data.unpack('N2C4')

      encoding = OpenStruct.new(format: 'png')

      pixels = Matrix[*data.each_slice(4).to_a.each_slice(width).to_a]

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

  end

end
