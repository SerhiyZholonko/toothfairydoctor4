//
//  FirstAccVC.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import UIKit
import RxSwift

class FirstVCAccount: UIViewController, UIGestureRecognizerDelegate  {
    var reloadClosure = {() -> () in return }
    let disposeBag = DisposeBag()

    let swipeLeft = UISwipeGestureRecognizer()
    let swipeRight = UISwipeGestureRecognizer()
    var datePresent = Date()
    var data = DoctorData()
    let patient = PatientViewController()
    var buttonPlus = UIButton()
    var dateLabel = UILabel()
    

    @IBOutlet weak var centralButton: UIButton!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewDoctorImage: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageDoctor: UIImageView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated:true)
        self.navigationController?.delegate = self
        getRoomsData()
        createButton(button: &menuButton)
        nameLabels()
        createBackgroundImage()
        createViewImageDoctor()
        createBarView()
        createCentralButton()
        createDateLabel()

        createCollectionToday()

        createGesture()
        createPlusButtonNewPatient()
        createNotifucationReload()
        
           }
    func createNotifucationReload() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSelfView), name: Notification.Name("reloadFirstAcc"), object: nil)

    }
    @objc func reloadSelfView() {
        patient.reload()
    }
    
    func getRoomsData() {
        Requests.roomData { array  in
            print(array)
            
            AppDelegate.roomData = array
            if UserDefaults.standard.value(forKey: AppDelegate.roomIdentifier) as? Int == nil {
                UserDefaults.standard.setValue(0, forKey: AppDelegate.roomIdentifier)
            }
            return nil
        }
    }
    
    
    
    
     func createGesture() {
        swipeLeft.direction = . left
        swipeRight.direction = .right
        swipeLeft.addTarget(self, action: #selector(actionSwipes(param:)))
        swipeRight.addTarget(self, action: #selector(actionSwipes(param:)))
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
   
        func createButton(button:inout UIButton) {
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4840861946)
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowOpacity = 1
    }


  
    //MARK:Supplemented in Code
    
    func createBackgroundImage() {
        backgroundImage.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 3).isActive = true
    }
    func createViewImageDoctor() {
        if let imageData = UserDefaults.standard.value(forKey: "doctorImage") {
        imageDoctor.image = UIImage(data: imageData as! Data)
        } else {
        imageDoctor.image = UIImage(named: "Снимок экрана 2021-03-22 в 9.24.54 AM")
        }
        
        viewDoctorImage.layer.cornerRadius = AppDelegate.defaultHeight * 1.5
        viewDoctorImage.layer.masksToBounds = true
        viewDoctorImage.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
        viewDoctorImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        viewDoctorImage.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 3).isActive = true
        viewDoctorImage.widthAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 3).isActive = true
    }
    func createBarView() {
        
        viewBar.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight ).isActive = true
    }
    func createCentralButton() {
        centralButton.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 1.5).isActive = true
        centralButton.widthAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 1.5).isActive = true
    }

    func nameLabels() {
        surnameLabel.font = UIFont.systemFont(ofSize: 25)
        lastNameLabel.font = UIFont.systemFont(ofSize: 25)
        surnameLabel.textColor = .black
        lastNameLabel.textColor = .black

        surnameLabel.text = data.user_lname
        lastNameLabel.text = data.user_fname! + " " + data.user_mname!
    }
    //MARK:Create in Code
    func createDateLabel() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let dateString = df.string(from: datePresent)
        dateLabel.text = dateString
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.layer.borderWidth = 2
        dateLabel.textAlignment = .center
        dateLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6894925351)
        dateLabel.layer.cornerRadius = AppDelegate.defaultHeight / 4
        dateLabel.layer.masksToBounds = true
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateLabel)
        
        dateLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 10).isActive = true
        if AppDelegate.isIPad {
            dateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
            dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        } else {
            dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:30).isActive = true
            dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        }
        
        dateLabel.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 2).isActive = true
    }
    
    
    func createCollectionToday() {
        patient.date = datePresent

        patient.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(patient.view)
        
        patient.view.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        patient.view.bottomAnchor.constraint(equalTo: viewBar.topAnchor).isActive = true
        patient.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        patient.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    
    func createPlusButtonNewPatient() {
        let configuration = UIImage.SymbolConfiguration(pointSize: AppDelegate.defaultHeight * 1.1 ,weight: .ultraLight,scale: .large)
        let myImage = UIImage(systemName: "plus.circle.fill", withConfiguration: configuration)
        buttonPlus = UIButton.systemButton(with: myImage!, target: self, action: #selector(plusPatientAction))
        buttonPlus.tintColor = .white
        buttonPlus.contentHorizontalAlignment = .fill
        buttonPlus.contentVerticalAlignment = .fill
        createButton(button: &buttonPlus)
       
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonPlus)

        buttonPlus.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        buttonPlus.centerYAnchor.constraint(equalTo: viewBar.topAnchor).isActive = true
            }
   
}
 

extension FirstVCAccount: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    private func chooseImage(sourceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageDoctor.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        let newData = imageDoctor.image?.pngData()
        UserDefaults.standard.setValue(newData, forKey: "doctorImage")
        dismiss(animated: true, completion: nil)
    }
    
}




extension FirstVCAccount : UITextFieldDelegate , UICollectionViewDelegateFlowLayout{
    //MARK:Actions
    @IBAction func actionCenterButton(_ sender: Any) {
    let settings:SettingInAccVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingInAccVC") as! SettingInAccVC
        navigationController?.pushViewController(settings, animated: true)
    }
    
    @IBAction func newImageDoctor(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let library = UIAlertAction(title: "Library", style: .default) { [self] alert  in
            chooseImage(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default ,handler: nil)
        

        alertController.addAction(library)
        alertController.addAction(cancel)

        present(alertController, animated: true, completion: nil)
        
    }
    
  
    
    @IBAction func exitAction(_ sender: Any) {
      
        let titleController = "account_out".addLocalizedString()
        
        let messeageController = "account_out_messeage".addLocalizedString()
        let titleAction = "yes".addLocalizedString()
        let titleActionNot = "no".addLocalizedString()
        reloadClosure()

        
        
        let alertController = UIAlertController(title: titleController, message: messeageController, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: titleAction, style: .destructive) {  _ in
            self.navigationController?.popViewController(animated: false)
        }
        let alertNotAction = UIAlertAction(title: titleActionNot, style: .destructive, handler: nil)
        alertController.addAction(alertNotAction)
        alertController.addAction(alertAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @objc func plusPatientAction() {
    let recordingVC:RecordingPatient = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecordingPatient") as! RecordingPatient
      
        navigationController?.pushViewController(recordingVC, animated: false)
    }
    
    @objc func actionSwipes(param:UISwipeGestureRecognizer) {
        
        if param.direction == .left {
            print("left")
            datePresent = datePresent.dayAfter
            print(datePresent)
            } else {
            print("right")
            datePresent = datePresent.dayBefore
            print(datePresent)
        }
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let dateString = df.string(from: datePresent)
        dateLabel.text = dateString
        patient.date = datePresent
        patient.reload()
    }
}

