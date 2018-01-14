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
		let bgColour = Settings.getColour();
		let isWhite = Settings.getColourType() == .white;
		let foregroundColour: UIColor = (isWhite ? .black : .white)
		let statusBarStyle: UIStatusBarStyle = (isWhite ? .default : .lightContent);
		self.navigationBar.barTintColor = bgColour;
		self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: foregroundColour];
		self.navigationBar.tintColor = foregroundColour;
		UIApplication.shared.statusBarStyle = statusBarStyle;

		// Do any additional setup after loading the view.
	}
	
	func updateTint() {
		let bgColour = Settings.getColour();
		let isWhite = Settings.getColourType() == .white;
		let foregroundColour: UIColor = (isWhite ? .black : .white)
		let statusBarStyle: UIStatusBarStyle = (isWhite ? .default : .lightContent);
		UIView.animate(withDuration: 0.5, animations: {
			self.navigationBar.barTintColor = bgColour;
		});
		UIView.transition(with: self.navigationBar, duration: 0.5, options: [.beginFromCurrentState, .transitionCrossDissolve], animations: { () -> Void in
			UIApplication.shared.statusBarStyle = statusBarStyle;
			self.navigationBar.barTintColor = bgColour;
			self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: foregroundColour];
			self.navigationBar.tintColor = foregroundColour;
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
