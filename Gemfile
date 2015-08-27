source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.4'
gem 'bcrypt', '3.1.10'

# PostgreSQL
gem 'pg', "~> 0.18.2"

# Decoration
gem 'draper', '~> 2.1.0'

# Whitespace remover
gem 'strip_attributes', '~> 1.7.0'

# Configuration
gem 'dotenv-rails', '~> 2.0'

# Serialization
gem 'active_model_serializers', '~> 0.9.3'

# Image Storage
gem 'refile', git: 'https://github.com/refile/refile', require: "refile/rails"
gem 'refile-s3', git: 'https://github.com/refile/refile-s3'

# Hash Ids
gem 'hashids', '~> 1.0.2'

# Image handling
gem 'fastimage', '~> 1.7.0'

# Redis
gem 'redis', '~> 3.2.1'

gem 'sinatra', :require => nil
gem 'sidekiq', '~> 3.4.0'
gem 'sidekiq-limit_fetch'

# Authentication and permissions
gem 'devise', '~> 3.5'
gem 'simple_token_authentication', '~> 1.10'

# CORS
gem 'rack-cors', '~> 0.4.0'

# Authorization
gem 'pundit', '~> 1.0.1'

# Pagination
gem 'kaminari', '~> 0.16.3'

group :development, :test do
  # gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug', '6.0.0'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.3'
  gem 'rspec-given', '~> 3.7'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'database_cleaner', '~> 1.4.0'

  gem 'capistrano', '~> 3.4.0'
  gem 'mascherano'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'

  # Spring: https://github.com/rails/spring
  gem 'spring', '1.3.6'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'
end

group :test do
  gem 'webmock', '~> 1.21.0'
  gem "codeclimate-test-reporter"
end
