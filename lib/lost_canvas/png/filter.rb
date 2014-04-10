require_relative 'filter/average'
require_relative 'filter/none'
require_relative 'filter/paeth'
require_relative 'filter/sub'
require_relative 'filter/up'

module LostCanvas

  class PNG

    class Filter

      FILTERS = {
        0 => LostCanvas::PNG::Filter::None,
        1 => LostCanvas::PNG::Filter::Sub,
        2 => LostCanvas::PNG::Filter::Up,
        3 => LostCanvas::PNG::Filter::Average,
        4 => LostCanvas::PNG::Filter::Paeth
      }

      def self.get(type)
        LostCanvas::PNG::Filter::FILTERS[type]
      end

    end

  end

end
