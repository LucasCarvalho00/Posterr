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

    }
}
