require 'bigbrotha/version'
require 'bigbrotha/models/taboo'
require 'bigbrotha/models/taboo_post'
require 'bigbrotha/models/taboo_posts_taboo'
require 'bigbrotha/censor'
require 'bigbrotha/config'
require 'bigbrotha/errors'

module BigBrotha

  def self.configure
    yield(Config.new)
  end

  def self.add_taboo!(keyword)
    Taboo.create!(keyword: keyword)
  end

  def self.remove_taboo(keyword)
    Taboo.destroy_all(keyword: keyword)
  end

  def self.find_taboo(keyword)
    Taboo.find_by(keyword: keyword)
  end
end