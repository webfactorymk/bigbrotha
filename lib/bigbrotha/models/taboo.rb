# create_table :taboos do |t|
#   t.string :keyword
#   t.timestamps
# end
module BigBrotha

  class Taboo < ActiveRecord::Base

# Associations #
    has_many :taboo_posts_taboos, dependent: :destroy
    has_many :taboo_posts, through: :taboo_posts_taboos

# Validations #
    validates :keyword, uniqueness: true, presence: true

  end

end