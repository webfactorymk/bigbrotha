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
    has_many :taboo_posts_taboos, dependent: :destroy
    has_many :taboos, through: :taboo_posts_taboos

    def set_taboos(new_taboos)
      taboos = []
      new_taboos.try(:each) do |taboo|
        up = TabooPostsTaboo.new(taboo_post: self, taboo: taboo)
        taboos << up
      end
      TabooPostsTaboo.import taboos
      self.reload
    end
  end

end