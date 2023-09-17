//
//  PrototypeViewController.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import UIKit

protocol ErrorProtocolFEnum {
    func error()->String
}

class PrototypeVC  {
    
        static func protorypeErrorAlert(title: ErrorProtocolFEnum) -> UIAlertController {
            let alertTitle = title.error().addLocalizedString()
            let alertErrorServer = UIAlertController(title:alertTitle, message: nil, preferredStyle: .alert)
            let alertActionError = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alertErrorServer.addAction(alertActionError)
            return alertErrorServer
        }
        
    
    static func prototypeTitleImage(view: inout UIView) {
        let titleImage = UIImageView()
        guard let image = UIImage(named: "Title") else { return }
        let defaultWidtImage = UIScreen.main.bounds.height / 4
        titleImage.layer.cornerRadius = defaultWidtImage / 2
        titleImage.image = image
        titleImage.sizeToFit()
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.layer.masksToBounds = true

        view.addSubview(titleImage)
        
        titleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -defaultWidtImage).isActive = true
        titleImage.heightAnchor.constraint(equalToConstant: defaultWidtImage).isActive = true
        titleImage.widthAnchor.constraint(equalToConstant: defaultWidtImage).isActive = true
        titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    static func prototypeButton(button:inout UIButton,model:ModelButton) {
            button.setTitle(model.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: AppDelegate.defaultHeight / 3)
            button.layer.cornerRadius = AppDelegate.defaultHeight / 2
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            switch model.type {
            case .Backdround:
                button.backgroundColor = AppDelegate.colorApp
                button.setTitleColor(.white, for: .normal)
                button.setTitleColor(#colorLiteral(red: 0.9518216066, green: 0.9518216066, blue: 0.9518216066, alpha: 1), for: .highlighted)

            case .Under :
                button.backgroundColor = .white
                button.setTitleColor( AppDelegate.colorApp, for: .normal)
                button.setTitleColor( AppDelegate.colorApp, for: .highlighted)
                button.layer.cornerRadius = 0

            case .Tint :
                button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .highlighted)
                button.layer.borderWidth = 2
                button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.backgroundColor = .white
            }
           
        
            if AppDelegate.isIPad {
                button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
                button.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight ).isActive = true
                button.layer.cornerRadius = AppDelegate.defaultHeight  / 2
             } else {
            button.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight).isActive = true
            button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
             }
            
        
    }
       
        
       
        
    static func defaultTextField(model:ModelTextField,textField:inout UITextField) {
            textField.placeholder = model.placeholder
            guard let image =  UIImage(systemName: model.imageName) else { return }
            let imageView = UIImageView()
            imageView.image = image
        imageView.tintColor =  AppDelegate.colorApp
            textField.attributedPlaceholder = NSAttributedString(string: model.placeholder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4037857826, green: 0.4037857826, blue: 0.4037857826, alpha: 1)])
            
            textField.font = UIFont.systemFont(ofSize: AppDelegate.defaultHeight / 3)
            textField.layer.shadowOffset = CGSize.zero
            textField.layer.shadowColor = #colorLiteral(red: 0.001304504663, green: 0.003943181947, blue: 0.1537871653, alpha: 0.1812753235)
            textField.layer.shadowOpacity = 1
            textField.textAlignment = .center
            textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textField.layer.masksToBounds = false
        if AppDelegate.isIPad {

            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
            textField.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight ).isActive = true
           

        } else {
            textField.layer.cornerRadius = AppDelegate.defaultHeight / 2

            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
            textField.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight).isActive = true
        }
        textField.layer.cornerRadius = AppDelegate.defaultHeight  / 2

        imageView.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: textField.leadingAnchor,constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.5).isActive = true
        imageView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.5).isActive = true

        }
 
    
    static func getMacAdress(separatorСharacter:String) -> String {
            var lastMacAdress = String()
           let myMacAdress = UIDevice.current.identifierForVendor?.uuidString
           
//           let yyyy:String? = "4194D757-8EB6-49A7-8257-70918EAB2710"
            if let macAdress = myMacAdress {
               print(macAdress)
            for (index , value) in macAdress.enumerated() {
                lastMacAdress.append(value)
               if index % 2 != 0 && index != 0 && index != macAdress.count - 1 {
                    lastMacAdress.append(separatorСharacter)
                }
                if value == "-" {
                lastMacAdress.removeAll()
                }
            }
                
            } else {
                lastMacAdress = "02:00:00:00:00:00"
            }
           print(lastMacAdress)
            return lastMacAdress
        }

    
}






    extension String {
        
    func addLocalizedString() -> String {
        var str = "uk"
        if let oldTitle = UserDefaults.standard.value(forKey: "Language") {
        str = AppDelegate.systemNameLanguage[oldTitle as! String]!
        }
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        
            subscript(index:Int) -> String {
                for (indexl ,value) in self.enumerated() {
                    if indexl == index {
                        return String(value)
                    }
                }
               return ""
            }
        
   


        
        mutating func normalDate() {
            var newDate = ""
            for i in self {
                if i == "-" {
                    newDate.append(".")

                } else {
                    newDate.append(i)
                }
            }
            self = newDate
        }
        
      
        
    }

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
}


