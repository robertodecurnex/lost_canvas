module LostCanvas

  class PNG

    class Chunk

      attr_accessor :size, :data, :type, :crc

      def initialize(type,data = "")
        @type = type
        @size = data.length
        @data = data             
        @crc  = create_crc
      end

      def to_bytes
        [@size].pack("N1") + @type + @data + @crc
      end

      private

      def create_crc
        [Zlib.crc32( @type + @data )].pack("N1")
      end

    end

  end

end
