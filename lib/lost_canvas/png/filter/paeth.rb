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
        def self.apply(data, previous)
          data.inject([]) do |memo, byte|
            a = memo.length>=4 ? data[memo.length-4]:0
            b = previous[memo.length]||0
            c = memo.length>=4 ? previous[memo.length-4]||0:0
            p = a + b - c

            memo << byte - [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end
        
        # Reverts the applied Peath filter over the given filtered scanline.
        #
        # @param [<Fixnum>] data the filtered scanline.
        # @param [<Fixnum>] previous the previous scanline.
        # @return [<Fixnum>] the original scanline.
        def self.revert(data, previous)
          data.inject([]) do |memo, byte|
            a = memo[-4].to_i
            b = previous[memo.length]||0
            c = memo.length>=4 ? previous[memo.length-4]||0:0
            p = a + b - c

            memo << byte + [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end

      end
    
    end
  
  end

end
