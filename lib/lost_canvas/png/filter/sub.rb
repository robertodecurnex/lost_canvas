module LostCanvas

  class PNG

    class Filter

      # Scanline filter algorithms based on the previous pixel byte.
      class Sub 

        # Apply the Sub filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def self.apply(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte - (memo.length>=4 ? data[memo.length-4]:0)
          end
        end
        
        # Apply the Sub filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def self.revert(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte + (memo[-4]||0)
          end
        end

      end
    
    end
  
  end

end
