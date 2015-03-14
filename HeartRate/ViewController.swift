//
//  ViewController.swift
//  HeartRate
//
//  Created by AlienLi on 15/3/13.
//  Copyright (c) 2015年 ALN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alienView: ALNDecibelChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "drawDecibelOnScreen", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func drawDecibelOnScreen() {
        var decibels = rand() % 80
        alienView.decebel = CGFloat(decibels)
    }

}

