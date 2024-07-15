# Loan App

Loan App allows users to create loan requests and receive PDF reports directly via email.

## Features
* Create loan requests in a multi step form
* Get system generated PDF reports reflecting loan request details accordin to the terms and conditions of the comapny via emal

## Prerequisites
* Ensure you have the following system dependencies installed on your machine:


- Ruby version: `3.1.3`
- Rails version: `6.1.0`
- System dependencies:
  - Ruby
  - Rails
  - Python
  - Node.js
  - Java
  - Redis

## Installation and Setup

### Clone the Repository

```sh
git clone https://github.com/de-ahsan/longleaf-lending.git

cd loan_app
```

### Database Setup
* Create the database:
```sh
bundle exec rails db:create
```
* Run database migrations:
```sh
bundle exec rails db:migrate
```

### Install Dependencies
```sh
bundle install
```

### Start Sidekiq
* Ensure you have Redis running before starting Sidekiq to handle background jobs.
```sh
bundle exec sidekiq
```

### Start the Rails Server
```sh
rails server
```

or
```sh
./bin/dev
```

### Running Tests
* To run the test suite, execute:

```sh
bundle exec rspec
```

