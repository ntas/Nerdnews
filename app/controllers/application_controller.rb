# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :check_cookies, :get_preferred_feeds_from_cookie
  
  def check_cookies
    if cookies[:prefs_set].blank? || cookies[:prefs_set] == false
      # This user has never set any preferences, define defaults
      set_preferred_feeds([:slashdot, :digg, :delicious])
    end
  end
  
  private
  def set_preferred_feeds(feed_list=[])
    # Loop through our feed_list and set 
    unless feed_list.blank?
      feed_list.each do |feed|
        cookies[feed] = true
      end
    end
    # Set :prefs_set to true
    cookies[:prefs_set] = true
  end
  
  def get_preferred_feeds_from_cookie
    @preferred_feeds = {}
    RssItem::FEED_YAML['feed_urls'].each do |feed_name, feed_url|
      if cookie[feed_name].blank?
        @preferred_feeds[feed_name] = false
      elsif cookie[feed_name] == false
        @preferred_feeds[feed_name] = false
      else
        @preferred_feeds[feed_name] = true
      end
    end
  end
end
