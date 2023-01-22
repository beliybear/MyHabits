//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.tag = 0
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.tag = 0
        textLabel.text = "Всё получится!"
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        textLabel.textColor = .systemGray2
        return textLabel
    }()
    
    lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.tag = 1
        percentLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        percentLabel.textColor = .systemGray2
        return percentLabel
    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.setProgress(progressView.progress, animated: true)
        progressView.progressTintColor = UIColor(named: "CustomViolet")
        progressView.trackTintColor = .systemGray
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.layer.sublayers?[1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(progressView)
        addSubview(stackView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(percentLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            progressView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
}

