source 'https://rubygems.org'

ruby '2.3.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# assets
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'compass-rails'
gem 'fancy-buttons'

# auth
gem 'cancancan'

# servers
# Use Puma as the app server
gem 'puma', '~> 3.0'
# gem 'rack-protection', github: 'sinatra/rack-protection'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# views
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'haml-rails'
gem 'simple_form'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  if (Gem::Specification.map(&:name) & %w[rb-fchange rb-inotify rb-fsevent]).empty?
    puts 'Run bundle install twice!!'
    if RUBY_PLATFORM =~ /win32/
      gem 'rb-fchange'
      gem 'rb-notifu'
    elsif RUBY_PLATFORM =~ /linux/
      gem 'rb-inotify'
      gem 'libnotify'
    elsif RUBY_PLATFORM =~ /darwin/
      gem 'rb-fsevent'
      gem 'growl'
    end
  end

  gem 'rails-controller-testing'
  gem "rspec-rails"
  gem 'guard-bundler', require: false
  gem 'guard-rspec'

  # To load the directory
  gem 'require_all'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'

  # i18n + templates and tools
  gem 'active_record_model_and_rspec_enhanced_templates'
  gem 'advanced_haml_scaffold_generator'
  gem 'factory_girl_fixtures_template'
  gem 'i18n_scaffold_controller_template'
  gem 'i18n_scaffold_generator'
  gem 'jbuilder_rspec_generator'
  gem 'rspec_rails_scaffold_templates'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails', github: 'dima4p/factory_girl_rails'
  gem 'shoulda'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
