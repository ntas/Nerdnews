# == Schema Information
# Schema version: 20090926230647
#
# Table name: rss_items
#
#  id          :integer         not null, primary key
#  source      :string(255)
#  url         :string(255)
#  title       :string(255)
#  description :text
#  post_time   :datetime
#

class RssItem < ActiveRecord::Base
  validates_uniqueness_of :url
  
  # Load our feed_url config
  FEED_YAML = YAML.load_file 'config/feed_urls.yml'
  
  def self.update_feeds
    feeds = {}
    # Populate our feeds[] array with the feeds for each feed_url source
    FEED_YAML["feeds"].each do |feed_name, feed_url|
      feeds[feed_url] = FeedTools::Feed.open(feed_url)
    end
    # Create RssItems from each of our feeds
    feeds.each do |feed_url, feed|
      feed.items.each do |feed_item|
        create(:source => feed_url, :url => feed_item.link, :title => feed_item.title,
               :description => feed_item.description, :post_time => feed_item.time)
      end
    end
  end
end
