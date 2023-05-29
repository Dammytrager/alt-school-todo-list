# Use the official Ruby base image
FROM ruby:3.0.0

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN bash -c "set -o pipefail && apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl git libpq-dev \
  && curl -sSL https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean"

# Install bundler
RUN gem install bundler -v '~> 2.2'

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile* ./
# Install project dependencies
RUN bundle install

# Copy Package.json and Packagelock.json
COPY package.json yarn.lock ./
# Install project dependencies
RUN yarn install

# Copy the rest of the application code to the container
COPY . .

# Precompile assets
RUN rails assets:precompile

# Expose port 3000 (or the port your Rails app is configured to use)
EXPOSE 3000

# Set the command to start the Rails server
CMD echo $DB_USER && \
    rails db:migrate && \
    rails server -b 0.0.0.0