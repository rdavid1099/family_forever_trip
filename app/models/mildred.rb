class Mildred
  include Giphy
  include MessageBuildr

  def self.intro(user = "Deary")
    current_hour = Time.now.hour
    time_greeting = if current_hour >= 4 && current_hour < 11
      "morning"
    elsif current_hour >= 11 && current_hour < 17
      "afternoon"
    elsif current_hour >= 17 && current_hour < 4
      "evening"
    end
    "Good #{time_greeting}, #{user}!"
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
