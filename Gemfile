source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'
gem 'devise', '2.2.4'
gem 'vestal_versions', git: 'git://github.com/laserlemon/vestal_versions', branch: 'rails_3'

group :development, :test do
    gem 'sqlite3', '1.3.5'
    gem 'rspec-rails', '2.11.0'
    gem 'spork', '0.9.2'
end

group :development do
    gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
    gem 'capybara', '1.1.2'
    gem 'factory_girl_rails', '4.1.0'
    gem 'webmock'
end

group :production do
    gem 'pg', '0.12.2'
end
