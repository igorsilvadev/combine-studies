//
//  TextFieldController.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 02/01/23.
//

import UIKit
import Combine

class TextFieldViewController: UIViewController {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 4
        textField.textColor = .black
        textField.placeholder = "Digite aqui o texto"
        textField.backgroundColor = .gray
        return textField
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Hello World"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var viewModel: ItemsViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupLayout()
        setupAppearance()
        setupObservables()
    }
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate(
            [
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                textField.heightAnchor.constraint(equalToConstant: 30),
                
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                
            ]
        )
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
    }
    
    private func addViews() {
        view.addSubview(textField)
        view.addSubview(label)
    }
    
    private func setupObservables() {
        
        textField.textPublisher.sink { [weak self] text in
            self?.viewModel.textContent.value = text
        }.store(in: &cancellables)
        
        
        viewModel.backgroundColor.sink { [weak self] newBackgroundColor in
            self?.view.backgroundColor = newBackgroundColor
        }.store(in: &cancellables)
        
        viewModel.textContent.map { $0 }.assign(to: \.text, on: label).store(in: &cancellables)
        
    }
}
