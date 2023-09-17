//
//  TableViewCellRecord.swift
//  nHealthProject
//
//  Created by admin on 16.03.2021.
//

import UIKit

class TableViewCellRecord: UITableViewCell {

    var titleLabel = UILabel()
    var textField:UITextField? = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createLabel()
        createTextField()
    }
    func createLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = #colorLiteral(red: 0.3775808161, green: 0.3775808161, blue: 0.3775808161, alpha: 1)
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    func createTextField() {
        if let myTextField = textField {
            myTextField.translatesAutoresizingMaskIntoConstraints = false
            myTextField.borderStyle = .none
            myTextField.font = UIFont.systemFont(ofSize: 20)
            myTextField.textAlignment = .right
        contentView.addSubview(myTextField)
            myTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
            myTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.75).isActive = true
            myTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            myTextField.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        }
    }
}
