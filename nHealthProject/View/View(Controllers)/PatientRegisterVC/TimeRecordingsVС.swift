//
//  TimeRecordingsVС.swift
//  nHealthProject
//
//  Created by admin on 21.03.2021.
//

import UIKit
import RxSwift
class TimeRecordingsVС: UIViewController {
    @IBOutlet weak var startSlidel: UISlider!
    var continueButton = UIButton()
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    var modelRegister = NewPatientModel()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var calendarOutlet: UIDatePicker!
    @IBOutlet weak var endSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        labelsTimeContent()
        createContinueButton()
        NotificationCenter.default.addObserver(self, selector: #selector(popView), name: Notification.Name("dismiss"), object: nil)
        constraints()
    }
    
   
    func constraints() {
        calendarOutlet.translatesAutoresizingMaskIntoConstraints = false
        if  AppDelegate.isIPad {

            calendarOutlet.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true

            calendarOutlet.topAnchor.constraint(equalTo: endSlider.bottomAnchor, constant: AppDelegate.defaultHeight).isActive = true
        } else {
            calendarOutlet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            calendarOutlet.widthAnchor.constraint(equalToConstant: AppDelegate.selfBounds.width).isActive = true
            calendarOutlet.topAnchor.constraint(equalTo: endSlider.bottomAnchor, constant: 10).isActive = true
        }
        
    }
    
    
    
    
    @objc func popView() {
        dismiss(animated: true, completion: nil)
    }
   
    func createContinueButton() {
        if AppDelegate.isIPad {
//            calendarOutlet.preferredDatePickerStyle = .wheels
        }
        let configuration = UIImage.SymbolConfiguration(pointSize: AppDelegate.defaultHeight * 1.1 ,weight: .ultraLight,scale: .large)
        let myImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)
        
        continueButton = UIButton.systemButton(with: myImage!, target: self, action: #selector(continueAction))
        continueButton.tintColor = .white
        continueButton.contentHorizontalAlignment = .fill
        continueButton.contentVerticalAlignment = .fill
        
        continueButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4040432355)
        continueButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        continueButton.layer.shadowOpacity = 1
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(continueButton)
        continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -AppDelegate.defaultHeight / 2).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
            }
   
    
    func labelsTimeContent() {
        startLabel.text = "start_time".addLocalizedString()
        endLabel.text = "end_time".addLocalizedString()
        titleLabel.text = "date_and_time".addLocalizedString()
    }
    
    

    @IBAction func endSliderAction(_ sender: Any) {
        if startSlidel.value < endSlider.value {
            endTimeLabel.text = timeSlider(aSlider: endSlider)
        } else {
            startSlidel.value = endSlider.value
            startTimeLabel.text = timeSlider(aSlider: startSlidel)
            endTimeLabel.text = timeSlider(aSlider: startSlidel)

        }
    }
    @IBAction func startSliderAction(_ sender: Any) {
        if startSlidel.value < endSlider.value {
        startTimeLabel.text = timeSlider(aSlider: startSlidel)
        } else {
            startSlidel.value = endSlider.value
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @objc func continueAction() {
       let notesVC  =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesController") as! NotesController
        notesVC.modalPresentationStyle = .fullScreen
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: calendarOutlet.date)
        modelRegister.task_begin = startTimeLabel.text
        modelRegister.task_end = endTimeLabel.text
        modelRegister.task_date  = dateString
        notesVC.modelRegister = modelRegister
        present(notesVC, animated: true, completion: nil)
    }
    
    
    func timeSlider(aSlider: UISlider)-> String {
        let numberOfSlots = 24 * 4 - 1
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        let zeroDate = dateFormat.date(from: "00:00")
        let actualSlot = roundf(Float(numberOfSlots)*Float(aSlider.value))
        let slotInterval:TimeInterval = TimeInterval(actualSlot * 15 * 60)
        let slotDate: NSDate = NSDate(timeInterval: slotInterval, since: zeroDate!)
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: slotDate as Date)
    }
    
    
    
}

