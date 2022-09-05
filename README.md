# iOS Challenge

## Goal

The goal of this project was to create an app that access an API and show information about TV series. ALL the mandatory features and bonus features were accomplished! 

The app contains the following main modules:

- Authentication (PIN Screen)
- TV Show List
- TV Show Detail
- Episode List
- Episode Detail
- Favorite Episode List
- Search Feature by Actors and TVShows


The App Architecture is based on VIP Clean Arch. Each module has the following components:

View: responsible for view (UIKit) specific logic
ServiceAPI: responsible comunicate with network/core service
Interactor: Responsible for business logic and 
Presenter: Responsible for presentation logic
Configurator: is the entry point of each module. Responsible to instantiate the viewController and inject all the module dependencies.  


## Project minimum requirements:

- MacOS Monterey 12.3.1 +
- iOS 15 +
- Swift 5 +
- XCode 13.3

## Project Dependencies:

This project runs using 3rd party code libraries managed by Cocoapods, to install
it you must:

- **sudo gem install Cocoapods**

in the root folder of the project:

- **pod install**

Installed Pods:

- **SDWebImage**: cache image data and improve the user experience;
- **SnapshotTesting**: build powerful UI Tests! ;

Run the new **JobCityFlix.xcworkspace** file.

## About the Project

All API calls are handled on the generic request in ServicesAPI.swift.  

The design of the application were inspired on Netflix APP.  

To store the information about the user's Favorte Shows it was used **CoreData**.

## Unit Tests


All the module layers has isolated united tests. Since our ViewControllers does not have any logic (business/network/coredata/presentation), is really safe to test them with powerful SnapShot tests and also our UIView components. 

The next step to this project is to separe each kind of test in specific modules. It's not good to run integrated tests (coredata and snapshot) with our core domain tests (interactor, presenter, services).

All the screens are 100% viewcoded. 

All the modules are following the SOLID principles, so it's pretty easy to main, extended and test them in isolation. 
