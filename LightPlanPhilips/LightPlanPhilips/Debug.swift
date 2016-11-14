//
//  Debug.swift
//  Bridges
//
//  Created by Erik Waterham on 02/11/2016.
//  Copyright © 2016 TL. All rights reserved.
//
// http://stackoverflow.com/questions/24495039/print-class-name-of-current-file-in-swift
// http://stackoverflow.com/questions/39674636/swift-3-fast-file-path-separation
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
  
//  print(" Function name : \(#function), Class Name : \(self.dynamicType), File Path : \(#file)")
  func c (m message: String, f filename: String, fu function: String, l line: Int) -> () {
    print("Philips(\(now)) \(URL(fileURLWithPath: filename).deletingPathExtension().lastPathComponent) \(function) \(line): \(message)")
  }
  
  private func matches(for regex: String, in text: String) -> [String] {
    
    do {
      let regex = try NSRegularExpression(pattern: regex)
      let nsString = text as NSString
      let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
      return results.map { nsString.substring(with: $0.range)}
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
  
  //    func a (title: String, message: String) -> () {
  //        let alert = UIAlertController( title: title, message: message, preferredStyle: .alert)
  //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
  //        presentViewController( alert, animated: true)
  //    }
}
