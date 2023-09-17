//
//  CalendarVC.swift
//  nHealthProject
//
//  Created by admin on 11.02.2021.
//

import UIKit
import RxCocoa
import RxSwift

    class CaledarVC: UIViewController {
        let patient = PatientViewController()
        var anchorView = UIView()
        var picker:UIDatePicker = UIDatePicker()
        var presentLabel = UILabel()
        var titleLabel = UILabel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.setNavigationBarHidden(true, animated:false)
            self.view.backgroundColor = #colorLiteral(red: 0.9774515171, green: 0.9774515171, blue: 0.9774515171, alpha: 1)
            createPicker()
            createPatientCollection()
            createGesturesRecognizer()
            
        }
        func createGesturesRecognizer() {
            let panGestureRecohnizer = UIPanGestureRecognizer(target: self, action: #selector(handletPan(paramPan:)))
                                                              
            view.addGestureRecognizer(panGestureRecohnizer)
        }
      
        
       
        @IBAction func goBackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFirstAcc"), object: nil)
            navigationController?.popViewController(animated: true)
        }
        @objc func handletPan(paramPan:UIPanGestureRecognizer){
            let tapPoint = paramPan.location(in: view) // расположение пальца
            print(tapPoint)


            patient.view.frame.origin.y = tapPoint.y
            if  tapPoint.y > view.center.y  && paramPan.state == .recognized {
                UIView.animate(withDuration: 0.3) { [self] in

                        patient.view.frame.origin.y = view.center.y + AppDelegate.defaultHeight * 3
                    }
            } else if paramPan.state == .recognized {
                UIView.animate(withDuration: 0.3) { [self] in
                        patient.view.frame.origin.y =  AppDelegate.defaultHeight
                        
                    }
            }
            
            
        }
        
      
        func createPicker() {
            picker.addTarget(self, action: #selector(valueChange(picker:)), for: .valueChanged)
            picker.translatesAutoresizingMaskIntoConstraints = false

            picker.datePickerMode = .date
            picker.tintColor = AppDelegate.colorApp
            picker.backgroundColor = .white
            picker.contentVerticalAlignment = .fill
            picker.contentHorizontalAlignment = .fill
//            picker.intrinsicContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            if #available(iOS 14.0, *) {
                picker.preferredDatePickerStyle = .inline
            } else {
                // Fallback on earlier versions
            }
            
            self.view.addSubview(picker)
            picker.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
            picker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            picker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            picker.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
            picker.topAnchor.constraint(equalTo: self.view.topAnchor,constant: AppDelegate.defaultHeight * 1.5).isActive = true
        }
        
       
       
}


extension CaledarVC {
    
    
   
    @objc func popnav() {
    self.navigationController?.popViewController(animated: false)
}
    
    
    
    @objc func valueChange(picker:UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        var now = df.string(from: picker.date)
        let weekday = Calendar.current.component(.weekday, from: picker.date)
        print(weekday)
        now.normalDate()
        patient.date = picker.date
        patient.reload()
    }
    
    func createPatientCollection() {
        let designView = UIView()
        designView.backgroundColor = #colorLiteral(red: 0.3068786661, green: 0.332264238, blue: 0.3691431681, alpha: 1)
        designView.translatesAutoresizingMaskIntoConstraints = false
        designView.layer.cornerRadius = 2
        designView.layer.masksToBounds = true
        patient.view.addSubview(designView)
        designView.centerYAnchor.constraint(equalTo: patient.view.topAnchor, constant: AppDelegate.defaultHeight / 2).isActive = true
        designView.centerXAnchor.constraint(equalTo: patient.view.centerXAnchor).isActive = true
        designView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        designView.heightAnchor.constraint(equalToConstant: 4).isActive = true

        patient.view.layer.borderWidth = 0.5
        patient.view.layer.borderColor = #colorLiteral(red: 0.858529062, green: 0.858529062, blue: 0.858529062, alpha: 1)
        patient.view.backgroundColor = .white
        patient.pacientsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        patient.view.layer.cornerRadius = AppDelegate.defaultHeight
        patient.view.layer.masksToBounds = true
        patient.view.translatesAutoresizingMaskIntoConstraints = false
        patient.pacientsCollection.removeFromSuperview()
        patient.view.addSubview(patient.pacientsCollection)
        patient.pacientsCollection.topAnchor.constraint(equalTo: patient.view.topAnchor, constant: AppDelegate.defaultHeight).isActive = true
        patient.pacientsCollection.leadingAnchor.constraint(equalTo: patient.view.leadingAnchor).isActive = true
        patient.pacientsCollection.trailingAnchor.constraint(equalTo: patient.view.trailingAnchor).isActive = true
        patient.pacientsCollection.bottomAnchor.constraint(equalTo: patient.view.bottomAnchor).isActive = true

        patient.pacientsCollection.layoutIfNeeded()

        self.view.addSubview(patient.view)

        patient.view.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        patient.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        patient.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        patient.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - AppDelegate.defaultHeight / 1.5).isActive = true
            patient.view.layoutIfNeeded()
        patient.pacientsCollection.updateConstraints()
        
        patient.view.layoutIfNeeded()

    }
}


