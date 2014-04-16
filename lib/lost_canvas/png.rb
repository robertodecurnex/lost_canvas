require_relative 'png/chunk'
require_relative 'png/filter'

module LostCanvas

  class PNG
    
    module ColorType

      GRAYSCALE = 0
      TRUECOLOR = 2
      INDEXED_COLOR = 3 
      GRAYSCALE_WITH_ALPHA = 4
      TRUECOLOR_WITH_ALPHA = 6

    end
        
    module Filters
       
      NONE = 0
      SUB = 1
      UP = 2
      AVERAGE = 3
      PAETH = 4

    end

    # PNG signature
    #
    # @return [String] encoded PNG signature.
    SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10].pack('C8')

    # The size of a pixel (in bytes) for every color type.
    #
    # @return [{Fixnum=>Fixnum}] the pixel size of every color type.
    PIXEL_SIZE = {
      ColorType::GRAYSCALE            => 1,
      ColorType::TRUECOLOR            => 3,
      ColorType::INDEXED_COLOR        => 1,
      ColorType::GRAYSCALE_WITH_ALPHA => 2,
      ColorType::TRUECOLOR_WITH_ALPHA => 4
    }

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

      rgba_pixels = self.to_rgba(pixels, encoding, chunks['PLTE'])

      LostCanvas::Image.new(pixels, encoding)
    end

    def self.to_rgba(pixels, encoding, palette)
      case encoding.color_type
      when ColorType::GRAYSCALE            then self.grayscale_to_rgba(pixels)
      when ColorType::TRUECOLOR            then self.truecolor_to_rgba(pixels)
      when ColorType::INDEXED_COLOR        then self.indexed_color_to_rgba(pixels, palette)
      when ColorType::GRAYSCALE_WITH_ALPHA then self.grayscale_with_alpha_to_rgba(pixels)
      when ColorType::TRUECOLOR_WITH_ALPHA then self.truecolor_with_alpha_to_rgba(pixels)
      end
    end

    def self.indexed_color_to_rgba(pixels, palette)
      palette = palette.data.unpack('C*').each_slice(3).collect {|e| e}
      
      pixels.collect do |pixel|
        palette[pixel.first] << 255
      end
    end

    def self.grayscale_to_rgba(pixels)
      pixles.collect do |pixel|
        [pixel]*3 << 255
      end
    end

    def self.truecolor_to_rgba(pixels)
      pixels.collect do |pixel|
        pixel << 255
      end
    end
    
    def self.grayscale_with_alpha_to_rgba(pixels)
      pixels.collect do |pixel|
        [pixel.first]*3 << pixel.last
      end
    end

    def self.truecolor_with_alpha_to_rgba(pixels)
      pixels
    end

    def self.parse_pixels(encoding, chunks)
      pixel_length = LostCanvas::PNG.pixel_length(encoding.color_type)
      scanline_length = LostCanvas::PNG.scanline_length(encoding.color_type, encoding.width)
   
      data = chunks.collect do |chunk| 
        Zlib::Inflate.inflate(chunk.data).bytes.each_slice(scanline_length).inject([]) do |memo, scanline|
          scanline.unshift(0) if encoding.color_type == ColorType::INDEXED_COLOR

          filter_type, *data = scanline

          memo << LostCanvas::PNG.revert_filter(filter_type, encoding.color_type, data, memo.last)
        end
      end.flatten

      Matrix[*data.each_slice(pixel_length).to_a.each_slice(encoding.width).to_a]
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

    def self.pixel_length(color_type)
      PIXEL_SIZE[color_type]
    end

    def self.scanline_length(color_type, image_width)
      self.pixel_length(color_type)*image_width + (color_type!=ColorType::INDEXED_COLOR ? 1:0)
    end

  end

end
