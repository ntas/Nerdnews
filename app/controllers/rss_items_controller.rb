class RssItemsController < ApplicationController
  def index
    @rss_items = RssItem.paginate :all, :order => 'post_time DESC', :page => params[:page]
  end
end
