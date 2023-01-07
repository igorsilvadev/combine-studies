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
        let tabOneBarItem = UITabBarItem(title: "Table View", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let textFieldViewController = TextFieldViewController(viewModel: viewModel)
        let tabTwoBarItem = UITabBarItem(title: "TextField", image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), tag: 2)
        
        tableViewController.tabBarItem = tabOneBarItem
        textFieldViewController.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [tableViewController, textFieldViewController]
    }
    
}


extension TabBarController: UITabBarControllerDelegate {
    
}
