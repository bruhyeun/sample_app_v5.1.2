web: bundle exec puma -C config/puma.rb
web: bundle exec rails server -p $PORT
worker: QUEUE=* rake environment resque:work