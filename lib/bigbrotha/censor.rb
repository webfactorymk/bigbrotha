
module BigBrotha
  class Censor

    # Class methods #

    def self.censor_post_and_save!(user, post, content_column)

      raise "Missing parameter: user" if user.blank?
      raise "Missing parameter: content_column" if content_column.blank?
      return post if post.nil?

      censored_post = post
      taboos = Taboo.all
      words = post.split(/[\s]/).delete_if(&:blank?) #split by spaces

      words.each do |word|
        appeared_taboos = find_taboos_in_text(word, taboos)


        unless appeared_taboos.blank?
          new_taboo_post = TabooPost.find_or_create_by(content: post, content_column: content_column, user: user)
          new_taboo_post.taboos += appeared_taboos

          #censor all taboos appearing in one word
          censored_word = censor_taboos_in_text(word, appeared_taboos)

          #replace the word with taboos in the original post
          censored_post = censored_post.gsub(word, censored_word)
        end

      end
      censored_post
    end

    def self.find_taboos_in_text(text, taboos)
      return nil if text.blank? or taboos.blank?
      appeared_taboos = []
      taboos.each do |taboo|
        taboo_chars = taboo.keyword.scan(/./) #split the taboos word on chars
        regex = ""
        taboo_chars.each { |c| regex+="[#{c.downcase}|#{c.upcase}]" }
        appeared_taboos << taboo unless (word =~ Regexp.new(regex)).blank?
      end
      return appeared_taboos
    end


    def self.censor_taboos_in_text(text, taboos)
      taboos.each do |taboo|
        taboo_chars = taboo.keyword.scan(/./)
        regex = ""
        taboo_chars.each { |c| regex+= "[#{c.downcase}|#{c.upcase}]" } #build the regex to match upcase and downcase letters
        r = Regexp.new(regex)
        text = text.gsub(r, "*" * taboo.keyword.size)
      end
      text
    end

  end
end