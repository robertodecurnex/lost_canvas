module LostCanvas

  class PNG

    class Filter

      # Scanline filter algorithms based on the previous scanline byte.
      class Up

        # Apply the Up filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def self.apply(data, previous, modifier=1)
          data.inject([]) do |memo, byte|
            memo << byte - (previous[memo.length]||0)*modifier
          end
        end

        # Apply the Up filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def self.revert(data, previous)
          self.apply(data, previous, -1)
        end

      end
    
    end
  
  end

end
