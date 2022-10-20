# AskIt
A simple application for getting answers for exciting you questions.

Created with Ruby on Rails and Bootstrap.

> Live demo [_here_](https://oyster-app-rnsx2.ondigitalocean.app/).

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Prerequisite](#prerequisite)
* [Getting Started](#getting-started)
* [Configurations](#configurations)
* [Sending emails](#sending-emails)
* [Roles and Administration](#roles-and-administration)
* [Project Status](#project-status)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)


## General Information
This application is a minimalistic version of (https://stackoverflow.com/) web-resource directed not only for programming theme but for everything.


## Technologies Used
- Ruby on Rails - version 6.0.5
- Bootstrap - version 5
- PostgreSQL - version 14
- Redis - version 7


## Features
- Infinit scrolling pagination with Rails Hotwire and Turbo
- Sending emails to users as background jobs using Redis and Sidekiq
- Nested answers and comments with vote up/down feature
- Roles for users and administration GUI using Rolify and ActiveAdmin gems
- Subscribing to categories and notifying users by email about new questions


## Prerequisite

- **Ruby 2.7.5**
- **Rails 6.0.5**
- **PostgreSQL** database for ActiveRecord
- **Redis** server for Sidekiq
- **Node.js 16.15**


## Getting Started

**Clone the repo from github**

        $ git clone https://github.com/gymbarr/AskIt.git

        $ cd AskIt

        $ bundle install

        $ yarn install

**Create `.env` file in the root folder of the project and past to it content of the `.env.example` file**

**Setup database credentials as shown in the ActiveRecord section this next command or create the database manually**

        $ rails db:create

**Run the migrations**

        $ rails db:migrate

**After setting configurations below**

       $ rails server

**Viewing in the browser**

       http://localhost:3000

## Configurations

### ActiveRecord

Set credentials for your database by filling variables with blank values under `# database PostgreSQL variables`

```env
# .env
# database PostgreSQL variables

DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=
DB_PASSWORD=
DB_RAILS_MAX_THREADS=5
DB_NAME_DEVELOPMENT=askit-db-development
DB_NAME_TEST=askit-db-test
DB_NAME_PRODUCTION=askit-db-production
```

### Action Mailer

Set credentials for your mailing server by filling variables with blank values under `# mailer variables`

```env
# .env
# mailer variables

ACTION_MAILER_DELIVERY_METHOD=smtp
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_SECURED_PASSWORD=
SMTP_AUTHENTICATION=plain
```


## Sending emails

The application maintain notifications by email sending for some scenarios:
- Some user subscribed to the category. When other users create questions in this category the subscriber receive notifications;
- Some user got reply to his subject (question, answer, comment). The repliable user will receive a notification.

To turn on notifications by emails you need first to configure SMTP settings as shown in the Action Mailer section.

Sending emails perfoms in background jobs using Redis database and Sidekiq worker. So, the next step is to start these services

Start Redis server, for example, using homebrew:

        $ brew services start redis

Make sure the rails server is running, start Sidekiq with necessary queues in parameters:

        $ bundle exec sidekiq -q kickers_notifiers -q runners_notifiers


## Roles and Administration

The application has two types of roles:
- basic user (add to every user after sign up)
- admin user

Add admin role to user:

```ruby
user = User.find(1)
user.add_role Role.admin_user_role
```

Admin users has acces to administration GUI:

        http://localhost:3000/admin

And to Sidekiq web interface:

        http://localhost:3000/sidekiq


## Project Status
Project is: _complete_


## Acknowledgements
Many thanks to [@romatehanov](https://github.com/romatehanov) for supporting and code review


## Contact
Created by [@Andrey Timakhovich](https://www.linkedin.com/in/andrey-timakhovich-5a2429169/) - feel free to contact me!
