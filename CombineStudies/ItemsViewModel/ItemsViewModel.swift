//
//  ItemsModel.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 30/12/22.
//

import UIKit
import Combine

struct Item {
    var name: String
}

class ItemsViewModel {
    
    var items = CurrentValueSubject<[Item], Never>([])
    var textContent = CurrentValueSubject<String, Never>("")
    var backgroundColor = CurrentValueSubject<UIColor, Never>(.white)
    
    func addItem() {
        let item = Item(name: "\(Int.random(in: 0...100))")
        items.value.append(item)
        textContent.value = item.name
    }
}
