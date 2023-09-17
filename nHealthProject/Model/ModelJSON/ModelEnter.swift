//
//  ModelEnter.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import Foundation

struct DoctorData:Codable {
    var user_shortname:String?
    var user_lname:String?
    var user_fname:String?
    var err_msg:String?
    var user_mname:String?
    var user_id:Int?
    var checkItems:[CheckItems]?
    var server_version:String?
}

struct CheckItems:Codable {
    var key:String
}





