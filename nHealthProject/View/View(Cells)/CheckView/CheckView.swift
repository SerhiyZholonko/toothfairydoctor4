//
//  CheckView.swift
//  nHealthProject
//
//  Created by apple on 14.09.2023.
//


import UIKit

protocol CheckmarkViewDelegate: AnyObject {
    func checkmarkViewTapped(_ checkmarkView: CheckmarkView)
}

class CheckmarkView: UIView {
    
    var isChecked: Bool = false {
        didSet {
            imageView.image = isChecked ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        }
    }
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    weak var delegate: CheckmarkViewDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = #colorLiteral(red: 1, green: 0.5835773349, blue: 0, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        
        isChecked = false // Set the initial state
        labelText = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap() {
        isChecked.toggle()
        delegate?.checkmarkViewTapped(self)
    }
}




