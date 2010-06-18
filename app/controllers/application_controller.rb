class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :check_cookies
  
  def check_cookies
    if cookies[:prefs_set].blank? || cookies[:prefs_set] == {:value => false}
      # This user has never set any preferences, define defaults
      set_preferred_feeds([:slashdot, :digg, :delicious])
    end
  end
  
  private
  def set_preferred_feeds(feed_list=[])
    # Loop through our feed_list and set 
    unless feed_list.blank?
      feed_list.each do |feed|
        cookies[feed] = {:value => true, :expires => 1.year.from_now}
      end
    end
    # Set :prefs_set to true
    cookies[:prefs_set] = {:value => true, :expires => 1.year.from_now}
  end
end
