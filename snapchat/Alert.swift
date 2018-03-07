//
//  Alert.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 19/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit

public class Alert {
    class func alert(_ title : String ,_ message : String , in vs : UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        vs.present(alert, animated: true, completion: nil)
        
    }
}
