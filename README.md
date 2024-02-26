# Parking Application

This is a parking application created by Leo Magsino.

Technologies
* Ruby on Rails
* MongoDB

Project Directory
* Controllers (app/controllers) - handler of requests from user.
* Models (app/models) - Business data and all Mongoid related codes.
* Services (app/services) - Business logic.
* Utilities (app/utilities) - utility codes that can be used across the application.

Software Requirements
* rails 7.1.3.2
* ruby 3.0.3

Setup
* Install the software requirements
* Database is managed by Mongodb Atlas. Url is provided below and this already allowed all requests to have access
* Update mongoid.yml with the database url
  * development/clients/default/uri: mongodb+srv://admin:admin@cluster0.3cwdqqf.mongodb.net/parking_system_development?retryWrites=true&w=majority 
* Run `rails s` to start the application
