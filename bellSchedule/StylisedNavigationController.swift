//
//  StylisedNavigationController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/14/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class StylisedNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationBar.barTintColor = UIColor(displayP3Red: 0.18, green: 0.40, blue: 0.56, alpha: 100.0);
		self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white];
		self.navigationBar.tintColor = UIColor.white;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
