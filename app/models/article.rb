class Article < ActiveRecord::Base
  belongs_to :user


  @@alchemy_url ||= ENV["ALCHEMY_URL"]
  attr_accessor :keywords

  def author
    user.email
  end

  def get_keywords
    res = Typhoeus.get(@@alchemy_url, params: {
      apikey: ENV["ALCHEMY_APIKEY"],
      text: content,
      maxRetrieve: 10,
      outputMode: "json"
    })
    words = JSON.parse(res.body)["keywords"].map do |w|
      w['text']
    end
    @keywords = words.join(" | ")
  end

end
