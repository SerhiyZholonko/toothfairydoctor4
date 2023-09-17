//
//  ContentPatientCell.swift
//  nHealthProject
//
//  Created by admin on 25.02.2021.
//

import UIKit

class ContentPatientCell: UICollectionViewCell {
    
    var myLabel = UILabel()
    var myImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImage()
        createLabel()
        
    }
    func createImage() {
        myImageView.tintColor = #colorLiteral(red: 0.8824590047, green: 0.5166524475, blue: 0.006427255918, alpha: 1)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppDelegate.defaultHeight / 4).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 2).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 2).isActive = true

    }
    func createLabel() {
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myLabel.font = UIFont.systemFont(ofSize: AppDelegate.defaultHeight / 3) //размер шрифта
        myLabel.numberOfLines = 0 // колличество строк , если ставим 0 то их сколько на сколько расстянеться текст
        myLabel.lineBreakMode = .byWordWrapping // переход а другую строку обрываеться по словам
        myLabel.adjustsFontSizeToFitWidth = true // если весь шрифт не влазит тогда он уменьшаеться в размере
        myLabel.sizeToFit()
        contentView.addSubview(myLabel)
        myLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor,constant: 10).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        myLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: AppDelegate.defaultHeight / 4).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
