//
//  UserModel.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import Foundation

// get model patient
struct UserData:Codable {
    var task_comment:String?
    var task_id:Int?
    var task_startTime:String?
    var task_endTime:String?
    var task_workdescription:String?
    var task_range:String?
    var patient_id:Int?
    var patient_lname:String?
    var patient_fname:String?
    var patient_sname:String?
    var patient_fullcardnumber:String?
    var patient_primaryflag:Int?
    var patient_phone:String?
    var patient_birthday:String?
    var patient_sex:String?
    var patient_notes:String?
    var patient_fio:String?
//    var patient_ages:Int?
    var task_interval_minutes:Int?
    var is_plus_object:Int?
    var patient_mobile:String?
}


// new model patient

struct NewPatientModel:Codable {
    var patient_id:Int?
    var task_date:String?
    var task_begin:String?
    var task_end:String?
    var task_workplace_id:Int?
    var doctor_id:Int?
    var task_room_id:Int?
    var patient_lname:String?
    var patient_fname:String?
    var patient_sname:String?
    var patient_mobile:String?
    var task_cm:String?
    var task_wd:String?
}




//ModelRoom

struct ModelRoom:Codable {
    var room_id:Int
    var room_number:Int
    var room_name:String
    var workplaces:[Workplace]?
}
struct Workplace:Codable {
    var workplace_id:Int?
    var workplace_number:Int?
    var workplace_name:String?
}

struct ModelLazyPatient:Decodable {
    var patient_fio:String?
    var patient_id:Int?
}
