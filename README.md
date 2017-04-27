# README

Features

The application allows you to log in through Twitter and send twitts with images to Twitter.

Installation

$ git clone git@github.com:Navarrskij/mytwitt.git

$ cd mytwitt/

$ bundle

$ mv /config/database.yml.sample /config/database.yml

$ rake db:create

$ rake db:migrate

$ mv /config/secrats.yml.sample /config/secrets.yml


After that you will need to head to https://apps.twitter.com/ and setup a new application. To do that you have to click on the 'Create New App'.

Write your keys in secrets.yml:

twitter_app_id: your_twitter_app_id

twitter_app_secret: your_twitter_app_secret

consumer_key: your_consumer_key

consumer_secret: your_consumer_secret

access_token: your_access_token

access_token_secret: your_access_token_secret


$ rails s

Go to http://localhost:3000/, sign in with your twitter account and go twitts!!

