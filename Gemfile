source 'http://rubygems.org'

gem 'rails', '3.0.1'

gem "feedtools", :require  => "feed_tools"
gem "will_paginate", :git => "git://github.com/mislav/will_paginate.git", :branch => "rails3"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "wirble"
end

group :production do
  gem "mysql2"
  gem 'rack', '>=1.2.1'
end
