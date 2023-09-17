//
//  CollectionViewCellTitleView.swift
//  nHealthProject
//
//  Created by admin on 09.02.2021.
//

import UIKit

class LittleCollectionVCell: UICollectionViewCell {
    var data :ModelCellTitle? {
        didSet {
            guard let data = data else { return }
            image.image = UIImage(named: data.imageName) ?? UIImage(named: "")
            label.text = data.title
           
            }
    }
    var image:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    var label:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-MediumOblique", size: 17)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
       
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        createImage()
        createLabel()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createImage() {
        contentView.addSubview(image)
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height / 10).isActive = true
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: contentView.frame.height / 1.5).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.5).isActive = true
    }
    
    func createLabel() {
        label.layer.cornerRadius = contentView.frame.height / 10
        label.layer.masksToBounds = true
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: contentView.frame.height / 3 - contentView.frame.height / 5 ).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.height / 10).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.height / 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: contentView.frame.height / 4).isActive = true
    }
}
