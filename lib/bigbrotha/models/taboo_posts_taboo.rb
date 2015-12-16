module BigBrotha
  class TabooPostsTaboo < ActiveRecord::Base
    belongs_to :taboo_post
    belongs_to :taboo
  end
end