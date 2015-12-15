require 'rails/generators'
require 'rails/generators/migration'

module BigBrotha
  class InitializerGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def create_migrations
      migration_template 'migrations/create_taboos_and_taboo_posts.rb', 'db/migrate/create_taboos_and_taboo_posts.rb'
    end


    def create_setup_file
      template "initializers/bigbrother_setup.rb", "config/initializers/bigbrother_setup.rb"
    end

  end
end