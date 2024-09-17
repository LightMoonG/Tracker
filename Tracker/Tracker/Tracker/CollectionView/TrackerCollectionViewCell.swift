//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Глеб Хамин on 02.08.2024.
//

import Foundation
import UIKit

// MARK: - Protocol: TrackerCellDelegate

protocol TrackerCellDelegate {
    func didTapAddButton(_ id: UUID, _ status: Bool)
}

final class TrackerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var delegate: TrackerCellDelegate?
    var color: UIColor = .ypBlack
    var id: UUID?
    var status: Bool = false
    
    // MARK: - Private Properties

    private var countDays: Int = 0
    
    // MARK: - UI Components
    
    private lazy var namedTrackerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = color
        return view
    }()
    
    private lazy var smail: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.overrideUserInterfaceStyle = .light
        lable.layer.cornerRadius = 12
        lable.layer.masksToBounds = true
        lable.textAlignment = .center
        lable.backgroundColor = .ypBackground
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return lable
    }()
    
    private lazy var nameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.overrideUserInterfaceStyle = .light
        lable.textColor = .ypWhite
        lable.numberOfLines = 2
        lable.baselineAdjustment = .alignBaselines
        lable.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return lable
    }()
    
    private lazy var counterLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .ypBlack
        lable.text = "\(countDays) дней"
        lable.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return lable
    }()
    
    private lazy var addButtonCell: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = color
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        button.tintColor = .ypWhite
        button.adjustsImageWhenDisabled = false
        
        button.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackCounterTracker: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [counterLable, addButtonCell])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBActions
    
    @IBAction func addButtonTap(_ sender: UIButton) {
        self.addButtonCell.isEnabled = false
        self.status = self.status ? false : true
        guard let delegate, let id else {
            return
        }
        delegate.didTapAddButton(id, status)
        if status {
            updateCountDays(day: countDays + 1)
        } else {
            updateCountDays(day: countDays - 1)
        }
        self.apdateMark()
        self.addButtonCell.isEnabled = true
    }
    
    // MARK: - Public Methods
    
    func configCell(name: String, color: UIColor, emoji: String, executionStatus: Bool, day: Int, cellStatus: Bool) {
        nameLable.text = name
        namedTrackerView.backgroundColor = color
        smail.text = emoji
        status = executionStatus
        addButtonCell.backgroundColor = color
        addButtonCell.isEnabled = cellStatus
        updateCountDays(day: day)
        apdateMark()
    }
    
    func updateCountDays(day: Int) {
        countDays = day
        
        let tasksString = String.localizedStringWithFormat(
            NSLocalizedString("numberOfTasks", comment: "Number of remaining tasks"),
            day
        )
        
        counterLable.text = tasksString
    }
    
    func apdateMark() {
        let image = status ? UIImage(named: "Done") : UIImage(systemName: "plus")
        addButtonCell.setImage(image, for: .normal)
        addButtonCell.alpha = status ? 0.3 : 1
    }
    
    // MARK: - View Layout
    
    private func setupConstraints() {
        contentView.addSubview(namedTrackerView)
        namedTrackerView.addSubview(smail)
        namedTrackerView.addSubview(nameLable)
        contentView.addSubview(stackCounterTracker)
        
        NSLayoutConstraint.activate([
            namedTrackerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            namedTrackerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            namedTrackerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            namedTrackerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            namedTrackerView.heightAnchor.constraint(equalToConstant: 90),
            
            smail.leadingAnchor.constraint(equalTo: namedTrackerView.leadingAnchor, constant: 12),
            smail.topAnchor.constraint(equalTo: namedTrackerView.topAnchor, constant: 12),
            smail.heightAnchor.constraint(equalToConstant: 24),
            smail.widthAnchor.constraint(equalToConstant: 24),
            
            nameLable.leadingAnchor.constraint(equalTo: namedTrackerView.leadingAnchor, constant: 12),
            nameLable.topAnchor.constraint(equalTo: namedTrackerView.topAnchor, constant: 44),
            nameLable.trailingAnchor.constraint(equalTo: namedTrackerView.trailingAnchor, constant: -12),
            nameLable.bottomAnchor.constraint(equalTo: namedTrackerView.bottomAnchor, constant: -12),
            
            stackCounterTracker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackCounterTracker.topAnchor.constraint(equalTo: namedTrackerView.bottomAnchor, constant: 8),
            stackCounterTracker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackCounterTracker.heightAnchor.constraint(equalToConstant: 34),
            
            addButtonCell.heightAnchor.constraint(equalToConstant: 34),
            addButtonCell.widthAnchor.constraint(equalToConstant: 34)
        ])
    }
}