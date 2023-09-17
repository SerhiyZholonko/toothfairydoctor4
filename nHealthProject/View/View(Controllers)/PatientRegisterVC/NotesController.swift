//
//  NotesController.swift
//  nHealthProject
//
//  Created by admin on 21.03.2021.
//

import UIKit
import RxSwift

class NotesController: UIViewController {
    let gestureSwipeKeyboardEd = UISwipeGestureRecognizer()

    var modelRegister = NewPatientModel()
    var noteTextField = UITextField()
    @IBOutlet var myScrollView: UIScrollView!
    
   

    var wdTextView = UITextView()
    var tableViewData = PublishSubject<[ModelRoom]>.just(AppDelegate.roomData)
    var tableViewRooms = UITableView()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollViewSetting()
        createTextField()
        createTextView()
        createTableView()
        keyboardFrame()
        createGesture()
        
    }
    
    

    func createGesture() {
        gestureSwipeKeyboardEd.direction = [.left,.right,.down,.up]
        gestureSwipeKeyboardEd.addTarget(self, action: #selector(clouseKeyboarg))
        self.myScrollView.addGestureRecognizer(gestureSwipeKeyboardEd)
    }
    
    
    @objc func clouseKeyboarg() {
        self.view.endEditing(true)
    }
    
    func createTableView() {
        tableViewRooms.rowHeight = AppDelegate.defaultHeight
        tableViewRooms.translatesAutoresizingMaskIntoConstraints = false
        self.myScrollView.addSubview(tableViewRooms)
        tableViewRooms.topAnchor.constraint(equalTo: wdTextView.bottomAnchor, constant: 10).isActive = true
        tableViewRooms.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        tableViewRooms.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        tableViewRooms.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 3).isActive = true

        tableViewRooms.register(UITableViewCell.self, forCellReuseIdentifier: "RoomCellNotes")
        tableViewData.bind(to: tableViewRooms.rx.items(cellIdentifier: "RoomCellNotes")) { ( row, model, cell) in
            cell.textLabel?.text = model.room_name
            cell.textLabel?.textAlignment = .center
        }.disposed(by: disposeBag)
        
        tableViewRooms.rx.itemSelected
            .subscribe(onNext: { indexPath in
            UserDefaults.standard.setValue(indexPath.row, forKey: AppDelegate.roomIdentifier)
            }).disposed(by: disposeBag)
            }
    
    
    
    @IBAction func okAction(_ sender: Any) {
        let isNotEmptyContent = (modelRegister.patient_fname != "" && modelRegister.patient_sname != "") || modelRegister.patient_id != nil
        // not optional /
        if isNotEmptyContent {
            if let room_id =  UserDefaults.standard.value(forKey:AppDelegate.roomIdentifier) as? Int {
                modelRegister.task_room_id = room_id + 1
            } else {
                modelRegister.task_room_id = 1
            }
        }
        
        modelRegister.doctor_id = AppDelegate.doctor_id
        modelRegister.task_workplace_id = 1
        modelRegister.task_wd = wdTextView.text ?? ""
        modelRegister.task_cm = noteTextField.text ?? ""
        Requests.addTask(addData: modelRegister)
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    })
        
    }
    @IBAction func goBakAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func createTextField() {
        myScrollView.addSubview(noteTextField)
        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: "comment_placeholder".addLocalizedString(), imageName: "doc.plaintext"), textField: &noteTextField)
        noteTextField.topAnchor.constraint(equalTo: self.myScrollView.topAnchor, constant: AppDelegate.defaultHeight * 2).isActive = true
        noteTextField.centerXAnchor.constraint(equalTo: self.myScrollView.centerXAnchor).isActive = true

    }
   
    func createTextView() {
        wdTextView.layer.borderWidth = 0.5
        wdTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        wdTextView.layer.cornerRadius = AppDelegate.defaultHeight / 2
        wdTextView.layer.masksToBounds = true
        wdTextView.translatesAutoresizingMaskIntoConstraints = false
        wdTextView.font = UIFont.systemFont(ofSize: 20)
        self.myScrollView.addSubview(wdTextView)
        
        wdTextView.topAnchor.constraint(equalTo: noteTextField.bottomAnchor, constant: 15).isActive = true
        wdTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).isActive = true
        wdTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        wdTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
    }
    
    func scrollViewSetting() {
        let selfBounds = AppDelegate.selfBounds
        myScrollView.translatesAutoresizingMaskIntoConstraints = true
        myScrollView.frame = selfBounds
        myScrollView.contentSize = selfBounds.size

    }
    
    func keyboardFrame() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [self] keyboard in
            if let keyboardSize = (keyboard.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight : Int = Int(keyboardSize.height)
                UIView.animate(withDuration: 0.4) {
                    self.myScrollView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - CGFloat(keyboardHeight))
                }
                
                
               }
         }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            UIView.animate(withDuration: 0.4) { [self] in
                myScrollView.frame = AppDelegate.selfBounds
            }        }
     }

    
}
