//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameHeaderLabel: UILabel = {
        let nameHeaderLabel = UILabel()
        nameHeaderLabel.tag = 0
        nameHeaderLabel.text = "НАЗВАНИЕ"
        nameHeaderLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        nameHeaderLabel.textColor = .black
        nameHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameHeaderLabel
    }()
    
    private lazy var colorHeaderLabel: UILabel = {
        let colorHeaderLabel = UILabel()
        colorHeaderLabel.tag = 2
        colorHeaderLabel.text = "ЦВЕТ"
        colorHeaderLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        colorHeaderLabel.textColor = .black
        colorHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorHeaderLabel
    }()
    
    private lazy var timeHeaderLabel: UILabel = {
        let timeHeaderLabel = UILabel()
        timeHeaderLabel.text = "ВРЕМЯ"
        timeHeaderLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        timeHeaderLabel.textColor = .black
        timeHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeHeaderLabel
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.layer.cornerRadius = 25
        colorView.clipsToBounds = true
        colorView.isUserInteractionEnabled = true
        colorView.backgroundColor = UIColor(named: "CustomOrange")
        colorView.translatesAutoresizingMaskIntoConstraints = false
        return colorView
    }()
    
    private lazy var textTimeLabel: UILabel = {
        let textTimeLabel = UILabel()
        textTimeLabel.tag = 0
        textTimeLabel.text = "Каждый день в "
        textTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textTimeLabel.textColor = .black
        textTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return textTimeLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.tag = 1
        timeLabel.text = "11:00 PM"
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        timeLabel.textColor = UIColor(named: "CustomViolet")
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        return colorPicker
    }()
    
   private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(self.didChoosedTime), for: .valueChanged)
        return datePicker
    }()
    
    lazy var deleteLabel: UILabel = {
        let deleteLabel = UILabel()
        deleteLabel.text = "Удалить привычку"
        deleteLabel.textColor = .red
        deleteLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        deleteLabel.isUserInteractionEnabled = true
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        return deleteLabel
    }()
    
    weak var delegate: HabitButtonDelegate?
    
    var index = 0
    
    private let alert = UIAlertController(title: "Удалить привычку", message: "", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        addSubviews()
        setupConstraints()
        setupGestures()
        setupAlert ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = UIColor(named: "CustomGrey")
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    private func addSubviews() {
        view.addSubview(stackViewVertical)
        view.addSubview(stackViewHorizontal)
        view.addSubview(colorView)
        view.addSubview(timeHeaderLabel)
        view.addSubview(datePicker)
        view.addSubview(timeLabel)
        view.addSubview(deleteLabel)
        stackViewVertical.addArrangedSubview(nameHeaderLabel)
        stackViewVertical.addArrangedSubview(textField)
        stackViewVertical.addArrangedSubview(colorHeaderLabel)
        stackViewHorizontal.addArrangedSubview(textTimeLabel)
        stackViewHorizontal.addArrangedSubview(timeLabel)
    }
    
    private func setupNavBar() {
        let saveButton = UIBarButtonItem(title: "Cохранить", style: .plain, target: self, action: #selector(didTapSaveButton))
        saveButton.tintColor = UIColor(named: "CustomViolet")
        self.navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(didTapCancelButton))
        cancelButton.tintColor = UIColor(named: "CustomViolet")
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackViewVertical.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackViewVertical.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            colorView.heightAnchor.constraint(equalToConstant: 50),
            colorView.widthAnchor.constraint(equalToConstant: 50),
            colorView.topAnchor.constraint(equalTo: stackViewVertical.bottomAnchor, constant: 10),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timeHeaderLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 16),
            timeHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stackViewHorizontal.topAnchor.constraint(equalTo: timeHeaderLabel.bottomAnchor, constant: 10),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor, constant: 10),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            deleteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toColorPicker(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.colorView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        let tapGestureDelete = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteLabel(_:)))
        tapGestureDelete.numberOfTapsRequired = 1
        deleteLabel.addGestureRecognizer(tapGestureDelete)
    }
    
    private func setupAlert (){
        
        alert.message = "Вы хотите удалить привычку \(self.textField.text ?? "No text")?"
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: {
            _ in
            print("отмена")
        }))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            _ in
            HabitsStore.shared.habits.remove(at: self.index)
            HabitsStore.shared.save()
            self.dismiss(animated: false, completion: {self.delegate?.popToRoot()})
        }))
    }
    
    @objc private func toColorPicker(_ gestureRecognizer: UITapGestureRecognizer) {
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    @objc private func didChoosedTime() {
        let choosedTime = DateFormatter()
        choosedTime.dateFormat = "hh:mm a"
        self.timeLabel.text = choosedTime.string(from: self.datePicker.date)
    }
    
    @objc private func didTapSaveButton() {
        if self.navigationItem.title == "Создать" {
            let newHabit = Habit(name: textField.text ?? "No text",
                                 date: datePicker.date,
                                 color: colorView.backgroundColor ?? .orange)
       
                HabitsStore.shared.habits.append(newHabit)
                HabitsStore.shared.save()
                self.dismiss(animated: true, completion: nil)
            
        } else {
                HabitsStore.shared.habits[index].name = textField.text ?? "No text"
                HabitsStore.shared.habits[index].date = datePicker.date
                HabitsStore.shared.habits[index].color = colorView.backgroundColor ?? .orange
            
            HabitsStore.shared.save()
            self.dismiss(animated: false, completion: {self.delegate?.popToRoot()})
        }
    }
    
    @objc private func didTapDeleteLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func forcedHidingKeyboard() {
        view.endEditing(true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPicker.dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorView.backgroundColor = color
    }
}

