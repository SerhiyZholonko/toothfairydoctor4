//
//  MyCollectionViewCell.swift
//  nHealthProject
//
//  Created by admin on 12.02.2021.
//

import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
        var data:ModelContentCell? {
            didSet {
                guard let data = data else { return }
                titleLabel.text = data.titleLabel
                podLabel.text = data.podLabel
            }
        }
        
        let titleLabel:UILabel = {
            var label = UILabel()
            label.backgroundColor = .clear
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFont(name: "PingFangHK-Semibold", size: 22)
            return label
        }()
        let podLabel:UILabel = {
            var label = UILabel()
            label.backgroundColor = .clear
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFont(name: "AvenirNext-UltraLight", size: 25)
            return label
        }()
       override init(frame:CGRect) {
            super.init(frame: frame)
        createPositionLabels()
        }
        func createPositionLabels() {
            self.contentView.addSubview(titleLabel)
            self.contentView.addSubview(podLabel)
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height / 5).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.height / 5).isActive = true
            
            podLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -contentView.frame.height / 5).isActive = true
            podLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.height / 5).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


