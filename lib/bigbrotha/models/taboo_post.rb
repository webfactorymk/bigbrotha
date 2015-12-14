# create_table :taboo_posts do |t|
#   t.text :content
#   t.string :content_column
#   t.belongs_to :user
#   t.timestamps
# end
module BigBrotha

  class TabooPost < ActiveRecord::Base

    # Associations #

    belongs_to :user
    has_and_belongs_to_many :taboos

  end

end