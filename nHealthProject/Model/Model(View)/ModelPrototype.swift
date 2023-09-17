//
//  ModelPrototype.swift
//  nHealthProject
//
//  Created by admin on 08.02.2021.
//

import Foundation

struct ModelButton {
    var title:String
    var type:TypeButton
    
}
struct ModelTextField {
    var placeholder:String
    var imageName:String
}
enum TypeButton {
case Tint
case Backdround
case Under

}
