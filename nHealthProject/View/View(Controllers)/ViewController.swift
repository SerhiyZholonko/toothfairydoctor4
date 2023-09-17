//
//  ViewController.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    let firstVCAccount:FirstVCAccount = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstVCAccount") as! FirstVCAccount
    let underTitleLabel = UILabel()
    let titleLabel = UILabel()
    let clouseKeyboard = UIPanGestureRecognizer()
    var enterButton = UIButton()
    var enterPassword = UITextField()
    var enterLogin = UITextField()
    
    var settingsButton = UIButton()
    var mag:DoctorData?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(AppDelegate.defaultHeight)
        navigationController?.setNavigationBarHidden(true, animated:true)
        keyboardFrame()
        createEnterTextFields()
        createEnterButton()

        PrototypeVC.prototypeTitleImage(view: &self.view)
        createRegisterButoonn()
        createClouseKeyboard()
        enterPassword.isSecureTextEntry = true
      
        createTitleLabel()
        
        localizationReload()
        saveEnterData()
        createUnderTitle()
        configureCheckView()
    }
    
    
    func saveEnterData() {
        if  let enterData =  UserDefaults.standard.value(forKey: "EnterData") as? [String:String] {
            enterLogin.text = enterData[SaveType.Login.rawValue] ?? ""
            enterPassword.text = enterData[SaveType.Password.rawValue] ?? ""
        }
    }
    
    
    
    func localizationReload() {
        let underTitleText = "pod_title_view_controller".addLocalizedString()
        let serverTitle = "setting_label".addLocalizedString()
        let enterTitle = "enter_button".addLocalizedString()
        settingsButton.setTitle(serverTitle, for: .normal)
        enterButton.setTitle(enterTitle, for: .normal)
        underTitleLabel.text = underTitleText
        let enterLoginTitle = "enter_login".addLocalizedString()
        let enterPasswordTitle = "enter_password".addLocalizedString()
        enterPassword.placeholder = enterPasswordTitle
        enterLogin.placeholder = enterLoginTitle
    }
    
    func createUnderTitle() {
        underTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        underTitleLabel.font = UIFont.systemFont(ofSize: 10)
        underTitleLabel.textColor =  AppDelegate.colorApp
        underTitleLabel.textAlignment = .center
        self.view.addSubview(underTitleLabel)
        underTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        underTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
    }
    
    
    
    func createClouseKeyboard() {
        clouseKeyboard.addTarget(self, action: #selector(createGesture(param:)))
        view.addGestureRecognizer(clouseKeyboard)
    }
   
    func createRegisterButoonn() {
        settingsButton.addTarget(self, action: #selector(ipSettig(param:)), for: .touchUpInside)
        self.view.addSubview(settingsButton)
        PrototypeVC.prototypeButton(button: &settingsButton, model: ModelButton(title: "", type: .Under))
        settingsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func createEnterButton() {
        self.view.addSubview(enterButton)
        PrototypeVC.prototypeButton(button: &enterButton, model: ModelButton(title: "", type:.Backdround ))
        enterButton.addTarget(self, action: #selector(enterInAccount(param:)), for: .touchUpInside)
        enterButton.topAnchor.constraint(equalTo: enterPassword.bottomAnchor, constant: AppDelegate.defaultHeight ).isActive = true
        enterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func createEnterTextFields() {
        enterLogin.delegate = self
        enterPassword.delegate = self
        self.view.addSubview(enterLogin)
        self.view.addSubview(enterPassword)

        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: "", imageName: "person.fill"), textField: &enterLogin)
        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: "", imageName: "lock.fill"), textField: &enterPassword)

        enterPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        enterLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        enterLogin.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        enterPassword.topAnchor.constraint(equalTo: enterLogin.bottomAnchor,constant: AppDelegate.defaultHeight / 2).isActive = true
    }
    private func configureCheckView() {
        let checkmarkView = CheckmarkView(frame: CGRect())
        checkmarkView.isChecked = true
        checkmarkView.delegate = self // Set the view controller as the delegate
        checkmarkView.labelText = "Synchronize"
        view.addSubview(checkmarkView)
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        let checkmarkViewConstrints = [
            checkmarkView.topAnchor.constraint(equalTo: enterPassword.bottomAnchor, constant: 10),
            checkmarkView.leftAnchor.constraint(equalTo: enterPassword.leftAnchor, constant: 10),
            checkmarkView.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(checkmarkViewConstrints)

            
    }
    func keyboardFrame() {
         NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = -UIScreen.main.bounds.height / 4
         }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
           self.view.frame.origin.y = 0
        }
     }
    func myErrorAlert() {
        let errorTitle = "error_title".addLocalizedString()
        let errorMesseage = "error_alert_messeage".addLocalizedString()

        let alertController = UIAlertController(title: errorTitle , message: errorMesseage , preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ОК", style: .destructive)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func createTitleLabel() {
        titleLabel.text = "ToothFairy4 Doctor"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor =  AppDelegate.colorApp
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo:enterLogin.topAnchor ,constant: -AppDelegate.defaultHeight).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    

    
    
}
extension Data {

    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            textField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            textField.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension ViewController {
    
    @objc func ipSettig(param:UIButton) {
        let serverVC = ServerVC()
        serverVC.reloadClosure = { [self] in
            localizationReload()
            self.view.reloadInputViews()
        }
        self.view.endEditing(true)

        self.present(serverVC, animated: true, completion: nil)
    }
    @objc func createGesture(param:UIPanGestureRecognizer) {
        self.view.endEditing(true)
    }
    @objc func enterInAccount(param:UIButton) {
        let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        if  ip == "" {
            myErrorAlert()
        } else {
        let activity = UIActivityIndicatorView(style: .large)
        self.view.addSubview(activity)
        activity.hidesWhenStopped = true
        activity.center = self.view.center
        activity.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in
        activity.stopAnimating()
        }
        let numberPhone = UserDefaults.standard.value(forKey: AppDelegate.myPhone) as? String
        let numberPhoneVC = NumberPhoneVC()

        ViewModelEnter.enterFunc(login: enterLogin.text ?? "", password: enterPassword.text ?? "") { [self] data in
            DispatchQueue.main.async { [self] in
                
                activity.stopAnimating()
                
                firstVCAccount.data = data
                AppDelegate.doctor_id = data.user_id ?? 0
                firstVCAccount.reloadClosure = { [self] in
                    self.localizationReload()
                    saveEnterData()
        }
                let minimalValidVersion = Int(data.server_version ?? "0") ?? 0
               
                if let login = enterLogin.text, let password = enterPassword.text , login == "" || password == "" {
                    self.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.EmptyFields), animated: true)
                    return
                } else if data.user_id == nil && data.err_msg != "x100" {
                    self.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.ConnectionError), animated: true)
                    return
                } else  if minimalValidVersion == 0 {
                    self.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.VersionServerNotFound), animated: true)
                    return
                } else if minimalValidVersion < 918  {
                    self.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.VersionServerNotValid), animated: true)
                    return
                } else if let phone = numberPhone , isValidNumber(checkItems: data.checkItems ?? [], number: phone) {
                    savePussowdAlert(firstVCAccount: firstVCAccount)
                } else {
                    present(numberPhoneVC, animated: true, completion: nil)
                }
               
                
                    numberPhoneVC.numberClosure  = { [self] number in
                    var myNumberPhone = number
                    if number.count < 10 {
                    numberPhoneVC.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.NotValidCountNumber), animated: true)
                    return
                    } else {
                    let removeCount = number.count - 10
                    myNumberPhone.removeFirst(removeCount)
                        myNumberPhone = "38" + myNumberPhone
                    }
                    let isValidNumVal = isValidNumber(checkItems: data.checkItems ?? [], number: myNumberPhone)
                    
                    if isValidNumVal {
                        // Save number phone
                    UserDefaults.standard.setValue(myNumberPhone, forKey: AppDelegate.myPhone)
                        
                    numberPhoneVC.dismiss(animated: true, completion: nil)
                    savePussowdAlert(firstVCAccount: firstVCAccount)
                    } else {
                    numberPhoneVC.present(PrototypeVC.protorypeErrorAlert(title: ErrorsEnter.MacAdress), animated: true)
                        
                        }
                    }
                }
            }
        }
    }
    
    
    func savePussowdAlert(firstVCAccount:FirstVCAccount) {
        let alertTitle = "save_data".addLocalizedString()
        let alertErrorServer = UIAlertController(title:alertTitle, message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "OK", style: .destructive) { [self] _ in
            UserDefaults.standard.setValue([SaveType.Login.rawValue:enterLogin.text,SaveType.Password.rawValue:enterPassword.text], forKey: "EnterData")
            
            self.view.endEditing(true)
            self.navigationController?.pushViewController(firstVCAccount, animated: false)
        }
        let notNowTitle = "not_now".addLocalizedString()
        let notSaveAction = UIAlertAction(title: notNowTitle, style: .destructive) { _ in
            UserDefaults.standard.setValue([SaveType.Login.rawValue:"",SaveType.Password.rawValue:""] , forKey: "EnterData")
            self.view.endEditing(true)
            self.navigationController?.pushViewController(firstVCAccount, animated: false)
        }
        alertErrorServer.addAction(notSaveAction)
        alertErrorServer.addAction(saveAction)
        self.present(alertErrorServer, animated: true, completion: nil)
    }
   
    
    func isValidNumber(checkItems:[CheckItems],number:String) -> Bool {
        var arrayKeys = [String]()
        for value in checkItems {
            var key = ""
            for i in value.key {
                if i != "z" {
                key.append(i)
                } else {
                arrayKeys.append(key)
                break
                }
            }
        }
    return arrayKeys.contains(where: {$0 == encodePhone(phone: number)})
    }
    
    func encodePhone(phone:String)-> String {
        
        let data = Data(phone.lowercased().utf8)
        let hexString:String = data.map{ String(format:"%02x", $0) }.joined()
        var endValue = ""
        var newNum = ""
        for index in 0..<hexString.count  {
            newNum.append(hexString[index])
            if index % 2 != 0 && index != 0 || index == hexString.count - 1  {
                let num = Float(newNum) ?? 0
                let effr:Int = Int(round(Float((num + 1) * 2 / 8)))
                print(effr)
                endValue.append(String(effr))
                newNum.removeAll()
            }
        }
    return endValue
    }
    
    enum ErrorsEnter:String , ErrorProtocolFEnum {
    case EmptyFields = "empty_fields"
    case ConnectionError = "server_connection_error"
    case VersionServerNotValid = "server_is_out_of_date"
    case MacAdress = "mac_adress_messeage"
    case VersionServerNotFound = "server_version_nfound"
    case NotValidCountNumber = "phone_num_count"
        func error() -> String {
            return self.rawValue
        }
    }
    enum SaveType :String {
    case Login = "login"
    case Password = "password"
    }
    
    }


//MARK: - CheckmarkViewDelegate

extension ViewController: CheckmarkViewDelegate {
    
    func checkmarkViewTapped(_ checkmarkView: CheckmarkView) {
        // Handle the tap event here
        print("CheckmarkView tapped!")
        print("isChecked: \(checkmarkView.isChecked)")
    }
}
