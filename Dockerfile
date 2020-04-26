FROM ruby:2.5
MAINTAINER contact@jaimejazarenoiii.me

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /dos-covid
WORKDIR /dos-covid
COPY Gemfile /dos-covid/Gemfile
COPY Gemfile.lock /dos-covid/Gemfile.lock
RUN bundle install
COPY . /dos-covid

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
