//
//  ServerVC.swift
//  nHealthProject
//
//  Created by admin on 01.03.2021.
//


import UIKit
import Foundation
import RxSwift
import RxCocoa

class ServerVC: UIViewController {
    
    let disposeBag = DisposeBag()
    let macAdressLabel = UILabel()
    var reloadClosure = {() -> () in return }
    var myTextFieldIp = UITextField()
    let backgroundeVIew = UIView()
    var okButton = UIButton()
    var backButton = UIButton()
    var languageButton = UIButton()
    var tableViewLanguage = UITableView()
    let observableArrayLanguage = PublishSubject<[String]>.just(AppDelegate.language)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackgroundeView()
        createTextField()
        createButtons()
        createMacAdressLabel()
        createStartTableView()

  }
    
    //MARK:Create mac adress label
    
    func createMacAdressLabel() {
        let numberPhone = UserDefaults.standard.value(forKey: AppDelegate.myPhone) as? String
        macAdressLabel.text = numberPhone ?? ""

        macAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        macAdressLabel.font = UIFont.systemFont(ofSize: 20)
        macAdressLabel.textAlignment = .center
        self.view.addSubview(macAdressLabel)
        macAdressLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -AppDelegate.defaultHeight * 2).isActive = true
        macAdressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    // MARK:Create IP text field
    func createTextField() {
        self.view.addSubview(myTextFieldIp)
        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: "IP", imageName: "barcode.viewfinder"), textField: &myTextFieldIp)
        
        myTextFieldIp.text = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        myTextFieldIp.font = UIFont.italicSystemFont(ofSize: 17)
        myTextFieldIp.topAnchor.constraint(equalTo: self.view.topAnchor, constant: AppDelegate.defaultHeight / 2).isActive = true
        myTextFieldIp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    //MARK:Create Backgrounde conten  view
    func createBackgroundeView() {
        backgroundeVIew.layer.cornerRadius = AppDelegate.defaultHeight / 3
        backgroundeVIew.layer.masksToBounds = true
        backgroundeVIew.backgroundColor = #colorLiteral(red: 0.9595011701, green: 0.9595011701, blue: 0.9595011701, alpha: 1)
        backgroundeVIew.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundeVIew)
        backgroundeVIew.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundeVIew.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundeVIew.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        backgroundeVIew.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 3).isActive = true
    }

   //MARK:Create buttons (go,cancel,language)
    func createButtons() {
        okButton.addTarget(self, action: #selector(newServer), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(dismissFromView), for: .touchUpInside)
        languageButton.addTarget(self, action: #selector(createTableView), for: .touchUpInside)
        
        var languageTitle = ""
        if let oldTitle = UserDefaults.standard.value(forKey:AppDelegate.languageKey) {
            languageTitle = oldTitle as! String
        } else {
            UserDefaults.standard.setValue(AppDelegate.language[0], forKey: AppDelegate.languageKey)
            languageTitle = AppDelegate.language[0]
        }
        createLockalButtons(button: &languageButton, type: .Black)
        createLockalButtons(button: &okButton, type: .Black)
        createLockalButtons(button: &backButton, type: .White)
        
        languageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: UIScreen.main.bounds.width * 0.05).isActive = true
        okButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -UIScreen.main.bounds.width *  0.05).isActive = true
        
        backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        okButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        okButton.imageView?.tintColor = .black
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.imageView?.tintColor = .white
        languageButton.setTitle(languageTitle, for: .normal)
    }
 //MARK:Prototype buttons
    func createLockalButtons(button:inout UIButton,type:TypeButton) {
        switch type {
        case .Black:
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = .white
        case .White:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
    }
        button.setTitleColor(#colorLiteral(red: 0.538715324, green: 0.538715324, blue: 0.538715324, alpha: 1), for: .highlighted)
        button.layer.cornerRadius = AppDelegate.defaultHeight * 0.75 / 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundeVIew.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 0.75).isActive = true
        button.topAnchor.constraint(equalTo: myTextFieldIp.bottomAnchor, constant: AppDelegate.defaultHeight / 2).isActive = true
        if AppDelegate.isIPad {
            button.widthAnchor.constraint(equalToConstant: self.view.frame.width / 6).isActive = true

        } else {
        button.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4).isActive = true

        }
    }
    enum TypeButton {
        case Black
        case White
    }
    
}

extension ServerVC {
    @objc func dismissFromView() {
        dismiss(animated: true, completion: nil)
    }
    @objc func newServer() {
        UserDefaults.standard.setValue(myTextFieldIp.text, forKey: AppDelegate.constantKeyIP)
        UserDefaults.standard.setValue(0, forKeyPath: AppDelegate.roomIdentifier)
        dismiss(animated: true, completion: nil)
    }
    func createStartTableView() {
        self.tableViewLanguage.rowHeight = AppDelegate.defaultHeight
        tableViewLanguage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableViewLanguage)
        
        tableViewLanguage.topAnchor.constraint(equalTo: languageButton.topAnchor).isActive = true
        tableViewLanguage.leadingAnchor.constraint(equalTo: languageButton.leadingAnchor).isActive = true
        tableViewLanguage.trailingAnchor.constraint(equalTo: languageButton.trailingAnchor).isActive = true
        tableViewLanguage.heightAnchor.constraint(equalToConstant: 0).isActive = true
    
        
        tableViewLanguage.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        
        observableArrayLanguage.bind(to: tableViewLanguage.rx.items(cellIdentifier: "LanguageCell")) { ( row, model, cell) in
            print(model)
            cell.textLabel?.text = model
            cell.textLabel?.textAlignment = .center
        }.disposed(by: disposeBag)
        
        tableViewLanguage.rx.itemSelected
            .subscribe(onNext: { [self] indexPath in
                UIView.animate(withDuration: 0.5) { [self] in
                    UserDefaults.standard.setValue(AppDelegate.language[indexPath.row], forKey: AppDelegate.languageKey)
                    languageButton.setTitle(AppDelegate.language[indexPath.row], for: .normal)
                    
                    tableViewLanguage.constraints.last?.constant = 0
                    self.view.layoutIfNeeded()
                    reloadClosure()
                }

            }).disposed(by: disposeBag)
    }
    //MARK:Create table view on touch language button
    @objc func createTableView() {
        UIView.animate(withDuration: 0.5) { [self] in
            tableViewLanguage.constraints.last?.constant = AppDelegate.defaultHeight  * CGFloat(AppDelegate.language.count)
            self.view.layoutIfNeeded()
        }

        
        
        }
   
}
