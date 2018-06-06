FROM heroku/heroku:16

# Sets the working directory (Heroku crashes without it)
WORKDIR /

# Copy Sinatra app into container
ADD app.rb app.rb

# Install Sinatra gem
RUN gem install sinatra --no-ri --no-rdoc

# Start Sinatra
CMD ["ruby", "app.rb"]
