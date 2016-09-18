//
//  DebugViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import MapKit

class DebugViewController: UIViewController {

    var distances = [Double]()
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var debugText = ""
        for distance in distances {
            debugText += "\(distance)\n"
        }
        textView.text = debugText
    }

}
