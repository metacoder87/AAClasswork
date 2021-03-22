            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork
            
            
            
class Map
    
    def initialize
        @map = []
    end
    
    def set(key, value)
        if @map.any? { |el| el.include?(key) }
            @map.map! { |el| el.first == key ? el = [key, value] : el }
        else @map << [key, value]
        end
        @map
    end
    
    def get(key)
        @map.select { |el| el.first == key }.first
    end
        
    def delete(key)
        @map.delete_if { |el| el.first == key }
    end
    
    def show
        @map
    end

end