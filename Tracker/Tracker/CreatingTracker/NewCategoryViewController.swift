//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Глеб Хамин on 08.08.2024.
//

import UIKit

// MARK: - Protocol: NewCategoryViewControllerDelegate

protocol NewCategoryViewControllerDelegate: AnyObject {
    func updateCategory(_ title: String)
}

final class NewCategoryViewController: UIViewController {
    
    // MARK: - Public Properties

    weak var delegate: NewCategoryViewControllerDelegate?
    
    private let trackerCategoryStore = TrackerCategoryStore()
    
    // MARK: - UI Components

    private lazy var titleView: UILabel = {
        let lable = CustomTitle()
        let emptyStateText = NSLocalizedString("newCategoryTracker.title", comment: "Категория")
        lable.text = emptyStateText
        return lable
    }()
    
    private lazy var categoryNameField: CustomTextFiel = {
        let emptyStateText = NSLocalizedString("newCategoryTracker.name", comment: "Введите название категории")
        let textField = CustomTextFiel(placeholder: emptyStateText)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var readyButton: UIButton = {
        let button = CustomBlakButton()
//        button.backgroundColor = .ypGray
        button.isEnabled = false
        let emptyStateText = NSLocalizedString("newCategoryTracker.buttonCreate", comment: "Готово")
        button.setTitle(emptyStateText, for: .normal)
        button.addTarget(self, action: #selector(ready), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    // MARK: - Private Methods

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            readyButton.isEnabled = true
        } else {
            readyButton.isEnabled = false
        }
    }
    
    @objc private func ready() {
        guard let nameNewCategory = categoryNameField.text,
              nameNewCategory.count > 0
        else {
            return
        }
        
        do {
            try trackerCategoryStore.addNewCategory(nameNewCategory)
            
        } catch {
            print("Категория не сохранена")
        }

        dismiss(animated: false) {
            self.delegate?.updateCategory(nameNewCategory)
        }
    }
    
    // MARK: - View Layout

    private func setupLayout() {
        view.addSubview(titleView)
        view.addSubview(readyButton)
        view.addSubview(categoryNameField)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryNameField.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            categoryNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryNameField.heightAnchor.constraint(equalToConstant: 75),
            
            readyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            readyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            readyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}

// MARK: - Extension: UITextFieldDelegate

extension NewCategoryViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 38
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
