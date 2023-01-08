//
//  PickerColorViewController.swift
//  CombineStudies
//
//  Created by Igor Samoel da Silva on 07/01/23.
//

import UIKit
import Combine
class PickerColorViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Picker Color", for: .normal)
        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var pickerController = {
        let pickerController = UIColorPickerViewController()
        pickerController.selectedColor = viewModel.backgroundColor.value
        return pickerController
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    private var viewModel: ItemsViewModel
    
    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupLayout()
        setupObservables()
    }
    
    
    private func addViews() {
        view.addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
        [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 50)
        ]
        )
    }
    
    private func setupObservables() {
        button.addTarget(self, action: #selector(pickerColor), for: .touchUpInside)
        
        pickerController.publisher(for: \.selectedColor)
            .sink { [weak self] color in
                DispatchQueue.main.async {
                    self?.viewModel.backgroundColor.value = color
                }
            }.store(in: &cancellables)
        
        viewModel.backgroundColor.sink { [weak self] newColor in
            self?.view.backgroundColor = newColor
        }.store(in: &cancellables)
    }
    
    @objc func pickerColor() {
        present(pickerController, animated: true)
    }
}
