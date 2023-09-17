//
//  PodCollectionViewCell.swift
//  nHealthProject
//
//  Created by admin on 09.02.2021.
//

import UIKit
class BigCollectionVCell: UICollectionViewCell {
    var data:ModelPodLabel? {
        didSet {
            guard let data = data else { return }
            guard let image = UIImage(named: data.imageName) else { return }
            myImageView.image = image
            firsTitle.text = data.firstTitle
            secondTitle.text = data.secondTitle
        }
    }
    var myImageView :UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var firsTitle:UILabel = {
        var label = UILabel()
        
        return label
    }()
    var secondTitle:UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        creteFirstLabel()
        createSecondTitle()
        createImage()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func creteFirstLabel() {
        createLabels(label: &firsTitle)
        firsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height * 0.33).isActive = true
    }
    func createSecondTitle() {
        createLabels(label: &secondTitle)
        secondTitle.topAnchor.constraint(equalTo: firsTitle.bottomAnchor, constant:10).isActive = true
    }
    func createImage() {
        myImageView.layer.cornerRadius = contentView.frame.height / 10
        myImageView.layer.masksToBounds = true
        myImageView.alpha = 0.6
        contentView.insertSubview(myImageView, at: 0)
        
        myImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func createLabels(label:inout UILabel) {
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true

    }
}
