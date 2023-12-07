# Server Documentation
## Swift version
The server runs on Swift 5.8.1 for package and deployment compatability.

## Deployment
The server is deployed at : https://edeposit-backend-aa3d55395f8f.herokuapp.com/ with Heroku and a PostgreSQL database. Opening this link gives access to the admin panel.

## Running Locally
1. To begin, clone the `Silenceisgolden_servercode` repository.
2. Create a PostgreSQL database called `edeposit_bag`. Ensure that the default user and password match the parameters as defined for the local connection im the configure.swift file.
3. Run the application.

## Features:

- Admin panel at root index
  - Functionality to message cashiers with tasks or feedback by DUID

## Endpoints:
- get messages by DUID
- Delete message by message ID
- Add message with a json payload 
- Fetch the json of selectors for tha app
                                                        
