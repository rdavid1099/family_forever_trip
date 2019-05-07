class Mildred
  include Giphy
  include MessageBuildr

  METHOD = {
    post_message: 'chat.postMessage'
  }

  def self.intro(user = "Deary")
    current_hour = Time.zone.now.hour
    time_greeting = if current_hour >= 4 && current_hour < 11
      "morning"
    elsif current_hour >= 11 && current_hour < 17
      "afternoon"
    elsif current_hour >= 17 || current_hour < 4
      "evening"
    else
      "day"
    end
    "Good #{time_greeting}, #{user}!"
  end

  def initialize
    @conn = Faraday.new(url: "https://slack.com") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    @conn.authorization :Bearer, ENV["SLACK_AUTH_TOKEN"]
  end

  def slack_method(opts)
    desired_method = opts.keys.first
    conn.post do |req|
      req.url "/api/#{METHOD[desired_method]}"
      req.headers["Content-type"] = "application/json"
      req.body = opts[desired_method].to_json
    end
  end

  def self.msg_attachment(opts)
    {
      fallback: opts[:fallback] || opts[:text],
      color: opts[:color] || MessageBuildr.random_color,
      pretext: opts[:pretext],
      author_name: opts[:author_name],
      author_link: opts[:author_link],
      author_icon: opts[:author_icon],
      title: opts[:title],
      title_link: opts[:title_link],
      text: opts[:text],
      fields: opts[:fields],
      image_url: opts[:random_giphy] ? Giphy.random(opts[:random_giphy]) : opts[:image_url],
      thumb_url: opts[:thumb_url],
      footer: opts[:footer],
      footer_icon: opts[:footer_icon],
      ts: opts[:ts],
    }
  end

  private
    attr_reader :conn
end
