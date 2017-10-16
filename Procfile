web: bundle exec puma -C config/puma.rb
consumer: bundle exec racecar --require config/racecar OrderConsumer
release: bundle exec rake db:migrate
