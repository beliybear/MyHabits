//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
   private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        collectionView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor(named: "CustomGrey")
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        self.navigationItem.title = "Сегодня"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newHabit))
        add.tintColor = UIColor(named: "CustomViolet")
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func newHabit() {
        let habit = HabitViewController()
        let navController = UINavigationController(rootViewController: habit)
        navController.modalPresentationStyle = .fullScreen
        habit.navigationItem.title = "Создать"
        habit.deleteLabel.isHidden = true
        self.present(navController, animated: true)
    }
    
    @objc func tapButton(sender:UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 1)
        let habits = HabitsStore.shared.habits
        if !habits[indexPath.row].isAlreadyTakenToday {
            HabitsStore.shared.track(habits[indexPath.row])
            collectionView.reloadData()
        }
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return HabitsStore.shared.habits.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.progressView.progress = HabitsStore.shared.todayProgress
            cell.percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            let habits = HabitsStore.shared.habits[indexPath.row]
            cell.colorButton.tag = indexPath.row
            cell.colorButton.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            cell.nameTextView.text = habits.name
            cell.nameTextView.textColor = habits.color
            cell.colorButton.layer.borderColor = habits.color.cgColor
            cell.labelTrack.text = "Счётчик: \(habits.trackDates.count)"
            cell.timeLabel.text = "\(habits.dateString)"
            
            if habits.isAlreadyTakenToday {
                cell.colorButton.backgroundColor = habits.color
            }
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 70)
        }
        if indexPath.section == 1 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 150)
        }
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let habitDetails = HabitDetailsViewController()
            habitDetails.navigationItem.title = HabitsStore.shared.habits[indexPath.row].name
            habitDetails.habit = HabitsStore.shared.habits[indexPath.row]
            self.navigationController?.pushViewController(habitDetails, animated: true)
        }
    }
}
