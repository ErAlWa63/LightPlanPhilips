//
//  ViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 07/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "NameLightSegue") {
            let nameLightViewController = (segue.destination) as! NameLightViewController
            nameLightViewController.delegateLampRow = 0
        }
    }
}

