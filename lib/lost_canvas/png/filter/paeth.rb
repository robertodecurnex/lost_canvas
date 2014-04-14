module LostCanvas

  class PNG

    class Filter

      # Scanline filter algorithms based on the difference between the original
      # byte and the smaller difference between the originail, the previous scanline 
      # and the previous pixel of the previous scanline bytes.
      class Paeth < LostCanvas::PNG::Filter

        # Apply the Peath filter over the given scanline.
        #
        # @param [<Fixnum>] data the target scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the filtered scanline.
        def apply(data, previous)
          data.inject([]) do |memo, byte|
            a = memo.length>=self.pixel_size ? data[memo.length-self.pixel_size]:0
            b = previous[memo.length]||0
            c = memo.length>=self.pixel_size ? previous[memo.length-self.pixel_size]||0:0
            p = a + b - c

            memo << byte - [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end
        
        # Reverts the applied Peath filter over the given filtered scanline.
        #
        # @param [<Fixnum>] data the filtered scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the original scanline.
        def revert(data, previous)
          data.inject([]) do |memo, byte|
            a = memo[-self.pixel_size].to_i
            b = previous[memo.length]||0
            c = memo.length>=self.pixel_size ? previous[memo.length-self.pixel_size]||0:0
            p = a + b - c

            memo << byte + [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end

      end
    
    end
  
  end

end
