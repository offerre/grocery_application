# grocery_application

A Grocery application

# Sample

!()[https://github.com/offerre/grocery_application/blob/main/screenshots/sample_1.gif]
!()[https://github.com/offerre/grocery_application/blob/main/screenshots/sample_2.gif]
!()[https://github.com/offerre/grocery_application/blob/main/screenshots/sample_3.gif]

# **Project Setup**

## Getting Started

Once Flutter is installed, open your IDE of choice and run the following commands.

```bash

# Download all dependencies
flutter pub get

# use code generation for dependency injections and generating data classes.
dart run build_runner build --delete-conflicting-outputs 
# OR
dart run build_runner watch

# Run application on sit2 env
flutter run lib/main.dart
# OR
flutter run

# Run local lint test
flutter analyze

```

Instead of the `flutter run` command, Flutter can also be run directly from your IDE without using the command line. This enables better debugging support as well as other Flutter tools. 
https://docs.flutter.dev/development/tools/android-studio

# Folder Structure

## Root Directory

**/lib** is the place where all Dart source code lives.

**/ios** contains platform-specific Swift code for ios.

**/android** contains platform-specific Kotlin code for Android.

**/assets** is where we keep our static files like icons, images, fonts, etc.

## lib Directory

**/data** contains all data-layer related code like the DTO models, and the repositories.

**/di** injected modules. Modules are how we register third-library dependencies to be injectable by the **injectable** library.

**/presentaiton** contains all pages and their bloc.

**/utils** as the name implies. 

# third-library

- [bloc](https://pub.dev/packages/bloc)

- [freezed](https://pub.dev/packages/freezed)

- [injectable](https://pub.dev/packages/injectable)

- [retrofit](https://pub.dev/packages/retrofit)

- [isar](https://pub.dev/packages/isar)

- [infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination)

# Recommended Resource & Materials

- [Flutter Youtube channel](https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw)

- [Flutter Documentation](https://docs.flutter.dev/)

- [Dart Documentation](https://dart.dev/guides)

- [What are **Mixins**?](https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3)

- [What are the differences between **Mixins** and **Base Classes**?](https://medium.com/flutter-community/mixins-and-base-classes-a-recipe-for-success-in-flutter-bc3fbb5da670)

- [Data classes and immutable objects with **freezed**](https://levelup.gitconnected.com/flutter-dart-immutable-objects-and-values-5e321c4c654e)

- [**Bloc** State management](https://bloclibrary.dev/)