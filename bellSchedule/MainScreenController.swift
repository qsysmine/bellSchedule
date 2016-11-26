//
//  MainScreenController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class MainScreenController: UIViewController {
    
    @IBOutlet weak var nextClassText: UILabel!
    @IBOutlet weak var startText: UILabel!
    @IBOutlet weak var endText: UILabel!
    @IBOutlet weak var currentClassText: UILabel!
    
    
    
    let currentTimings = CurrentTimings().currentTimings;
    func populateFields() {
        let currentPeriod = CurrentPeriod();
        if(currentPeriod.isCurrentPeriod) {
            let periodOffset = currentPeriod.periodOffset;
            currentClassText.text! = currentTimings[periodOffset].2;
            startText.text! = currentTimings[periodOffset].0;
            endText.text! = currentTimings[periodOffset].1;
            if(currentTimings.count > periodOffset + 1) {
                let nextPeriod = currentTimings[periodOffset + 1];
                nextClassText.text! = "NEXT: \(nextPeriod.2) (\(nextPeriod.0) – \(nextPeriod.1))";
            } else {
                nextClassText.text! = "";
            }
        } else {
            currentClassText.text! = "";
            endText.text! = "No class.";
            startText.text! = "";
            nextClassText.text! = "";
        }
    }
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		populateFields()
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
		let date = NSDate().addingTimeInterval(5)
		let timer = Timer(fireAt: date as Date, interval: 0, target: self, selector: #selector(populateFields), userInfo: nil, repeats: true)
		RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        timer.fire();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainScreen (sender: UIStoryboardSegue){
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
