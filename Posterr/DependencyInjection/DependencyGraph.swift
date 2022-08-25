//
//  DependencyGraph.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import Swinject

final class DependencyGraph {
    public static func build() -> [Assembly] {
        return [
            FoudationAssembly(),
            ScenesAssembly(),
        ]
    }
}
