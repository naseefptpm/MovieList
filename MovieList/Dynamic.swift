//
//  Dynamic.swift
//  MovieList
//
//  Created by codeteki private Ltd on 23/12/20.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listerner: Listener?
    var value: T{
        didSet{
            listerner?(value)
        }
    }
    
    init(_ v:T) {
        value = v
    }
    
    func binde(_ listerner: Listener?) {
        self.listerner = listerner
    }
    
    func bindAndFire(_ listerner: Listener?) {
        self.listerner = listerner
        listerner?(value)
    }
}
