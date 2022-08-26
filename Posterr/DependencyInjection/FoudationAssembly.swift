//
//  FoudationAssembly.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import Swinject

final class FoudationAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: - ScenesFactory
        
        container.register(ScenesFactoryProtocol.self) { resolver in
            ScenesFactory(resolver: resolver)
        }

        // MARK: - FlowController
        
        container.register(FlowController.self) { (resolver: Resolver, navigationController: UINavigationController) in
            let factory = resolver.resolve(ScenesFactoryProtocol.self)!
            return FlowController(navigationController: navigationController, factory: factory)
        }
        
        // MARK: - NetworkOperation
        
        container.register(NetworkOperationProtocol.self) { _ in
            NetworkOperation(mockData: nil)
        }
    }
}
