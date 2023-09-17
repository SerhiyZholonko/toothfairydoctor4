//
//  PacientCollectionVCell.swift
//  nHealthProject
//
//  Created by admin on 12.02.2021.
//

import UIKit

class PacientCollectionVCell: UICollectionViewCell {
    
    let imageView = UIImageView()
     var titleLabel:UILabel = {
        var label = UILabel()
        return label
    }()
    
    var podLabel:UILabel = {
        var label = UILabel()
        return label
    }()
    
    var nameLabel:UILabel = {
        var label = UILabel()
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImage()
        createMyLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createImage() {
        let imageTouch = UIImage(systemName: "chevron.right")
        imageView.image = imageTouch
        imageView.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    func createMyLabels() {
        createDefaultLabel(label: &titleLabel)
        createDefaultLabel(label: &podLabel)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        podLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)

        titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        podLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        createNameLabels(label: &nameLabel)
       
    }
    
    func createDefaultLabel(label:inout UILabel) {
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1926826708, green: 0.1926826708, blue: 0.1926826708, alpha: 1)

        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        self.contentView.addSubview(label)
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        label.widthAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    }
    
    func createNameLabels(label:inout UILabel) {
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.textColor = #colorLiteral(red: 0.1926826708, green: 0.1926826708, blue: 0.1926826708, alpha: 1)

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: AppDelegate.defaultHeight / 2).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor,constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    }
    
   
}

extension UIFont {
    class func  myLightFont(size:CGFloat) -> UIFont  {
    return UIFont.init(name: "HelveticaNeue-Light", size: size)!
    }
}

