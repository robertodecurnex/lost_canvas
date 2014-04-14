module LostCanvas

  class PNG

    class Filter
    
      # Scanline filter algorithms that returns the scanline untouched.
      class None < LostCanvas::PNG::Filter

        # Returns the scanline untouched.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Object>] void ignored params.
        # @return [<Fixnum>] the scanline untouched.
        def apply(data,*void)
          data
        end

        # Returns the scanline untouched.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Object>] void ignored params.
        # @return [<Fixnum>] the scanline untouched.
        def revert(data, *void)
          data
        end
  
      end

    end
 
  end

end
