# merchant-payments

Payment System Task - A system to allow merchants to take payments using a single point and doing other functionalities like refund, authorize, charge etc.

## Requirements

- Ruby - 3.0.2
- Rails - 6.1.4.4
- Postgresql - 9.6.1

## Installation

- Clone this repository.
- Install all the necessary dependencies using the bundler.
  ```
  bundle install
  ```
- Create a database for the application using:

  ```
  bundle exec rake db:create
  ```
- Now start your rails application using:

  ```
  rails server
  ```
  
- Run tests using:

  ```
  rspec spec
  ```

## Important taks

### Importing merchants from CSV
```rake merchants:import_from_csv[file_url]```

### Delete transactions older than 1 hour
```rake transactions:destroy_stale```

