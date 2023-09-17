//
//  PacientViewController.swift
//  nHealthProject
//
//  Created by admin on 12.02.2021.
//

import UIKit
import RxSwift

protocol ReloadCollectionView {
    func reload()
}
class PatientViewController: UIViewController , UICollectionViewDelegateFlowLayout {

    var collectionModel = PublishSubject<[UserData]>()
    let disposeBag = DisposeBag()
    let labelEmpty = UILabel()
    let userVM = Requests()
    var date = Date()
    var pacientsCollection = UICollectionView(frame:UIScreen.main.bounds, collectionViewLayout: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        notPacient()
        reguestPatients()
        createCollectionViewPacient()
        createContentCell()
        touchCellCollectionView()
    }
    
    //MARK:Create label Empty collection view
        func notPacient() {
        labelEmpty.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5062635813)
        labelEmpty.textAlignment = .center
        labelEmpty.translatesAutoresizingMaskIntoConstraints = false
        labelEmpty.font = UIFont(name: "PingFangHK-Semibold", size: 22)
     
        self.view.addSubview(labelEmpty)
        labelEmpty.topAnchor.constraint(equalTo: self.view.topAnchor, constant: AppDelegate.defaultHeight * 2).isActive = true
        labelEmpty.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
   
    //MARK:Create collection view
    func createCollectionViewPacient(){
        let frameScreen = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        var width:CGFloat = 0
        //size cell
        if AppDelegate.isIPad {
            width = UIScreen.main.bounds.width / 2
        } else {
            width = pacientsCollection.frame.width - 60
        }
        let size = CGSize(width:  width , height: AppDelegate.defaultHeight * 2)
        
        layout.itemSize = size
        pacientsCollection.setCollectionViewLayout(layout, animated: true)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        pacientsCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        pacientsCollection.register(PacientCollectionVCell.self, forCellWithReuseIdentifier: "PacientCollectionVCell")
       
        pacientsCollection.translatesAutoresizingMaskIntoConstraints = false
        pacientsCollection.backgroundColor = .clear
        pacientsCollection.alwaysBounceVertical = true
        pacientsCollection.showsHorizontalScrollIndicator = false

        // create refresh
        let refreshControl: UIRefreshControl = UIRefreshControl()
        pacientsCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)

        self.view.addSubview(pacientsCollection)
        
        if AppDelegate.isIPad {
            pacientsCollection.widthAnchor.constraint(equalToConstant: frameScreen.width / 2 + 60).isActive = true
        } else {
            pacientsCollection.widthAnchor.constraint(equalToConstant: frameScreen.width ).isActive = true

        }
        pacientsCollection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pacientsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pacientsCollection.topAnchor.constraint(equalTo: view.topAnchor,constant: AppDelegate.defaultHeight / 3).isActive = true

    }
    
    //MARK:Content cell
    func createContentCell() {
        collectionModel.bind(to: pacientsCollection.rx.items(cellIdentifier: "PacientCollectionVCell", cellType: PacientCollectionVCell.self)) {( row, model, cell) in

            cell.nameLabel.text = model.patient_fio ?? ""
            cell.podLabel.text = model.task_endTime ?? ""
            cell.titleLabel.text = model.task_startTime ?? ""
            print(cell.nameLabel)
            
            cell.backgroundColor = .white
            cell.layer.cornerRadius = cell.frame.height / 4
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1631599073)
            cell.layer.shadowOpacity = 100
            cell.layer.masksToBounds = false
            cell.reloadInputViews()
            }.disposed(by: disposeBag)
    }
    
    //MARK:Touch cell , go detail data
    func touchCellCollectionView() {
        pacientsCollection
                .rx
                .modelSelected(UserData.self)
            .subscribe(onNext: { [self] (model) in
                    let detail:ContentPatientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentPatientVC") as! ContentPatientVC
                    //        detail.delegate = self
                            detail.date = date
                            detail.contentCell = model
                detail.reloadClosure = {
                    self.reload()
                }
                detail.modalTransitionStyle = .crossDissolve // это значение можно менять для разных видов анимации появления
                detail.modalPresentationStyle = .overFullScreen
                        present(detail, animated: true, completion: nil)
                }).disposed(by: disposeBag)
    }
    
    
    
 
    }
 
extension PatientViewController : ReloadCollectionView {
    //MARK:Request patients data
    func reguestPatients() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        var dateOfDay = df.string(from:date)
        
        dateOfDay.normalDate()
        userVM.userFunc(date: dateOfDay) { [self] array in
            DispatchQueue.main.async { [self] in
                var newArray:[UserData] = []
                for i in array {
                    if i.patient_fname != nil {
                        newArray.append(i)
                    }
                }
            
                self.collectionModel.onNext(newArray)
                if newArray.isEmpty {
                    let textEmpty = "no_data".addLocalizedString()
                    self.labelEmpty.text = textEmpty
                } else {
                    self.labelEmpty.text = ""
                }
                self.pacientsCollection.reloadData()
                self.pacientsCollection.refreshControl?.endRefreshing()
            }
            return nil
        }
            
        }
    //MARK:Reload collection view
    @objc func reload() {
        reguestPatients()
        pacientsCollection.reloadData()
    }
}






