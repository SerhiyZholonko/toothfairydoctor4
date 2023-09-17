//
//  ContentPatientVC.swift
//  nHealthProject
//
//  Created by admin on 05.03.2021.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class ContentPatientVC: UIViewController {
    var contentCell = UserData()
    var reloadClosure = {() -> () in return }
    var date = Date()
    let disposeBag = DisposeBag()
    var content : Observable<[MyCellTable]> = Observable.just([])
    
    @IBOutlet weak var tableViewContent: UITableView!
    var patientsCollection = UICollectionView(frame:UIScreen.main.bounds, collectionViewLayout: .init())
        @IBOutlet var endTime: UILabel!
        @IBOutlet var startTime: UILabel!
        @IBOutlet var monthTitle: UILabel!
        @IBOutlet var weekDay: UILabel!
        @IBOutlet var patientLabel: UILabel!
        override func viewDidLoad() {
        super.viewDidLoad()
        print(contentCell)
        createTitleLabels()
        createDataCells()
        createTableView()
    }
    func createTitleLabels() {
        
        let patientText = "patient_localizable".addLocalizedString()
        let weekdayNum = Calendar.current.component(.weekday, from: date)
        let dateDay = Calendar.current.component(.day, from: date)
        let monthNum = Calendar.current.component(.month, from: date)
        var weekDayText = "\(weekdayNum)_day".addLocalizedString()
        let monthText = "\(monthNum)_month".addLocalizedString()
        weekDayText += "," + String(dateDay)
        
        startTime.text = contentCell.task_startTime
        endTime.text = contentCell.task_endTime
        
        settingLabels(label: &weekDay, text: weekDayText)
        settingLabels(label: &monthTitle, text: monthText)
        settingLabels(label: &patientLabel, text: patientText + ",")

    }
    
    func settingLabels(label:inout UILabel,text:String) {
        label.font = UIFont.systemFont(ofSize: AppDelegate.defaultHeight / 1.7)
        label.text = text
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    func createDataCells() {
        content = Observable.just([MyCellTable(content: contentCell.patient_fname ?? "", titleLabel: "name_placeholder".addLocalizedString()),
        MyCellTable(content: contentCell.patient_sname ?? "", titleLabel: "surname_placeholder".addLocalizedString()),
        MyCellTable(content: contentCell.patient_lname ?? "", titleLabel: "patronymic_placeholder".addLocalizedString()),
        MyCellTable(content: contentCell.patient_mobile ?? contentCell.patient_mobile ?? "", titleLabel: "number_phone".addLocalizedString()),
        MyCellTable(content: contentCell.task_comment ?? "", titleLabel: "comment_placeholder".addLocalizedString()
        ) ,  MyCellTable(content:  "", titleLabel: contentCell.task_workdescription ?? ""
        )])
    }
    func createTableView() {
        tableViewContent.topAnchor.constraint(equalTo: monthTitle.bottomAnchor, constant: AppDelegate.defaultHeight).isActive = true
        
        content.bind(to: tableViewContent.rx.items(cellIdentifier: "TableContentCell")) { [self] row , modelCell , cell  in
            
            tableViewContent.rowHeight = 80
            
            cell.textLabel?.text = modelCell.titleLabel
            cell.detailTextLabel?.text = modelCell.content ?? ""
            
            if row == 5 {
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = ""
                
                tableViewContent.rowHeight = AppDelegate.defaultHeight * 5
                let label = UILabel()
                
                label.text = modelCell.titleLabel
                label.font = cell.textLabel?.font
                label.frame = cell.textLabel!.bounds
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.translatesAutoresizingMaskIntoConstraints = false
                
                let scrollView = UIScrollView()
                scrollView.addSubview(label)
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                
                scrollView.contentSize = CGSize(width: scrollView.frame.height, height: 200 * 2)
                
                cell.addSubview(scrollView)
                scrollView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                scrollView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
                scrollView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true

                label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                label.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
                label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

                
            }
            
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
        }.disposed(by: disposeBag)
    }
    
    
    @IBAction func deletePatient(_ sender: Any) {
        Requests.deletePatient(taskId: contentCell.task_id!){ [self] in
            dismiss(animated: true, completion: nil)
            reloadClosure()
            return nil
        }
    }
    
    
}


