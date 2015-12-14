class CreateTaboosAndTabooPosts < ActiveRecord::Migration
  def change
    create_table :taboos do |t|
      t.string :keyword, null: false, unique: true
      t.timestamps
    end

    create_table :taboo_posts do |t|
      t.text :content, null: false
      t.string :content_column
      t.belongs_to :user
      t.timestamps
    end

    create_join_table :taboo_posts, :taboos do |t|
      t.index [:taboo_post_id, :taboo_id]
      t.index [:taboo_id, :taboo_post_id]
    end

  end
end
