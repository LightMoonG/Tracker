//
//  CreatingTrackerViewController.swift
//  Tracker
//
//  Created by Глеб Хамин on 05.08.2024.
//

import UIKit

// MARK: - Enum: TrackerType

enum TrackerType {
    case habit
    case event
    case habitEdit
    case eventEdit
}

final class CreatingTrackerViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var createHabitButton: UIButton = {
        let button = CustomBlakButton()
        let emptyStateText = NSLocalizedString("creatingTracker.habit", comment: "Привычка")
        button.setTitle(emptyStateText, for: .normal)
        button.addTarget(self, action: #selector(createHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var createEventButton: UIButton = {
        let button = CustomBlakButton()
        let emptyStateText = NSLocalizedString("creatingTracker.event", comment: "Нерегулярное событие")
        button.setTitle(emptyStateText, for: .normal)
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
        let emptyStateText = NSLocalizedString("creatingTracker.title", comment: "Создание трекера")
        lable.text = emptyStateText
        return lable
    }()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLayout()
    }
   
    // MARK: - IBActions

    @IBAction private func createHabit() {
        let settingHabitViewController = SettingHabitViewController()
        settingHabitViewController.trackerType = .habit
        self.present(settingHabitViewController, animated: true, completion: nil)
    }
    
    @IBAction private func createEvent() {
        let settingHabitViewController = SettingHabitViewController()
        settingHabitViewController.trackerType = .event
        self.present(settingHabitViewController, animated: true, completion: nil)
    }
    
    // MARK: - Public Methods

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
