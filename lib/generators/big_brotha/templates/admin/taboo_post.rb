ActiveAdmin.register BigBrotha::TabooPost, as: 'TabooPost' do

  menu :parent => "Taboos", :priority => 1
  config.filters = false
  actions :all, :except => [:destroy, :edit, :new]

  index do
    selectable_column
    column :id
    column :content
    column :user do |taboo_post|
      link_to(taboo_post.user.username, admin_user_path(taboo_post.user), :method => :get)
    end
    column :taboos do |taboo_post|
      taboo_post.taboos.pluck(:keyword)
    end
    column :where do |taboo_post|
      taboo_post.content_column
    end
    column :created_at
    actions defaults: true do |taboo_post|
      #change path(ban_admin_reported_user_path) to your path  and method type when banning a user
     # link_to('Ban User', ban_admin_reported_user_path(taboo_post.user), :method => :delete, :data => {:confirm => 'Are you sure?'})
    end
  end

  show do |taboo_post|
    attributes_table do
      row :id
      row :content
      row :user do
        link_to(taboo_post.user.username, admin_user_path(taboo_post.user), :method => :get)
      end
      row :taboos do
        taboo_post.taboos.pluck(:keyword)
      end
      row :where do
        taboo_post.content_column
      end
      row :created_at
    end
  end

  controller do
    # prevent N+1 queries
    def scoped_collection
      BigBrotha::TabooPost.includes(:user)
    end
  end

end