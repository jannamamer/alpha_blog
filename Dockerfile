FROM ruby:2.7.2

RUN echo "Installing bundler" \ 
      && gem install bundler --version 2.1.4

RUN echo "Installing dependencies" \
      && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update \
      && apt-get install -qq -y graphicsmagick postgresql-client build-essential nodejs yarn --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed to inside of the Docker image.
ENV LANG C.UTF-8
ENV BUNDLE_PATH /bundle
ENV INSTALL_PATH /alpha_blog
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

ADD . $INSTALL_PATH
