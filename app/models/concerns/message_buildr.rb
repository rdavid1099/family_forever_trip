module MessageBuildr
  def self.random_color
    digits = [0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F']
    Array.new(3).reduce('#') do |result, i|
      result += "#{digits[rand(255)/16]}#{digits[rand(255)%16]}"
    end
  end
end
