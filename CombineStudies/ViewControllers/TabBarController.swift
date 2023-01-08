//
//  TabBarController.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 02/01/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var viewModel: ItemsViewModel = ItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tableViewController = TableViewController(viewModel: viewModel)
        let tabFirstBarItem = UITabBarItem(title: "Table View", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let textFieldViewController = TextFieldViewController(viewModel: viewModel)
        let tabSecondBarItem = UITabBarItem(title: "TextField", image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), tag: 2)
        
        let pickerColorViewController = PickerColorViewController(viewModel: viewModel)
        let tabThirdBarItem = UITabBarItem(title: "Picker Color", image: UIImage(systemName: "paintpalette.fill"), tag: 3)
        
        tableViewController.tabBarItem = tabFirstBarItem
        textFieldViewController.tabBarItem = tabSecondBarItem
        pickerColorViewController.tabBarItem = tabThirdBarItem
        
        self.viewControllers = [tableViewController, textFieldViewController, pickerColorViewController]
    }
    
}


extension TabBarController: UITabBarControllerDelegate {
    
}
