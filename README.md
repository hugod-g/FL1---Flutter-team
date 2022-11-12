# MonPetitEntretien

This is an Flutter application available on iOS, Android and Web.
This app is using the service of the API to make the user able to create their account and manage their vehicles and maintenances to have an overview on their expenses. He will be able to manage his fleet and also customise his profile, or manage other users if he's an admin.

## Run the project locally

First you will have to setup Flutter on your machine: https://docs.flutter.dev/get-started/install.

To run this project locally on mobile, open any simulator (for iOS) and emulator (for Android) or plug your device. Then run this command:

```
flutter run
```

To run this project locally on web, run:

```
flutter run -d chrome
```

## Architecture if the project

At the root of the project, you will find different folders:

- **android, ios, macos, linux, web** : native folders different platforms apps.
- **maquette**: contains the UI design file.
- **test**: contains all the tests for the application
- **fonts**: contains all the fonts you can find in the app.
- **assets**: contains all the local assets you can find in the app.
- **lib**: contains the app.

In the lib folder, you will find the content of the application in this architecture:

- **class**: all the class in the apps.
- **components**: all the components composing the app. You will find shared and feature specific components.
- **config**: constants and configurations of the app such as endpoints url...
- **page**: contains all the different pages of the application, for the mobile and web also.
- **services**: contains all the api calls to the api.
- **style**: contains some global app style variables such as colors, fonts...

## Library used

For this project, we used different libraries: 

- **camera**(0.10.0+4): to use the camera of the phone / webcam to capture photo of vehicle, or profile.
- **cupertino_icons**(1.0.2): for some icons from Apple design system.
- **http**(0.13.5): to make http request to the api.
- **http_parser**(4.0.2): to parse more easily api response and handle the data.
- **image_picker**(0.8.6): to use the user image gallery to create a vehicle of the profile picture.
- **intl**(0.17.0): to handle more easily dates in the app.
- **provider**(6.0.4): global state managment in the app to make the data more easy to access in every pages.
- **shared_preferences**(2.0.15): to store some data in the storage of the user phone/navigator to be able to retrive some important data such as the bearer token.










