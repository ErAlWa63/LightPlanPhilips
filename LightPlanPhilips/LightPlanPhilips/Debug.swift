//
//  Debug.swift
//
//  Created by Erik Waterham on 02/11/2016.
//  Copyright © 2016 TL. All rights reserved.
//
// http://stackoverflow.com/questions/24495039/print-class-name-of-current-file-in-swift
// http://stackoverflow.com/questions/39674636/swift-3-fast-file-path-separation
//

import UIKit

class Debug {
  private var now: String {
    get {
      let dateFormate = DateFormatter()
      dateFormate.dateFormat = "HHmmss.SSS"
      let date = Date()
      return dateFormate.string(from: date)
    }
  }
  
  func console (message: String, file: String, function: String, line: Int) -> () {
    print("Philips (\(now)) \(URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent) \(function) \(line): \(message)")
  }
}
