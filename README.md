# MOVIES ASD

## Overview

The goal of this project is to create a simple movies app that allows users to see a list of movies, search for movies, view movie details, and save them as favorites using The Movie DB API.

## How to run the project

#### Developer Environment Requirements

- Go to [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install) (Dart needs to be at least 3.6.0)

- Extract the file in some location (e.g., C:\flutter en Windows)

- Following the windows example go to "Environment variables". Add C:\flutter\bin to Path and then restar your terminal

- Run `flutter --version` to verify the installation

### Steps to run the project

1. Run `git clone https://github.com/DavidAriza/MoviesASD.git` or download the project as Zip and extrac all in your desired folder.

2. Open [api_constants.dart](./lib/core/constants/api_constants.dart) file and specify the token.

3. Run `flutter devices` and check the id (2nd column) of the device you want to run it

4. Run `flutter run -d <device id>` to start the project in an emulator or a real device 

## Technical considerations

Clean Architecture ensures a clear separation of concerns by organizing the code into distinct layers: Presentation (UI & state management), Domain (business logic & use cases), and Data (repositories & data sources).

flutter_bloc is used to manage state because it is robust and easy to test, thanks to the bloc_test package.

Hive serves as a local database solution for storing favorite movies. It is fast, lightweight, and non-relational, making it perfect for our use case.

cached_network_image is crucial for improving performance when loading lists of elements with images.

dartz package for better error handling – Either<Failure, Success> helps return failures or results instead of just throwing exceptions.

## Features

✅ Movies List Page

✅ Search Movie

✅ Movie Details

✅ Sharing Movie Recommendations (via Platform Channels – Android only)

✅ Mark/Unmark as Favorite

✅ Favorite List Page
