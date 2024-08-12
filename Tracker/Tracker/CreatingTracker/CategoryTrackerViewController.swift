//
//  CategoryTrackerViewController.swift
//  Tracker
//
//  Created by Глеб Хамин on 08.08.2024.
//

import UIKit

protocol CategoryTrackerViewControllerDelegate: AnyObject {
    func updateСurrentCategory(_ indexPath: IndexPath)
}

final class CategoryTrackerViewController: UIViewController {
    
    weak var delegate: CategoryTrackerViewControllerDelegate?
    
    var categories: [TrackerCategory] = []
    var selectedIndexPath: IndexPath?
    
    private lazy var titleView: UILabel = {
        let lable = CustomTitle()
        lable.text = "Категория"
        return lable
    }()
    
    private lazy var noDataView: NoDataView = {
        let view = NoDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Привычки и события можно\nобъединить по смыслу"
        view.image = UIImage(named: "NoContent")
        return view
    }()
            
    private lazy var addCategoryButton: UIButton = {
        let button = CustomBlakButton()
        button.setTitle("Добавить категорию", for: .normal)
        button.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        return button
    }()
    
    private let tableView = ParameterTable(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTable()
        setupLayout()
        if categories.count > 0 {
            layoutTable()
        } else {
            loadDefaultImage()
        }
    }
    
    @IBAction private func addCategory() {
        let newCategoryViewController = NewCategoryViewController()
        newCategoryViewController.delegate = self
        self.present(newCategoryViewController, animated: true, completion: nil)
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(titleView)
        view.addSubview(addCategoryButton)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    func layoutTable() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -16)
        ])
    }
    
    private func loadDefaultImage() {
        view.addSubview(noDataView)
        NSLayoutConstraint.activate([
            noDataView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            noDataView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor),
            noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CategoryTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypseTrackerCell", for: indexPath)
        
        guard let typseTrackerCell = cell as? TypseTrackerCell else {
            return UITableViewCell()
        }
        if indexPath == selectedIndexPath {
            typseTrackerCell.image.image = UIImage(systemName: "checkmark")
        } else {
            typseTrackerCell.image.image = .none
        }
        typseTrackerCell.lable.text = categories[indexPath.row].title
        self.tableView.roundingVorners(cell: typseTrackerCell, tableView: tableView, indexPath: indexPath)
        
        typseTrackerCell.setup(hideTopSeparator: indexPath.row == 0,
                               hideBotSeparator: indexPath.row == categories.count - 1)
        
        return typseTrackerCell
    }
}

extension CategoryTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TypseTrackerCell {
            cell.image.image = UIImage(systemName: "checkmark")
            selectedIndexPath = indexPath
            
            if let delegate = delegate {
                delegate.updateСurrentCategory(indexPath)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TypseTrackerCell {
            cell.image.image = .none
        }
    }
}

extension CategoryTrackerViewController: NewCategoryViewControllerDelegate {
    func updateTable() {
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func updateView(_ indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        
        if let delegate = delegate {
            delegate.updateСurrentCategory(indexPath)
        }
    }
}