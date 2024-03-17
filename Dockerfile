# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Curl
RUN apt-get install -y curl

# Import Yarn's repository GPG key and add the repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update package lists to include Yarn's repository and install Yarn
RUN apt-get update && apt-get install -y yarn

# Set the working directory inside the container
WORKDIR /book-collection-app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /book-collection-app/Gemfile
COPY Gemfile.lock /book-collection-app/Gemfile.lock

# Install the gems
RUN bundle install

# Copy the main application
COPY . /book-collection-app

# Expose the port the app runs on
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
