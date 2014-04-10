module LostCanvas

  class PNG

    class Filter

      class Sub < LostCanvas::PNG::Filter

        def self.apply(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte - (memo.length>=4 ? data[memo.length-4]:0)
          end
        end
        
        def self.revert(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte + (memo[-4]||0)
          end
        end

      end
    
    end
  
  end

end
