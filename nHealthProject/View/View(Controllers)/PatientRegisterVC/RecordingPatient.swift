//
//  RecordingPatient.swift
//  nHealthProject
//
//  Created by admin on 16.03.2021.
//

import UIKit
import RxSwift

class RecordingPatient: UIViewController {
    var lockalcontent = NewPatientModel()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let disposeBag = DisposeBag()
    var content : Observable<[MyCellTable]> = Observable.just([])
    @IBOutlet weak var tableViewContent: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "write_down".addLocalizedString()
        createDataCells()
        createTableView()
        keyboardFrame()
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFirstAcc"), object: nil)

        navigationController?.popViewController(animated: true)
    }
    
    
    func createTableView() {
        
        let lazyPatient:LazyPatientController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LazyPatientController") as! LazyPatientController
        
        lazyPatient.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height)

        self.view.addSubview(lazyPatient.view)
        
        segmentControl.setTitle("new_patient".addLocalizedString(), forSegmentAt: 0)
        segmentControl.setTitle("regular_patient".addLocalizedString(), forSegmentAt: 1)

        segmentControl.rx.selectedSegmentIndex.subscribe { event  in
            if  event.element == 1 {
            lazyPatient.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height)
           
                UIView.animate(withDuration: 0.4) { [self] in
                           lazyPatient.view.frame = tableViewContent.frame
                           }
                } else {
                UIView.animate(withDuration: 0.4) {
                    lazyPatient.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
            
        }.disposed(by: disposeBag)
        
        content.bind(to: tableViewContent.rx.items(cellIdentifier: "TableContentCell", cellType: TableViewCellRecord.self )){ [self] row , modelCell , cell  in
            cell.selectionStyle = .none
            if let textField = cell.textField {
                textField.rx.text.subscribe({ [unowned self] text in
                    
                    switch row {
                    case 0 :
                        print(textField.text ?? "","-------")
                        lockalcontent.patient_fname = textField.text ?? ""
                    case 1 :
                        print(text)
                        lockalcontent.patient_sname = textField.text ?? ""
                    case 2 :
                        print(text)
                        lockalcontent.patient_lname = textField.text ?? ""
                    case 3 :
                        print(text)
                        lockalcontent.patient_mobile = textField.text ?? ""
                        
                    default :
                    break
                    }
                print(lockalcontent.patient_fname ?? "" , "==--------")
                    
                }).disposed(by: disposeBag)
                cell.textField?.rx.controlEvent([.editingDidEndOnExit])
                         .subscribe(onNext:{ text in
                self.view.endEditing(true)
                            
                }).disposed(by: disposeBag)
                }
            
           
        
            tableViewContent.rowHeight = 80
            
            if row == 4 {
                cell.textField = nil
                cell.accessoryType = .disclosureIndicator
                cell.accessoryView?.tintColor = .lightGray
            }
        cell.titleLabel.text = modelCell.titleLabel
        }.disposed(by: disposeBag)
        

        
        
        tableViewContent.rx.itemSelected
          .subscribe(onNext: { [self] indexPath in
            if indexPath.row == 4 {
                self.view.endEditing(true)
                let datail:TimeRecordingsVС = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimeRecordingsVС") as! TimeRecordingsVС
                let isEmptyData = lockalcontent.patient_fname ?? "" == "" || lockalcontent.patient_sname ?? "" == ""
                let titleAlert = "fill_in_the_blank_fields".addLocalizedString()
                if isEmptyData {
                let alertController = UIAlertController(title: titleAlert, message: "", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
                        return
                    }
                    alertController.addAction(alertAction)
                    present(alertController, animated: true, completion: nil)
                }
                datail.modalPresentationStyle = .overFullScreen
                datail.modelRegister.doctor_id = AppDelegate.doctor_id
                datail.modelRegister = lockalcontent
                
                
                self.present(datail, animated: true)
                
            }
          }).disposed(by: disposeBag)
    }
    
    
func createDataCells() {
    content = Observable.just([MyCellTable(titleLabel: "name_placeholder".addLocalizedString()),
    MyCellTable(titleLabel: "surname_placeholder".addLocalizedString()),
    MyCellTable(titleLabel: "patronymic_placeholder".addLocalizedString()),
    MyCellTable(titleLabel: "number_phone".addLocalizedString()),
    MyCellTable(titleLabel: "continue_button".addLocalizedString()
    )])
    
}
    func keyboardFrame() {
         NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = -100
         }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
           self.view.frame.origin.y = 0
        }
     }
}
