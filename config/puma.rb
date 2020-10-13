# frozen_string_literal: true

# https://stackoverflow.com/questions/43640261/is-rails-max-threads-something-that-puma-will-set-and-scale-during-build-time
# WORKERS_NUM is not a default env variable name
workers Integer(ENV['WORKERS_NUM'] || 1)
max_threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 1)
min_threads_count = max_threads_count
threads min_threads_count, max_threads_count
port ENV['PORT'] || 3000
