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
end
