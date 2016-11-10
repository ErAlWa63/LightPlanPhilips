//
//  ViewController.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 07/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let d = D() // debugger functionality

    @IBOutlet weak var test1Button: UIButton!
    @IBOutlet weak var test2Button: UIButton!
    @IBOutlet weak var test3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test1Button.layer.borderColor  = UIColor.lightGray.cgColor
        test1Button.layer.borderWidth  = 0.5
        test1Button.layer.cornerRadius = 5
        test2Button.layer.borderColor  = UIColor.lightGray.cgColor
        test2Button.layer.borderWidth  = 0.5
        test2Button.layer.cornerRadius = 5
        test3Button.layer.borderColor  = UIColor.lightGray.cgColor
        test3Button.layer.borderWidth  = 0.5
        test3Button.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        d.c(s: "ViewController - prepare - start")
        d.c(s: "ViewController - prepare - segue.identifier - \(segue.identifier)")

        if(segue.identifier == "NameLightSegue") {
            let nameLightViewController = (segue.destination) as! NameLightViewController
            nameLightViewController.delegateLamp = DataLightPlan.sharedInstance.listLamp[0]
        }
    }
}

