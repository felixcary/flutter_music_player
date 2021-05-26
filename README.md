# music_player

A new Flutter project to play music using iTunes API.

## Getting Started

This application has been tested on Android Redmi 9 (Android 10, MIUI 11) and iPhone XR (iOS 14.5).


Minimum Requirement:
- Android SDK 16 (Android 4.1)
- iOS 9.0 

Recommended Requirement:
- Android SDK 27 (Android 8.1)
- iOS 13

Supported Feature:
- Search Artist, Song, or Album and show the result list
- Play music when select the song
- Play, pause, move to previous song, move to next song, drag (seek) song duration from music control
- Unit Test including API Service test and view model test

Architecture using MVVM with route

Library used:
- GetX for reactive state management, dependency injection and network request https://pub.dev/packages/get
- Assets audio player for audio player https://pub.dev/packages/assets_audio_player

Instruction to build and run app:
- download the project and open using visual studio code
- go to pubspec.yaml and run "flutter pub get" to download required library
- run it on simulator or real device
