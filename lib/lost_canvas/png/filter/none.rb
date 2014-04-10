module LostCanvas

  class PNG

    class Filter
    
      # Scanline filter algorithms that returns the scanline untouched.
      class None

        # Returns the scanline untouched.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Object>] void ignored params.
        # @return [<Fixnum>] the scanline untouched.
        def self.apply(data,*void)
          data
        end

        # Returns the scanline untouched.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Object>] void ignored params.
        # @return [<Fixnum>] the scanline untouched.
        def self.revert(data, *void)
          data
        end
  
      end

    end
 
  end

end
