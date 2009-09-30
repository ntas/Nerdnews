class CreateRssItems < ActiveRecord::Migration
  def self.up
    create_table :rss_items do |t|
      t.string :source
      t.string :url
      t.string :title
      t.text :description
      t.timestamp :post_time
    end
  end

  def self.down
    drop_table :rss_items
  end
end
