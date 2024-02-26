# Parking Application

Welcome to the Parking Application created by Leo Magsino. This application provides a seamless solution for managing parking lots, slots, and vehicle parking/unparking using Ruby on Rails with MongoDB integration.

## TECHNOLOGIES
* Ruby on Rails: Framework for web application development.
* MongoDB: A NoSQL database used for storing parking lot data.

## PROJECT DIRECTORY
* Controllers (app/controllers): Responsible for handling user requests.
* Models (app/models): Contains business data and all Mongoid related codes.
* Services (app/services): Implements business logic.
* Utilities (app/utilities): Houses utility codes reusable across the application.

## SOFTWARE REQUIREMENTS
* rails 7.1.3.2
* ruby 3.0.3

## SETUP
1. Install Software Requirements: Make sure to have Rails and Ruby installed.
2. Database Configuration:
   * Database is managed by MongoDB Atlas. The URL is provided below and is configured to allow all requests.
   * Update mongoid.yml with the provided database URL under the development environment.
   * development/clients/default/uri: `mongodb+srv://admin:admin@cluster0.3cwdqqf.mongodb.net/parking_system_development?retryWrites=true&w=majority`

* Install Dependencies: Run `bundle install` to install required gems.
* Start Application: Execute `rails s` to start the application.

## TESTING
* Tool: Use Postman to test the application endpoints.
* Import the collection of requests into Postman. The file 'parking.json' is included in this repository.
* Below are the descriptions of each request for testing:

### Parking Lot
* `Retrieve default parking lot`: Fetches data of the pre-loaded default parking lot.
* `Update default parking lot`: Updates data of the pre-loaded default parking lot.
* `Retrieve entry points`: Retrieves entry points of the pre-loaded default parking lot.

### Parking Slot
* `Retrieve all parking slots`: Retrieves all parking slots in the database.
* `Remove parking slot`: Removes a parking slot by ID.
* `Create parking slots`: Adds parking slots.

### PARK
* `Park`: Automatically assigns a parking slot to a vehicle.
* Assigned location: Result includes the assigned location.

### UNPARK
* `Unpark`: Unparks a vehicle and computes the total amount.
* Total amount: Result includes the total amount.

Feel free to explore and utilize the features provided by the Parking Application. If you encounter any issues or have suggestions for improvement, please don't hesitate to reach out to the developer, Leo Magsino.


