source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.5.1'
gem 'bcrypt', '3.1.10'

# PostgreSQL
gem 'pg', "~> 0.18.4"

# Decoration
gem 'draper', '~> 2.1.0'

# Whitespace remover
gem 'strip_attributes', '~> 1.7.0'

# Configuration
gem 'dotenv-rails', '~> 2.1'

# Serialization
gem 'active_model_serializers', '~> 0.9'

# Image Storage
gem 'refile', git: 'https://github.com/refile/refile', require: "refile/rails"
gem 'refile-s3', git: 'https://github.com/refile/refile-s3'

# Hash Ids
gem 'hashids', '~> 1.0.2'

# Image handling
gem 'fastimage', '~> 1.8'

# Redis
gem 'redis', '~> 3.2.2'

gem 'sinatra', :require => nil
gem 'sidekiq', '~> 4'
gem 'sidekiq-limit_fetch'

# Authentication and permissions
gem 'devise', '~> 3.5'
gem 'simple_token_authentication', '~> 1.12'

# CORS
gem 'rack-cors', '~> 0.4.0'

# Authorization
gem 'pundit', '~> 1.1'

# Pagination
gem 'kaminari', '~> 0.16.3'

group :development, :test do
  # gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug', '~> 8.2'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.4'
  gem 'rspec-given', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'

  gem 'capistrano', '~> 3.4.0'
  gem 'mascherano'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'

  # Spring: https://github.com/rails/spring
  gem 'spring', '1.6.2'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'
end

group :test do
  gem 'webmock', '~> 1.22'
  gem "codeclimate-test-reporter"
end
