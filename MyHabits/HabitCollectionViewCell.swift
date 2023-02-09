//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
    lazy var nameTextView: UITextView = {
        let nameTextView = UITextView()
        nameTextView.textContainer.maximumNumberOfLines = 2
        nameTextView.isUserInteractionEnabled = false
        nameTextView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        return nameTextView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        timeLabel.textColor = .systemGray2
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.layer.cornerRadius = 25
        colorButton.clipsToBounds = true
        colorButton.layer.borderWidth = 3.0
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        return colorButton
    }()
    
    lazy var checkImage: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage (systemName: "checkmark")
        checkImage.tintColor = .white
        checkImage.translatesAutoresizingMaskIntoConstraints = false
        return checkImage
    }()
    
    lazy var labelTrack: UILabel = {
        let labelTrack = UILabel()
        labelTrack.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        labelTrack.textColor = .systemGray2
        labelTrack.translatesAutoresizingMaskIntoConstraints = false
        return labelTrack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        nameTextView.text = nil
        nameTextView.textColor = nil
        colorButton.backgroundColor = nil
        colorButton.layer.borderColor = nil
        labelTrack.text = nil
        timeLabel.text = nil
    }
    
    private func addSubviews(){
        addSubview(nameTextView)
        addSubview(timeLabel)
        addSubview(colorButton)
        addSubview(checkImage)
        addSubview(labelTrack)
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            
            nameTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            nameTextView.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            colorButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            colorButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorButton.heightAnchor.constraint(equalToConstant: 50),
            colorButton.widthAnchor.constraint(equalToConstant: 50),
            
            checkImage.centerYAnchor.constraint(equalTo: colorButton.centerYAnchor),
            checkImage.centerXAnchor.constraint(equalTo: colorButton.centerXAnchor),
            
            labelTrack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelTrack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
