# Arkency iOS application

Simple application which shows what can be achieved in RubyMotion in 7 days, without having much knowledge about iOS at all.

## Building:

To build this app, you need to provide environmental variables which are listed in `.env.example` file. You can provide it in `rake` command each time, or use [dotenv](https://github.com/bkeepers/dotenv) for this. This project fetched dotenv variables from `.env` file that you should create by yourself.

After this build procedure is simple:
```
bundle exec rake pod:install
bundle exec rake # for iOS simulator build
```
