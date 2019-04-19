module Giphy
  def self.giphy_api_endpoint(type)
    "https://api.giphy.com/v1/gifs/random?api_key=#{ENV['GIPHY_API_KEY']}&tag=#{type}&rating=G"
  end

  def self.random(type = 'random')
    begin
      uri  = URI(giphy_api_endpoint(type))
      resp = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
      resp[:data][:images][:fixed_width][:url]
    rescue
      "https://media.giphy.com/media/S5JSwmQYHOGMo/giphy.gif"
    end
  end
end
