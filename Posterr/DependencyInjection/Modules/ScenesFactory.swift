//
//  ScenesFactory.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//
    
import Swinject

final class ScenesFactory: ScenesFactoryProtocol {
    
    // MARK: - Private Attributes

    private let resolver: Resolver
    
    // MARK: - Initializer
   
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    // MARK: - Public Functions
    
    func makePSHomeViewController() -> PSHomeViewController {
        resolver.resolve(PSHomeViewController.self)!
    }
    
    func makePSUserProfileViewController() -> PSUserProfileViewController {
        resolver.resolve(PSUserProfileViewController.self)!
    }
}
