module LostCanvas

  class PNG

    class Filter

      class Paeth < LostCanvas::PNG::Filter

        def self.apply(data, previous)
          data.inject([]) do |memo, byte|
            a = memo.length>=4 ? data[memo.length-4]:0
            b = previous[memo.length]
            c = memo.length>=4 ? previous[memo.length-4]:0
            p = a + b - c

            memo << byte - [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end
        
        def self.revert(data, previous)
          data.inject([]) do |memo, byte|
            a = memo[-4].to_i
            b = previous[memo.length]
            c = memo.length>=4 ? previous[memo.length-4]:0
            p = a + b - c

            memo << byte + [a,b,c].sort{|x,y| (p-x).abs <=> (p-y).abs}.first
          end
        end

      end
    
    end
  
  end

end
