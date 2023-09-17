//
//  ViewModel.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import Foundation

class ViewModelEnter {
    
    static func enterFunc(login:String,password:String,comlitionLockal:@escaping(DoctorData)->()?) {
        let emptyData = DoctorData()
        let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        let urlString = ip + "/toothfairy/services/ToothFairyMobileJson.php?func=check&login=\(login)&pass=\(password)"
         guard let url = URL(string: urlString) else {
            comlitionLockal(emptyData)
            return }
         URLSession.shared.dataTask(with: url) {(data, response, error) in
             guard let data = data else {
                comlitionLockal(emptyData)
                return }
             guard  error == nil else {                    comlitionLockal(emptyData)
                    return }
             do {
                 let enter = try JSONDecoder().decode(DoctorData.self, from: data)
                 print(Thread.current)
                 DispatchQueue.main.async {
                    comlitionLockal(enter)
                    print(enter)
                 }
             } catch let error {
                comlitionLockal(emptyData)
                 print(error)
             }
         }.resume()
     }

}
