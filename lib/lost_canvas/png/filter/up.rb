module LostCanvas

  class PNG

    class Filter

      # Scanline filter algorithms based on the previous scanline byte.
      class Up < LostCanvas::PNG::Filter

        # Apply the Up filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @param [Fixnum] sign modifier to apply/revert the filter.
        # @return [<Fixnum>] the filtered scanline.
        def apply(data, previous, modifier=1)
          data.inject([]) do |memo, byte|
            memo << byte - (previous[memo.length]||0)*modifier
          end
        end

        # Apply the Up filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def revert(data, previous)
          self.apply(data, previous, -1)
        end

      end
    
    end
  
  end

end
