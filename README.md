# Recodam

## Project Structure

The project is divided into  layers

 - Data Layer
    - Local DB 
    - API Service
   
- Domain Layer 
    - repository

- Feature Layer
    - presentation/UI (widgets)
    - business logic (riverpod)


Each Layer has it's own function and jurisdictions 

the correct flow of data is represented in the list above


## Data Layer
This consists of the models folder, some services that would be represented later like database and shared prefs, api requests, serialization and deserialization, etc

## Domain Layer
This is the connection between the data layer and presentation layer 
the domain layer handles transmission to and fro the data layer

this consists solely of the repository folder, this is the handshake between the other two layers 

## Feature Layer
This is where all of our UI and it's related logic would be handled

this consists of the views, widgets and some config files 

## Packages and Functions

- flutter_riverpod : State management.
- flutter_screenutil : Responsiveness and adaptiveness.
- go_router : Declarative navigation.
- flutter_native_splash : Splash screen.
- dio : Networking.
- url_launcher: For launching a URL.
- flutter_native_splash: For displaying icon splash on launch.
- keyboard_dismisser: Hide keyboard when gestures are out of it.