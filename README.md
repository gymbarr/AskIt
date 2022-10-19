# Project Name
> A simple application for getting answers for exciting you questions
> created with Ruby on Rails and Bootstrap
> Live demo [_here_](https://oyster-app-rnsx2.ondigitalocean.app/). <!-- If you have the project hosted somewhere, include the link here. -->

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Screenshots](#screenshots)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)
<!-- * [License](#license) -->


## General Information
This application is a minimalistic version of (https://stackoverflow.com/) web-resource directed not only for programming theme but for everything.


## Technologies Used
- Ruby on Rails - version 6.0.5
- Bootstrap - version 5
- PostgreSQL - version 14
- Redis - version 7


## Features
- Infinit scrolling pagination with Hotwire and Turbo
- Sending emails to users as background jobs using Redis and Sidekiq
- Nested answers and comments with vote up/down feature
- Roles for users and administration GUI using Rolify and ActiveAdmin gem
- Subscribing to categories and notification users by email about new questions


## Screenshots
![Example screenshot](./img/screenshot.png)
<!-- If you have screenshots you'd like to share, include them here. -->


## Prerequisite

- **Ruby 2.7.5**
- **Rails 6.0.5**
- **PostgreSQL** database for ActiveRecord
- **Redis** server for Sidekiq
- **Node.js 16.15**


## Getting Started

- **Clone the repo from github**

        $ git clone https://github.com/gymbarr/AskIt.git

        $ cd AskIt

        $ bundle install

        $ yarn install

- **Setup database credentials as shown in the ActiveRecord section this next command or create the database manually**


        $ rails db:create

- **Run the migrations**

        $ rails db:migrate

- **After setting configurations below**

       $ rails server

- **Viewing in the browser**

       http://localhost:3000

## Setup
What are the project requirements/dependencies? Where are they listed? A requirements.txt or a Pipfile.lock file perhaps? Where is it located?

Proceed to describe how to install / setup one's local environment / get started with the project.


## Usage
How does one go about using it?
Provide various use cases and code examples here.

`write-your-code-here`


## Project Status
Project is: _in progress_ / _complete_ / _no longer being worked on_. If you are no longer working on it, provide reasons why.


## Room for Improvement
Include areas you believe need improvement / could be improved. Also add TODOs for future development.

Room for improvement:
- Improvement to be done 1
- Improvement to be done 2

To do:
- Feature to be added 1
- Feature to be added 2


## Acknowledgements
Give credit here.
- This project was inspired by...
- This project was based on [this tutorial](https://www.example.com).
- Many thanks to...


## Contact
Created by [@flynerdpl](https://www.flynerd.pl/) - feel free to contact me!


<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->
