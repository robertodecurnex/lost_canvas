module LostCanvas

  class PNG

    class Filter

      class Up < LostCanvas::PNG::Filter

        def self.apply(data, previous, modifier=1)
          data.inject([]) do |memo, byte|
            memo << byte - (previous[memo.length]||0)*modifier
          end
        end

        def self.revert(data, previous)
          self.apply(data, previous, -1)
        end

      end
    
    end
  
  end

end
