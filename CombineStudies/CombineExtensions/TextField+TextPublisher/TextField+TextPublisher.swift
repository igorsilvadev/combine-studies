//
//  TextField+TextPublisher.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 02/01/23.
//

import UIKit
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                             object: self).compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
