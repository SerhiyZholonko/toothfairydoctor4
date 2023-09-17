//
//  NewNotesOnScrollView.swift
//  nHealthProject
//
//  Created by admin on 26.03.2021.
//

import UIKit

class NewNotesOnScrollView: UIViewController {

    @IBOutlet var myScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewSetting()
        keyboardFrame()
        print("jebuvue")
    }
    func scrollViewSetting() {
        let selfBounds = UIScreen.main.bounds
        myScrollView.translatesAutoresizingMaskIntoConstraints = true
        myScrollView.frame = selfBounds
        myScrollView.contentSize = selfBounds.size

    }
    
    func keyboardFrame() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [self] keyboard in
            if let keyboardSize = (keyboard.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight : Int = Int(keyboardSize.height)
                UIView.animate(withDuration: 0.4) {
                    self.myScrollView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - CGFloat(keyboardHeight))
                }
                
                
               }
         }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
           self.view.frame.origin.y = 0
        }
     }

}
