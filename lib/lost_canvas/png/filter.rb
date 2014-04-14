require_relative 'filter/average'
require_relative 'filter/none'
require_relative 'filter/paeth'
require_relative 'filter/sub'
require_relative 'filter/up'

module LostCanvas

  class PNG

    class Filter
      
      # Hash of Filter classes by type.
      #
      # @return [{Fixnum=>Class}] collection of type => class filters.
      FILTERS = {
        0 => LostCanvas::PNG::Filter::None,
        1 => LostCanvas::PNG::Filter::Sub,
        2 => LostCanvas::PNG::Filter::Up,
        3 => LostCanvas::PNG::Filter::Average,
        4 => LostCanvas::PNG::Filter::Paeth
      }

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

      # @param [Fixnum] the image color_type
      def initialize(color_type)
        @color_type = color_type
      end

      # Returns the Filter Class based on its type.
      #
      # @param [Fixnum] type the target Filter type.
      # @param [Fixnum] the image color type.
      # @return [Class] the Filter class for the given type.
      def self.get(type, color_type)
        LostCanvas::PNG::Filter::FILTERS[type].new(color_type)
      end

      # Returns the size of the pixels for the given color type.
      #
      # @return [Fixnum] the pixel size for the given color type.
      def pixel_size
        @pixel_size ||= PIXEL_SIZE[@color_type]
      end

    end

  end

end
