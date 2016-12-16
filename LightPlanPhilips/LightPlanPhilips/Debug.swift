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

//   let debug = Debug() // debugger functionality
//   debug.console(message: "start", file: #file, function: #function, line: #line)


