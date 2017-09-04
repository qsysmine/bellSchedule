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
		self.navigationBar.barTintColor = Settings.getColour();
		self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white];
		self.navigationBar.tintColor = UIColor.white;
		
		// Do any additional setup after loading the view.
	}
	
	func updateTint() {
		UIView.animate(withDuration: 0.5, animations: {
			self.navigationBar.barTintColor = Settings.getColour();
		});
		UIView.transition(with: self.navigationBar, duration: 0.5, options: [.beginFromCurrentState, .transitionCrossDissolve], animations: { () -> Void in
			self.navigationBar.barTintColor = Settings.getColour()
		}, completion: nil)
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
