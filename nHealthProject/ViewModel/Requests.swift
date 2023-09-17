//
//  UserViewModel.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import Foundation
import RxSwift

class Requests {
    
   static func roomData(complition:@escaping([ModelRoom])->()?) {
        let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        guard let url = URL(string: "\(ip)/toothfairy/services/ToothFairyMobileJson.php?func=getRooms") else { return }
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            guard let data = data else { return }
            do {

            let enter = try JSONDecoder().decode([ModelRoom].self, from: data)
                
                DispatchQueue.main.async {
                    complition(enter)
                }
            } catch {
                return
            }
        }.resume()
    }

    //get patients on day
     func userFunc(date:String,complition:@escaping([UserData])->()?) {
    let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        var startTime = ""
        var endTime = ""

        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        df.locale = Locale.init(identifier: "ru_RU")

        if let timeStart = UserDefaults.standard.value(forKey: "WorkStartTime") as? String , let  timeEnd = UserDefaults.standard.value(forKey: "WorkEndTime") as? String {
            startTime = timeStart
            endTime = timeEnd
            
        } else {
            startTime = "09:00"
            endTime = "18:00"
        }
        
    let urlString = ip + "/toothfairy/services/ToothFairyMobileJson.php?func=getTasks&doctorId=\(AppDelegate.doctor_id)&filterDate=\(date)&startWorkTime=\(startTime)&endWorkTime=\(endTime)"
         guard let url = URL(string: urlString) else { return }
         URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data else { return }
             guard  error == nil else { return }
             guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else { return }
             do {
               
                let enter = try JSONDecoder().decode([UserData].self, from: data)
                    complition(enter)
                
             } catch let error {
                 print(error)
             }
         }.resume()
     }
    
    // deleteTask
    static func deletePatient(taskId:Int,complition:@escaping()->()?) {
        let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""

    guard let url = URL(string: ip + "/toothfairy/services/ToothFairyMobileJson.php?func=deleteTask&taskId=\(taskId)") else { return }
        
    struct Delete:Codable { }
    let instanse = Delete()
               // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(instanse) else {
                   print("Error: Trying to convert model to JSON data")
                   return
               }
                var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
               request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
               request.httpBody = jsonData
           
                URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                complition() // чтобы обновить Pacient vc после изменения данных
                }
                }.resume()
        
    }
    // push patient
    static func addTask(addData:NewPatientModel) {
           let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
           guard let url = URL(string: ip + "/toothfairy/services/ToothFairyMobileJson.php?func=addTask") else { return }
               print(addData)
              // Convert model to JSON data
              guard let jsonData = try? JSONEncoder().encode(addData) else {
                  print("Error: Trying to convert model to JSON data")
                  return
              }
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
              request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
              request.httpBody = jsonData
          
               URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   print(jsonData)
                   let responseData = String(data: data!, encoding: .utf8)
               }
           }.resume()
   }
   

   



   
    static func getLazyPatient (namePatient:String,comlitionLockal:@escaping([ModelLazyPatient])->()?)  {
     
            let ip = UserDefaults.standard.value(forKey: AppDelegate.constantKeyIP) as? String ?? ""
        let str = namePatient.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
       
        guard let url = URL(string: ip + "/toothfairy/services/ToothFairyMobileJson.php?func=getLazyPatients&searchString&searchString=\(str ?? "")") else { return }
           
                URLSession.shared.dataTask(with: url) {(data, response, error) in
                 guard let data = data else { return }
                 guard  error == nil else { return }
                
                
                
                 do {
                    let enter = try JSONDecoder().decode([ModelLazyPatient].self, from: data)
                    print(enter)
                    comlitionLockal(enter)
                 } catch let error {
                     print(error)
                 }
             }.resume()
         }
    }

    


    




