# frozen_string_literal: true

namespace :docker do
  image = 'iliiillilillllliiiilllilllilll/shrtbred'

  git_commit = `git rev-parse --short HEAD | tr -d '\n'`
  git_tag = `git describe --tags --abbrev=0 --exact-match 2>/dev/null | tr -d '\n'`

  task :build do
    sh "docker build --tag #{image}:latest --target app ."
    sh "docker build --tag #{image}-nginx:latest --target nginx ."

    sh "docker tag #{image}:latest #{image}:#{git_commit}"
    sh "docker tag #{image}:latest #{image}:#{git_tag}" unless git_tag.empty?
    sh "docker tag #{image}-nginx:latest #{image}-nginx:#{git_commit}"
    sh "docker tag #{image}-nginx:latest #{image}-nginx:#{git_tag}" unless git_tag.empty?
  end

  task start: :build do
    sh 'docker-compose up -d --build'
  end

  task :stop do
    sh 'docker-compose down -v --remove-orphans'
  end

  task push: :build do
    sh "docker push #{image}:latest"
    sh "docker push #{image}:#{git_commit}"
    sh "docker push #{image}:#{git_tag}" unless git_tag.empty?
    sh "docker push #{image}-nginx:latest"
    sh "docker push #{image}-nginx:#{git_commit}"
    sh "docker push #{image}-nginx:#{git_tag}" unless git_tag.empty?
  end
end
