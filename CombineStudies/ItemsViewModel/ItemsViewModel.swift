//
//  ItemsModel.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 30/12/22.
//

import Foundation
import Combine

struct Item {
    var name: String
}

class ItemsViewModel {
    
    var items = CurrentValueSubject<[Item], Never>([])
    
    
    
    func addItem() {
        items.value.append(Item(name: "\(Int.random(in: 0...100))")) 
    }
    
    
}
