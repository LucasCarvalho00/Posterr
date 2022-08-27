# Posterr

Example project created to test the combination of concepts applied in Swift technology.

##  Application Screenshots

<img src="https://user-images.githubusercontent.com/30445599/187040525-9a5f558f-e6f0-4509-90bc-f717b45ed3e2.png" width="200" height="395"><img src="https://user-images.githubusercontent.com/30445599/187040714-4c5e4ff7-c831-4f80-9301-c7c0c28badf6.png" width="200" height="395">
<img src="https://user-images.githubusercontent.com/30445599/187040531-19d9a12d-26cc-4b7e-a1d1-15086bdffaa9.png" width="200" height="395">
<img src="https://user-images.githubusercontent.com/30445599/187040546-0916a17d-f852-4c4e-86f3-996b632dabff.png" width="200" height="395">

##  Application Video

https://user-images.githubusercontent.com/30445599/187040757-c659b8e9-389f-4880-90ae-5ff7390e7e21.mp4

## Architectural base

This project uses MVVM as an architectural base.

![mvvm-pattern](https://user-images.githubusercontent.com/30445599/187041175-2fe7b8ac-b81a-414f-ba9c-2e3bb14f7a76.png)

Where each layer of the architecture has its responsibility defined.

### UseCases

* These are ways to query external data to Scena, whether in API, Database, etc.

### ViewModel

  * Single layer with the responsibility of knowing the UseCases.
  * Transforms the Responses received into models, treating the data
  * Contains the business rules
  * Forwards the data to the ViewController

### ViewController

  * Single layer that knows the View, ViewModel and FlowController.
  * It has the characteristic of being a layer of passages managing the flow of information within the scene.

### View

  * Layer containing Layout rules and states for each screen
  
### Vantages of Architecture:

  As the proposal of this architecture was that each layer had a well-defined function. the implementation of tests will be facilitated and the maintenance of the architecture as well.
  Since each module only expects one result to be loaded. I can, for example, change the way the networking layer makes HTTPS calls with minimal impact within the viewmodels, I can change data persistence, return mocks to do tests and etc. All this with minimal effort.

### Disadvantages of Architecture:

  As this project is based on Swininject, which is a dependency container registered in the application launcher, it means that, if I need to change who resolves protocol x or y within this container, I will not be able to without restarting the application.

## Application Modules

* App

AppDelegate, SceneDelegate and Info.Plist

* Foundation

The Foundation Layer is responsible for creating and making available to the application the basic resources for it to exist.

* DependencyInjection:

In order to uncouple ViewModels within ViewControllers, the Dependency Injecton layer registers and resolves all dependencies of all Application classes.

* FlowController:

Similar to a flow controller, the FlowController layer calls and manages application flows. With the crucial difference that the FlowController doesn't register any ViewController, it just asks for the instance to be resolved.

* Services

The Services layer is responsible for storing all the UseCases and Requests of the application, it is the only layer of the project that can know the Network and offers the ViewModel a way to consume APIs

* UIKit

Application UIKit layer, where all components and resources for creating Layouts are located.

* Scenes

All Scenes/Screens of the application.

## Protocol Oriented Programming - POP

A protocol defines a schema of methods, properties, and other requirements that fulfill a particular task or part of functionality. The protocol can then be adopted by a class, struct, or enum to provide an actual implementation of these requirements.

> Any type that satisfies the requirements of a protocol is considered to conform to that protocol.

### Positives:
* Any class that conforms to the same protocol can be a replacement in the constructor making it easy to replace layers!
* It will facilitate the implementation of unit tests
* Classes will only have knowledge of what is necessary for them to execute their steps.

### Negatives:
* Initial complexity.
* Borderplate.

**Documentation link:** https://docs.swift.org/swift-book/LanguageGuide/Protocols.html

## Scene state change

Scenes work as a "State Machine", where the view through the "setupUI" offers the possibility for the ViewController and ViewModel layers to change what is being displayed to the user.

![Captura de Tela 2022-08-27 às 15 09 40](https://user-images.githubusercontent.com/30445599/187042953-36be6281-62ab-4861-91be-2d7d4c704929.png)
![Captura de Tela 2022-08-27 às 15 09 34](https://user-images.githubusercontent.com/30445599/187042967-c88a33f9-6637-43df-b2c4-d5f30b94a6cb.png)

Let's see the example of Scene below:

![Captura de Tela 2022-08-27 às 15 10 46](https://user-images.githubusercontent.com/30445599/187043146-eb6ceff1-5e47-47d3-9cad-44af10b12b52.png)

We can already initially notice that the screen construction already reflects the states it has, this construction is important because it helps to avoid "Massive Classes", making the layout of each state is separated and organized by file, being called on demand.

When initiating the API call, the ViewModel already notifies that the screen needs to enter the Load state, which visually reflects to the user.

![Captura de Tela 2022-08-27 às 15 13 29](https://user-images.githubusercontent.com/30445599/187043156-3704326f-2141-4297-9910-38a58bd83a42.png)

And when receiving the result, if it is successful, it will update the user's layout again, showing the data received or it will show an error screen.

![Captura de Tela 2022-08-27 às 15 13 48](https://user-images.githubusercontent.com/30445599/187043160-a06defc8-d271-4775-8a12-c9c568ca5f8b.png)

## Design System

![Captura de Tela 2022-08-27 às 14 49 58](https://user-images.githubusercontent.com/30445599/187042107-98f0b8cf-19b1-4406-99cf-4369794ce2db.png)

### Which is?
Design System is a set of a company's design and content libraries created and maintained by the Design and Technology teams.

### Because it's important?
With all the components defined and implemented in our UIKit, we will be able to facilitate the creation of screens on a daily basis, respecting minimum qualities of work between them, for example: All buttons have the same size, all screens have the same lateral spacing, use the same sources for the same components

> In order to meet the expectations of the Design System creation, we built screens to use ViewCode and started implementing some components within our project.

Currently we have in the Design System:
* Definition of spacing metrics between objects
* Fonts and styles
* Color palette used by the project
* Some components already implemented
* Translations

## Network

When we create an application, we need to work with data. This data can come from some external source, for example an API.

However, they are returned in a different style: typically, as JSON. JSON stands for Javascript Object Notation, basically a lightweight format for exchanging information/data between systems.

The problem is that the Swift language cannot use, that is, it does not “understand” JSON data, as it is a textual format.

So we perform the conversion of this JSON data into some kind of data that we can use in Swift. Working with Codables

https://developer.apple.com/documentation/swift/codable

Codables conform to Decodables and Encodables protocols, each with its own particular property.

* Decodables are the types that we can transform JSON into Objects
* Encodables are the types that we can transform Objects into JSON

Below is an example of the Decodable type.

![Captura de Tela 2022-08-27 às 15 43 20](https://user-images.githubusercontent.com/30445599/187043962-bfe8f007-dbdb-443e-ac14-440b93b8042a.png)

But we still have a problem, we couldn't create a specific network layer per API call, so it would need to be generic to the point of accepting and knowing how to convert any JSON into any Decodable object within our project.

For this we use functions with Opaque Types in Swift

![Captura de Tela 2022-08-27 às 15 46 02](https://user-images.githubusercontent.com/30445599/187044117-f59e5f89-d328-4230-a450-421c26e8bc23.png)

Documentation link: https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html#:~:text=An%20opaque%20type%20refers%20to,that%20conforms%20to%20the%20protocol.

Where the Network protocol accepts any object "Represented by the T in the picture above" of type Decodable, this way it will know that any object delivered will have properties of type Decodable.

And for UseCase to know exactly which object it will receive, just inform the expected object in the protocol response above.

![Captura de Tela 2022-08-27 às 15 47 38](https://user-images.githubusercontent.com/30445599/187044128-9c4473cb-7ba7-4c0b-a74d-244c62450a9b.png)

## Modularization strategy

As a modularization strategy for this application, each layer of this project has only a single responsibility and to know its pre-marked peers.

We can see this concept more clearly being applied to the layers where protocols are injected at startup.

Taking the ViewModel as an example, within a Scena it is the only one that can know the Services layer, as it has direct contact with the UseCases.

But when receiving a response from the Service layer, it transforms this object into an internal object before sending it to the ViewController and then to the View.

This happens because if it were to directly pass the Response received from the Service layer forward, it would create the need for each layer that received this object to also know the Service layer.

With this type of strategy, we prevent layers from knowing only the parts that suit them in the project, removing dependency coupling and making it easier to replace layers.

## Test Project

The Test Project seeks to be a mirror of the main project's architecture, taking advantage of the condition that all project classes only know each other through an interface.

Tests are performed by overriding which layer implements interface X or Y to handle the expected result.

![Captura de Tela 2022-08-27 às 15 06 51](https://user-images.githubusercontent.com/30445599/187042714-05225d7a-e511-4d0e-b056-d85642df9c88.png)

As in the example above, where the UseCase receives a new layer of Network at its initialization, allowing its function to be executed without undergoing code changes and we have a controlled result

## Installed Pods:

### Swinject

**Link:** https://github.com/Swinject/Swinject

**Function:** Dependency Injection (DI) is a software design pattern that implements Inversion of Control (IoC) to resolve dependencies. By default, Swinject helps your application break down into loosely coupled components, which can be developed, tested, and maintained more easily. Swinject is built with the Swift generic type system and first-class functions to define your application's dependencies simply and fluently.

**How was it used?:** Swinject was a way to remove the coupling of ViewModels in ViewControllers, now all dependencies are registered and the application already knows what to inject in each screen flow.

### RxSwift

**Link:** https://cocoapods.org/pods/RxSwift

**Function:** Like other Rx implementation, RxSwift's intention is to enable easy composition of asynchronous operations and streams of data in the form of Observable objects and a suite of methods to transform and compose these pieces of asynchronous work.

**How was it used?:** In Network layers response to UseCases to ViewModels

### IQKeyboardManager

**Link:** https://github.com/hackiftekhar/IQKeyboardManager

**Function:** When developing iOS apps, we often encounter issues where the iPhone keyboard slides up and covers the UITextField / UITextView. IQKeyboardManager allows you to prevent this keyboard issue from sliding up and covering the UITextField/UITextView without having to write any code or do any additional configuration. To use IQKeyboardManager, just add source files to your project.

**How was it used?:** Just added to the project and it started doing its function

## Improvement points:

1 - For applications like this, the right thing would be to create a connection stream and update the chat in real time, in this application it was done manually to give the feeling of reality, but it does not have a connection to a server.

2 - Create image cache and remove the responsibilities of TableViewCells from knowing how to request the internet and receive data

3 - Build unit tests of the scenes, they are already prepared for this.
