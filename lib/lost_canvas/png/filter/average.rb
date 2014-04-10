module LostCanvas

  class PNG

    class Filter

      class Average

        def self.apply(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte - ((memo.length>=4 ? data[memo.length-4]:0) + (previous[memo.length]||0))/2
          end
        end
        
        def self.revert(data, previous)
          data.inject([]) do |memo, byte|
            memo << byte + ((memo[-4]||0) + (previous[memo.length] || 0))/2
          end
        end

      end
    
    end
  
  end

end
