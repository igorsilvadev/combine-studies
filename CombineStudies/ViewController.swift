//
//  ViewController.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 30/12/22.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController, UITableViewDataSource {
    
    lazy var viewModel = ItemsViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupLayout()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        setupObservables()
        
    }
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate(
        [
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor)
        ])
        
        
    }
    
    func setupObservables() {
        viewModel.items.sink { [weak self] _ in
            self?.tableView.reloadData()
            if !(self?.viewModel.items.value.isEmpty ?? true) {
                self?.tableView.scrollToRow(at: IndexPath(row: (self?.viewModel.items.value.count ?? 1) - 1, section: 0), at: .middle, animated: true)
            }
        }.store(in: &cancellables)
        
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    @objc func addItem() {
        viewModel.addItem()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.items.value[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration {
            HStack {
                Text(item.name)
            }
        }
        
        return cell
    }
    
}

