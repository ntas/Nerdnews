class RssItemsController < ApplicationController
  def index
    @rss_items = RssItem.find :all, :limit => 25, :order => 'post_time DESC'
  end
end
