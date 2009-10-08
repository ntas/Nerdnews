class RssItemsController < ApplicationController
  before_filter :get_preferred_feeds_from_cookie

  def index
    # We only want to get the feeds associated with our preferences
    conditions = ""
    @preferred_feeds.each do |preferred_feed, setting|
      logger.debug("preferred_feed: #{preferred_feed}")
      if setting
        conditions += "source LIKE '" + RssItem::FEED_YAML['feeds'][preferred_feed] + "' OR "
      end
    end
    conditions.gsub!(/ OR $/, '')
    #logger.debug("Our SQL conditions: #{conditions}")
    @rss_items = RssItem.paginate(:all, :conditions => conditions,
                                  :order => 'post_time DESC', :page => params[:page])
  end
  
  private
  def get_preferred_feeds_from_cookie
    @preferred_feeds = {}
    RssItem::FEED_YAML['feeds'].each do |feed_name, feed_url|
      if cookies[feed_name].blank?
        @preferred_feeds[feed_name] = false
      elsif cookies[feed_name] == false
        @preferred_feeds[feed_name] = false
      else
        @preferred_feeds[feed_name] = true
      end
    end
  end

end
