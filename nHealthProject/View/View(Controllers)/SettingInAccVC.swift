//
//  SettingInAccVC.swift
//  nHealthProject
//
//  Created by admin on 11.03.2021.
//

import UIKit
import RxSwift

class SettingInAccVC: UIViewController {

    let roomData = AppDelegate.roomData
    @IBOutlet var settingsLabel: UILabel!
    let cellRoomIdentifier = "CellRoom"
    let languageIndentifier = "CellLanguage"
    var tableViewLanguage = UITableView()
    
    @IBOutlet var myRoomLabel: UILabel!
    @IBOutlet var endTimePicker: UIDatePicker!
    @IBOutlet var startTimePicker: UIDatePicker!
    @IBOutlet var roomsLabel: UILabel!
    @IBOutlet var workTimeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableViewRooms: UITableView!
    @IBOutlet var languageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimePicker.minuteInterval = 15
        endTimePicker.minuteInterval = 15
        
        createContentPicker()
        createLocalizedLabels()
        createTableView()
        createTitleLabel()
        createLabguageButton()
        createLabguageTableView()
     
    }
    
    func createContentPicker() {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        df.locale = Locale.init(identifier: "ru_RU")

        if let timeStart = UserDefaults.standard.value(forKey: "WorkStartTime") as? String , let  timeEnd = UserDefaults.standard.value(forKey: "WorkEndTime") as? String {
            startTimePicker.date = df.date(from: timeStart)!
            endTimePicker.date = df.date(from: timeEnd)!
            
        } else {
            startTimePicker.date = df.date(from: "09:00")!
            endTimePicker.date = df.date(from: "18:00")!
            
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        print(endTimePicker.date)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFirstAcc"), object: nil)
        let df = DateFormatter()
        df.locale = Locale.init(identifier: "ru_RU")
        df.dateFormat = "HH:mm"
        let startTime = df.string(from: startTimePicker.date)
        let endTime = df.string(from: endTimePicker.date)
        print("hjdbfhvbdhjv      \(startTime)")
        UserDefaults.standard.setValue(startTime, forKey: "WorkStartTime")
        UserDefaults.standard.setValue(endTime, forKey: "WorkEndTime")
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func languageAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [self] in
            tableViewLanguage.frame = CGRect(x: 0, y:  languageButton.frame.minY, width: UIScreen.main.bounds.width , height: AppDelegate.defaultHeight * 3)

        }
    }
    func createLabguageTableView() {
        tableViewLanguage.delegate = self
        tableViewLanguage.dataSource = self
        tableViewLanguage.rowHeight = AppDelegate.defaultHeight

        tableViewLanguage.frame = CGRect(x: 0, y:  languageButton.frame.maxY, width: UIScreen.main.bounds.width , height: 0)
        
        tableViewLanguage.register(UITableViewCell.self, forCellReuseIdentifier: languageIndentifier)
        self.view.addSubview(tableViewLanguage)
    }
    
    func createLocalizedLabels() {
        myRoomLabel.text = "the_room".addLocalizedString() + ":"
        settingsLabel.text = "settings".addLocalizedString()
        roomsLabel.text = "change_room_label".addLocalizedString()
        workTimeLabel.text = "work_time_label".addLocalizedString()
    }


    func createLabguageButton() {
        guard let titleLabelLangButton =  UserDefaults.standard.value(forKey: AppDelegate.languageKey) as? String else {return}
        languageButton.setTitle(titleLabelLangButton, for: .normal)
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        languageButton.layer.cornerRadius = AppDelegate.defaultHeight / 3
        languageButton.layer.masksToBounds = true
        languageButton.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight / 1.5 ).isActive = true
        languageButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        }
    
    func createTitleLabel() {
         let indexRoom = UserDefaults.standard.value(forKey: AppDelegate.roomIdentifier) as! Int
        print(roomData)
        titleLabel.text = roomData[indexRoom].room_name
    }
    func createTableView() {
        tableViewRooms.delegate = self
        tableViewRooms.dataSource = self

        self.tableViewRooms.register(UITableViewCell.self, forCellReuseIdentifier: cellRoomIdentifier)
        tableViewRooms.rowHeight = AppDelegate.defaultHeight
        tableViewRooms.heightAnchor.constraint(equalToConstant: AppDelegate.defaultHeight * 4).isActive = true
        
        
        
        
        
        
        
        
        
    }
   
    
    
    
}
extension SettingInAccVC :UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewRooms {
            return   roomData.count
        } else {
            return AppDelegate.language.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewRooms {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRoomIdentifier, for: indexPath)
            
            cell.textLabel?.text = roomData[indexPath.row].room_name
        cell.textLabel?.textAlignment = .center
        return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: languageIndentifier, for: indexPath)
        cell.textLabel?.text = AppDelegate.language[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewRooms {
            titleLabel.text = roomData[indexPath.row].room_name
        
        UserDefaults.standard.setValue(indexPath.row , forKeyPath: AppDelegate.roomIdentifier )
            
            
        } else {
        UserDefaults.standard.setValue(AppDelegate.language[indexPath.row], forKey: AppDelegate.languageKey)
        languageButton.setTitle(AppDelegate.language[indexPath.row], for: .normal)
        }

        UIView.animate(withDuration: 0.3) { [self] in
        tableViewLanguage.frame = CGRect(x: 0, y:  languageButton.frame.maxY, width: UIScreen.main.bounds.width , height: 0)
        }
        createLocalizedLabels()
        createTitleLabel()
    }
}
