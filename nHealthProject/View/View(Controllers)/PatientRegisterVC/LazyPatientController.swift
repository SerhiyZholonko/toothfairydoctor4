//
//  LazyPatientController.swift
//  nHealthProject
//
//  Created by admin on 16.03.2021.
//

import UIKit
import RxSwift

class LazyPatientController: UIViewController {
    var lazyPatients = PublishSubject<[ModelLazyPatient]>()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textFieldPatients: UITextField!
    @IBOutlet weak var tableVIewPatienst: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField()
        createTableView()
        reguestPatients()
    }
    
    func createTextField() {
        let placeholder = "search_label".addLocalizedString()
        PrototypeVC.defaultTextField(model: ModelTextField(placeholder: placeholder , imageName: "text.magnifyingglass"), textField: &textFieldPatients)
        textFieldPatients.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    func createTableView() {
        tableVIewPatienst.rowHeight = AppDelegate.defaultHeight

            lazyPatients.bind(to: tableVIewPatienst.rx.items(cellIdentifier: "LazyCell")) { ( row, model, cell) in
                cell.textLabel?.text = model.patient_fio
                cell.tag = model.patient_id!
                
            }.disposed(by: disposeBag)
        
        tableVIewPatienst.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            
            let datail:TimeRecordingsVС = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimeRecordingsVС") as! TimeRecordingsVС
            
            datail.modalPresentationStyle = .overFullScreen
            datail.modelRegister.patient_id =  self!.tableVIewPatienst.cellForRow(at: indexPath)?.tag
            self?.view.endEditing(true)
            self!.textFieldPatients.text?.removeAll()
            self!.present(datail, animated: true, completion: nil)
          }).disposed(by: disposeBag)
        
        tableVIewPatienst.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -AppDelegate.defaultHeight).isActive = true
    }
    
    
    
    func reguestPatients() {
       
        textFieldPatients.rx.text.subscribe { [self] text in
            
            Requests.getLazyPatient(namePatient:textFieldPatients.text!) { arrayPatients in
                DispatchQueue.main.async {
                    print(text.debugDescription)
                    print(arrayPatients)
                    self.lazyPatients.onNext(arrayPatients)
                    self.tableVIewPatienst.reloadData()
                }
                return nil
            }
        }.disposed(by: disposeBag)
}
}

