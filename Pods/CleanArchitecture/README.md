# Clean Architecture

![iOS](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift](https://img.shields.io/badge/Swift-4.2-blue.svg)
[![Build Status](https://app.bitrise.io/app/04e42b095f2aed11/status.svg?token=7ZlxOD8DBPw6ho39Xb9CRw&branch=master)](https://app.bitrise.io/app/04e42b095f2aed11)



## Description

Clean Architecture is a Framework that will enable a clean separation of concerns in your iOS app;
it is greatly inspired by Uncle Bob's Clean Architecture [Uncle Bob](http://blog.cleancoder.com)



## Rationale

Separating the concerns of your app on the different layers according to their responsibilities will enable you to embrace change and
have a software structre more flexible.



## Motivation

Is common among developers to have the misconception that the structure of an app should be designed before it starts the development
process, even more, there is a trend to consider that this structure should be designed in a way that will enable any new feature to be
added to the app but not changing the structure itself.

These misconception lead to either a pre-design stage that can last ages and will endup with an overengineered structure, hence will make
changes really hard to apply or it will be a very fragile structure where any simple change can lead to many different parts of the system
to break and in need of corrective refactoring.



## Implementation

By dividing your project into different layers you will be able to have a clear separation of concerns.



### Architecture overview

-View

-ViewModel

-Presenter

-Interactor

-{ Business models }



### Architecture dependencies

-ViewModel

--Just a data structure

-View

--Depends on (knows about)

---Presenter

---ViewModel

--Ignores (knows nothing about)

-Presenter

--Depends on (knows about)

---Interactor

---ViewModel

--Ignores (knows nothing about)

---View

-Interactor

--Depends on (knows about)

---{ Business models }

--Ignores (knows nothing about)

---Presenter



# Install

You can get CleanArchitecture easily with CocoaPods.

Add to your Podfile
```
pod 'CleanArchitecture'
```
Run installation
```
> pod install
```
If you are wondering what is CocoaPods take a look at: [https://cocoapods.org](https://cocoapods.org)


# Demo

Clone or download this repo, it contains a simple Demo App that will help you have a clear vision of how to adapt Clean Architecture to your project


