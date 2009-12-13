class RssItemsController < ApplicationController

  def index
    get_preferred_feeds_from_cookie
    # We only want to get the feeds associated with our preferences
    conditions = ""
    no_preferred_feeds = true # We want to check for people deselecting all feeds
    @preferred_feeds.each do |preferred_feed, setting|
      if setting == 1 || setting == true
        conditions += "source LIKE '" + RssItem::FEED_YAML['feeds'][preferred_feed] + "' OR "
        no_preferred_feeds = false
      end
    end
    conditions.gsub!(/ OR $/, '')
    logger.debug("Our SQL conditions: #{conditions}")
    unless no_preferred_feeds
      @rss_items = RssItem.paginate(:all, :conditions => conditions,
                                    :order => 'post_time DESC', :page => params[:page])
    end
  end

  def toggle_pref
    feed = params[:id]
    logger.debug("#{feed} is currently set to #{cookies[feed]}, which is of type #{cookies[feed].class}")
    # Toggle whether the feed is a preferred feed in our cookie
    cookies[feed] == '1' ? cookies[feed] = 0 : cookies[feed] = 1
    logger.debug("#{feed} is now set to #{cookies[feed]}")
    redirect_to :action => :index
  end
  
  private
  def get_preferred_feeds_from_cookie
    logger.debug("Getting the preferred feeds from the cookie...")
    @preferred_feeds = {}
    RssItem::FEED_YAML['feeds'].each do |feed_name, feed_url|
      if cookies[feed_name].blank?
        @preferred_feeds[feed_name] = 0
      elsif cookies[feed_name] == '0' || cookies[feed_name] == false
        @preferred_feeds[feed_name] = 0
      else
        @preferred_feeds[feed_name] = 1
      end
      logger.debug("preferred_feed setting: #{feed_name} => #{@preferred_feeds[feed_name]}")
    end
  end

end
