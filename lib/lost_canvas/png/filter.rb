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

      # Returns the Filter Class based on its type.
      #
      # @param [Fixnum] type the target Filter type.
      # @return [Class] the Filter class for the given type.
      def self.get(type)
        LostCanvas::PNG::Filter::FILTERS[type]
      end

    end

  end

end
