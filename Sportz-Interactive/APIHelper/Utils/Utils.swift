//
//  Utils.swift
//  Sportz-Interactive
//
//  Created by Karan Vakharia on 20/06/23.
//

import Foundation
import UIKit
 
class Utils {
    class func convertDate(_ value : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: value)
        dateFormatter.dateFormat = "d MMM yyyy"
        let resultString = dateFormatter.string(from: date ?? Date())
        print(resultString)
        return resultString
    }
    
    class func ShowAlert(Title:String,Message:String,viewController:UIViewController)
    {
        let alert = UIAlertController(title: Title, message:Message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

}
