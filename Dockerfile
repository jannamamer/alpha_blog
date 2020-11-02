FROM ruby:2.7.2

ARG APP_VERSION="0.0.1"
ARG APP_ROOT=/app

WORKDIR $APP_ROOT

RUN echo "Installing packages" \
      && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update \
      && apt-get install --no-install-recommends -y graphicsmagick postgresql-client nodejs yarn \
      && gem install rails

COPY . .

RUN echo "Installing gem and yarn packages" \
      && bundle install \
      && yarn install

EXPOSE 3000

# https://stackoverflow.com/questions/51584758/cannot-access-docker-ruby-on-rails-image-after-running
# Force Puma to listen to all interfaces with specific port
CMD ["rails", "s", "-b", "0.0.0.0", "--port", "3000"]
