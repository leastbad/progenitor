web: bundle exec rails server -p $PORT
worker: sidekiq -C ./config/sidekiq.yml
release: bin/release-tasks