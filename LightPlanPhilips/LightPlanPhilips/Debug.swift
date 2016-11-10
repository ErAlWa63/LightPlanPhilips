//
//  Debug.swift
//  Bridges
//
//  Created by Erik Waterham on 02/11/2016.
//  Copyright © 2016 TL. All rights reserved.
//

import UIKit

class D {
    private var now: String {
        get {
            let dateFormate = DateFormatter()
            dateFormate.dateFormat = "HHmmss.SSS"
            let date = Date()
            return dateFormate.string(from: date)
        }
    }
    
    func c (s: String) -> () {
        print("Philips (\(self.now)): \(s)")
    }
    
//    func a (title: String, message: String) -> () {
//        let alert = UIAlertController( title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        presentViewController( alert, animated: true)
//    }
}
