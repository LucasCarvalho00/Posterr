//
//  Commons.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Foundation

public class Commons {
    public func getData(name: String, withExtension: String = "json") -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: name, withExtension: withExtension) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            return nil
        }
    }
}
