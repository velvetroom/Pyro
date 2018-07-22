# Clean Architecture

![iOS](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift](https://img.shields.io/badge/Swift-4.2-blue.svg)
[![Build Status](https://app.bitrise.io/app/04e42b095f2aed11/status.svg?token=7ZlxOD8DBPw6ho39Xb9CRw&branch=master)](https://app.bitrise.io/app/04e42b095f2aed11)

1. [Description](#description)
2. [Rationale](#rationale)
3. [Motivation](#motivation)
4. [Applicability](#applicability)
5. [Structure](#structure)
6. [Implementation](#implementation)
7. [Demo](#demo)

## Description

Clean Architecture is a Framework that will help create a separation of concerns in your application;
it is greatly inspired by Uncle Bob's _Clean Architecture_. You can find more about it at [The Clean Code Blog](http://blog.cleancoder.com)

### Framework

**Design reuse over code reuse**
- Predefines the design parameters so that the implementers can concentrate on the specifics of the application.
- Defines the overall structure, its partitioning into classes and objects, the key responsibilities thereof, how the classes and objects collaborate, and the thread of control.
- It's *not* meant to help you write less code, it's meant to help you have a unified code base design.

## Rationale

Separating the concerns of your application on different layers according to their responsibilities will enable you to embrace change and have a software structure more flexible.

Your application details (the user interface for example) should depend on your business logic and not the other way around.

Having a concise and cohesive design across your application can help boost productivity, refactoring and maintenance in general.

## Motivation

There are many ways to structure an application and if the overall architecture is not implicit from the beginning developers could end creating different structures for different features of the project.

While having different architectures in an application doesn't harm directly the functionality in itself it can definitely harm the maintenance and make it difficult to refactor or allow changes in general.

Without refactoring the code starts to rot and decay.

Without changes you cannot implement new features or modify existing ones.

Deciding what architecture you should implement in your project is difficult at the beginning, because most of the time the project evolves with the code itself and before starting to code there is little information on the inner workings of the application hence little is known of how it should be designed.

Deciding for very complex and rigid architecture since the beginning could lead your project to a dooming failure; the more complex the architecture more difficult to implement and even the slightest change requires a big effort creating boiler plate like protocols and delegates that are little meaningful for a small project.

On the other hand, deciding for a very basic o no architecture at all could be useful at the beginning but once the project starts to grow the architecture will reach its limit and wear off.

This lead us to the big question: What could be a good architecture than can be used for a small project but will also support it growing to big and complex one?

## Applicability

Any application written in Swift targeting iOS 9 or higher.

It doesn't matter if your application consists of just one screen or several dozens. Clean Architecture is perfect for big and modularized projects, but it's boiler plate foot print is so low than even the simplest application can benefit from implementing it.

Ideally for new projects, but it is also possible to implement it in an existing application by an in-depth refactoring.

Monolithic and modularized projects can benefit from Clean Architecture.

## Structure

Clean Architecture follows the [Dependency Inversion Principle](https://cleancoders.com/episode/clean-code-episode-13/show).

Lower level policies depend upon higher level policies, and higher level policies are able to communicate to lower level ones through the use of interfaces or protocols.

The highest level policy is your application domain or in other words the business logic.

The lowest level policy is your user interface, i.e. labels, buttons, images, etc.

<img src="https://raw.githubusercontent.com/velvetroom/clean-architecture/master/Design/dependencies.png" width="750" alt="Structure" />

## Implementation

### Install

You can get Clean Architecture with **CocoaPods**.

Add to your Podfile

```
pod 'CleanArchitecture'
```

Install and download

```
> pod install
```

If you are wondering what is CocoaPods take a look at: [https://cocoapods.org](https://cocoapods.org)

### Interactor

Interactors are the higher level layer in Clean Architecture, that is, the closer to your business level.

They should know nothing about the user interface or how it is displayed to the user.

They should depend (know everything or import) on your business layer.

In a new file import Clean Architecture

```
import CleanArchitecture
```

Create a class that implements InteractorProtocol and add the required boiler plate:

```
class Interactor:InteractorProtocol {
    weak var router:UINavigationController?
    weak var presenter:InteractorDelegateProtocol?

    required init() { }
}
```

- `router` A weak reference to the object in charge of presenting views in you Application, the Navigation Controller for example.
- `presenter` A weak reference to the InteractorDelegate; this is the only communication going from the Interactor to the Presenter, the Interactor notifies the Presenter when it should update the presentation.
- `required init` Initialize any property that you need or leave it empty if none.

### Presenter

Presenters are in charge of how to interpret your application data so it can be displayed to the user.

Should depend on Interactor and know nothing specific about the View.

They communicate to the View via the ViewModel.

In a new file import Clean Architecture

```
import CleanArchitecture
```

Create a class that implements PresenterProtocol and add the required boiler plate:

```
class Presenter:PresenterProtocol {
    var viewModel:ViewModel!
    var interactor:Interactor!

    required init() { }
}
```

- `viewModel` The object defining how the view should look and what content to display. Presenter edits ViewModel and View gets notifified of a change, then View can update the change accordingly for the user.
- `interactor` Presenter is the owner of the interactor.
- `required init` Initialize any property if needed.

### View

View is in charge of the user interface layer and is also carrying the heavy weight of your application architecture.

Should know everything about Presenter, ideally only interact with it and no other layer in your application should depend on View, i.e. this is the front line to the user and the lower level of abstraction.

Applications in iOS usually consist of transitions between view controllers and most of the time there is only one of these active.

When your View is instantiated it creates instances of your Presenter, Interactor and a ViewModel, connects them accordingly and assigns them their responsibilities.

If your View gets released also your Presenter, Interactor and ViewModel will be released.

You can abstract each View as a section or screen in your application. You should create a View for each section, each View will have their own ViewModel, ideally they will also have their own specific Presenter. Interactors can be shared or could also be specific for each section.

View inherits from UIViewController.

In a new file import Clean Architecture

```
import CleanArchitecture
```

Create a new class that inherits from View.

View is a Generic class that needs to be specialized with a class conforming to PresenterProtocol and a UIView.

```
class DemoView:View<Presenter, UIView> { }
```

- `Presenter` Your class conforming to PresenterProtocol
- `UIView` You can define what UIView should be used in the UIViewController, you could pass the default UIView or create your own subclass. Whatever class you assign here will be available as `content` property on your View.

### ViewModel

The structure of information that will be presented to the user.

You don't create a ViewModel, Presenter has a ViewModel already and you rather create as many 'properties' as your View needs. A property is an structure conforming to the ViewModelProtocol.

Presenter is in charge of updating the properties whenever it is needed. Every property can have an observer which will be notified via a closure when the property changes; ideally this observer would be your View.

You can define anything that you need in a property from basic types like Bool or String, to more complex ones like UIColor or UIImage or even your own structures.

You can also decide if your properties are optional or not.

In a new file import Clean Architecture

```
import CleanArchitecture
```

Create a new structure that implements ViewModelProtocol.

```
struct ContentViewModel:ViewModelProtocol {
    var userName:String
    var buttonEnabled:Bool
    var buttonColor:UIColor?
    var icon:UIImage?

    init() {
        self.userName = String()
        self.buttonEnabled = false
    }
}
```

#### Updating the ViewModel

Your Presenter is in charge of updating the ViewModel and you can decide when to do it, it can be done on any thread as it is thread safe.

In your Presenter class

```
func update(userName:String) {
    var property:ContentViewModel = ContentViewModel()
    property.userName = userName
    self.viewModel.update(property:property)
}
```

And that's it, ViewModel will take care of updating the listener if there is any.

#### Listening for ViewModel updates

Usually you want your View to listen for ViewModel updates.

Listening to updates is thread safe, it doesn't matter if your Presenter is updating in a background thread you will always be notified on the Main thread.

In your DemoView class

```
func listenToUpdates() {
    self.presenter.viewModel.observe { [weak self] (property:ContentViewModel) in
        self?.title = property.userName
    }
}
```

## Demo

Clone or download this repository, it contains a simple Demo application that will help you have a clear vision of how to implement Clean Architecture.
