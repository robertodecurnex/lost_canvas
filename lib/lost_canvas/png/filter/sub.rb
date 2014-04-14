module LostCanvas

  class PNG

    class Filter

      # Scanline filter algorithms based on the previous pixel byte.
      class Sub < LostCanvas::PNG::Filter


        # Apply the Sub filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def apply(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte - (memo.length>=self.pixel_size ? data[memo.length-self.pixel_size]:0)
          end
        end
        
        # Apply the Sub filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def revert(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte + (memo[-self.pixel_size]||0)
          end
        end

      end
    
    end
  
  end

end
