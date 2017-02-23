//
//  TestUIViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 21/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class TestUIViewController: UIViewController {
  let debug = Debug() // debugger functionality

  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

extension TestUIViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    debug.console(message: "start", file: #file, function: #function, line: #line)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let lbl = UILabel(frame: cell.contentView.frame)
    lbl.textColor = UIColor.green
    lbl.textAlignment = .center
    lbl.text = "Cell: \(indexPath.row + 1)"
    cell.addSubview(lbl)
    return cell
  }
}

extension TestUIViewController: UICollectionViewDelegate {
}
