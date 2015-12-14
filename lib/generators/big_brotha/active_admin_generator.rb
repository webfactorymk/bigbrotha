require 'rails/generators'
require 'rails/generators/migration'

module BigBrotha
  class ActiveAdminGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def create_activeadmin_models
      template 'admin/taboo.rb', 'app/admin/taboo.rb'
      template 'admin/taboo_post.rb', 'app/admin/taboo_post.rb'
    end
  end

end