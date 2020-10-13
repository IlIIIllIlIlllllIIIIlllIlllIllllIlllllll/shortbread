FROM ruby:2.7.2-alpine as app

LABEL maintainer="https://github.com/IlIIIllIlIlllllIIIIlllIlllIllllIlllllll"

# set shrtbred user/user-id/group-id
ENV USER=shrtbred
ENV USER_ID=1000
ENV GROUP_ID=1000

# create shrtbred non-root user
RUN addgroup -g ${GROUP_ID} ${USER}
RUN adduser -D -g '' -u ${USER_ID} -G ${USER} ${USER}

# create shrtbred installation path
ARG INSTALL_PATH=/shrtbred
RUN mkdir -p ${INSTALL_PATH}

# change working directory to shrtbred installation path
WORKDIR $INSTALL_PATH

# add packages necessary to build Rails app
RUN apk add \
  build-base \
  git \
  nodejs \
  postgresql-dev

# copy over Gemfiles to installation path
COPY Gemfile* $INSTALL_PATH/

# configure bundler gemfile, parallel jobs, and bundle path
# https://bundler.io/man/bundle-config.1.html
ENV BUNDLE_GEMFILE=$INSTALL_PATH/Gemfile
ARG BUNDLE_JOBS=4
ENV BUNDLE_PATH=/gembox/bin
ENV PATH=${BUNDLE_PATH}:${PATH}

# install the dependencies specified in your Gemfile
RUN bundle install

# copy over the rest of the application files
COPY . .

# precompile the static assets
# https://guides.rubyonrails.org/asset_pipeline.html#precompiling-assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# change owner of installation path to shrtbred user
RUN chown -R ${USER}:${USER} ${INSTALL_PATH}

# expose rails port
EXPOSE 3000

# add docker-entrypoint.sh to the image
COPY docker-entrypoint.sh /docker-entrypoint.sh

# change current user to shrtbred non-root user
USER ${USER_ID}

# set entrypoint to /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# execute rails server to serve application
CMD [ "bundle", "exec", "puma" ]

FROM nginx:1.19.3-alpine as nginx

# copy precompiled static assets from app stage
COPY --from=app /shrtbred/public /shrtbred/public

# copy nginx configuration and ssl files over
COPY nginx/* /etc/nginx/

# expose 80 and 443
EXPOSE 80 443

# reset the entrypoint
ENTRYPOINT []

# set command to not run nginx as a daemon, run nginx in the foreground
CMD [ "nginx", "-g", "daemon off;" ]
