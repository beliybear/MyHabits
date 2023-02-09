//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    var habit = Habit(name: "", date: Date(), color: UIColor.clear)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.tintColor = UIColor(named: "CustomViolet")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = UIColor(named: "CustomGrey")
        navigationController?.navigationBar.tintColor = UIColor(named: "CustomViolet")
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        self.navigationItem.rightBarButtonItem = edit
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func editHabit() {
        let habitView = HabitViewController()
        let navController = UINavigationController(rootViewController: habitView)
        navController.modalPresentationStyle = .fullScreen
        habitView.navigationItem.title = "Править"
        habitView.textField.text = habit.name
        habitView.index = HabitsStore.shared.habits.firstIndex(where: {($0.name == habit.name)}) ?? 0
        habitView.delegate = self
        habitView.deleteLabel.isHidden = false
        self.present(navController, animated: true)
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        var habitStoreDates = HabitsStore.shared.dates
        habitStoreDates.sort(by: {$0>$1})
        cell.textLabel?.text =  dateFormatter.string(from: habitStoreDates[indexPath.row])
        cell.backgroundColor = .systemBackground
        
        if HabitsStore.shared.habit(habit, isTrackedIn: habitStoreDates[indexPath.row]) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
}

extension HabitDetailsViewController: HabitButtonDelegate {
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
