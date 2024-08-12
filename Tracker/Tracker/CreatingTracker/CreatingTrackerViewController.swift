//
//  CreatingTrackerViewController.swift
//  Tracker
//
//  Created by Глеб Хамин on 05.08.2024.
//

import Foundation
import UIKit

enum TrackerType {
    case habit
    case event
}

protocol CreatingTrackerViewControllerDelegate: AnyObject {
    func passCategories() -> [TrackerCategory]
}

final class CreatingTrackerViewController: UIViewController {
    
    weak var delegate: CreatingTrackerViewControllerDelegate?
    
    private lazy var createHabitButton: UIButton = {
        let button = CustomBlakButton()
        button.setTitle("Привычка", for: .normal)
        button.addTarget(self, action: #selector(createHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var createEventButton: UIButton = {
        let button = CustomBlakButton()
        button.setTitle("Нерегулярное событие", for: .normal)
        button.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createHabitButton, createEventButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var titleView: UILabel = {
        let lable = CustomTitle()
        lable.text = "Создание трекера"
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    @IBAction private func createHabit() {
        let settingHabitViewController = SettingHabitViewController()
        settingHabitViewController.trackerType = .habit
        settingHabitViewController.categories = delegate?.passCategories() ?? []
        self.present(settingHabitViewController, animated: true, completion: nil)
    }
    
    @IBAction private func createEvent() {
        let settingHabitViewController = SettingHabitViewController()
        settingHabitViewController.trackerType = .event
        settingHabitViewController.categories = delegate?.passCategories() ?? []
        self.present(settingHabitViewController, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        view.addSubview(titleView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
}
