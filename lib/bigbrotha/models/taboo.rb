# create_table :taboos do |t|
#   t.string :keyword
#   t.timestamps
# end
module BigBrotha

  class Taboo < ActiveRecord::Base

# Associations #
    has_and_belongs_to_many :taboo_posts

# Validations #
    validates :keyword, uniqueness: true, presence: true

  end

end