//
//  NumberPhoneVC.swift
//  nHealthProject
//
//  Created by admin on 30.03.2021.
//

import UIKit
import RxSwift

class NumberPhoneVC: UIViewController {
    var numberClosure :((String)->())?
    let disposeBag = DisposeBag()
    var cancelButton = UIButton()
    let label = UILabel()
    var textFieldNumber = UITextField()
    var enterButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createLabel()
        createTextField()
        createEnterButton()
        lockalizeView()
        createCancelButton()
    }
    
    func createLabel() {
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: AppDelegate.defaultHeight).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    func createTextField() {
        self.view.addSubview(textFieldNumber)
        textFieldNumber.keyboardType = .numberPad
        textFieldNumber.keyboardAppearance = .light
        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: "+38...", imageName: "phone.fill.connection"), textField: &textFieldNumber)
        
        textFieldNumber.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFieldNumber.topAnchor.constraint(equalTo: self.label.bottomAnchor,constant: AppDelegate.defaultHeight  / 2).isActive = true
    }
    
//        continue_button
        func createEnterButton() {
            self.view.addSubview(enterButton)
            PrototypeVC.prototypeButton(button: &enterButton, model: ModelButton(title: "", type:.Backdround ))
            enterButton.addTarget(self, action: #selector(enterInAccount), for: .touchUpInside)
            enterButton.topAnchor.constraint(equalTo: textFieldNumber.bottomAnchor, constant: 20).isActive = true
            enterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
    func createCancelButton() {
        cancelButton = UIButton(type: .close)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        cancelButton.rx.tap.bind {
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func lockalizeView() {
        enterButton.setTitle("continue_button".addLocalizedString(), for: .normal)
        label.text = "number_phone_enter".addLocalizedString()
    }
    
    
    @objc func enterInAccount() {
        numberClosure?(textFieldNumber.text!)
    }
    
    
}
