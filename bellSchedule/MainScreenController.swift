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
	@IBOutlet var settingsButton: UIButton!;
	@IBOutlet var infoButton: UIButton!;
	@IBOutlet weak var promoView: PremiumPromoView?;
	var isGoingToPremiumSettings: Bool = false;
	
	@objc func populateFields() {
		let customSchedule = Settings.getCustomSchedule();
		let currentTimings = CurrentTimings(Date()).currentTimings;
		let currentPeriod = CurrentPeriod();
		if(currentPeriod.isCurrentPeriod) {
			let periodOffset = currentPeriod.periodOffset;
			currentClassText.text! =	customSchedule.replaceWithCustomScheduleString(currentTimings[periodOffset].2);
			startText.text! = DisplayTime(currentTimings[periodOffset].0).resolved;
			endText.text! = DisplayTime(currentTimings[periodOffset].1).resolved;
			if(currentTimings.count > periodOffset + 1) {
				let nextPeriod = currentTimings[periodOffset + 1];
				nextClassText.text! = "NEXT: \(customSchedule.replaceWithCustomScheduleString(nextPeriod.2)) (\(DisplayTime(nextPeriod.0).resolved) – \(DisplayTime(nextPeriod.1).resolved))";
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
		UIView.animate(withDuration: 0.5, animations: {
			self.view.backgroundColor = Settings.getColour()
			if(Settings.getColourType() == .white) {
				UIApplication.shared.statusBarStyle = .default;
                [self.startText, self.nextClassText, self.endText, self.currentClassText].forEach({ $0.textColor = UIColor.black;});
                [self.infoButton, self.settingsButton].forEach {$0?.tintColor = .black}
			} else {
				UIApplication.shared.statusBarStyle = .lightContent;
				self.endText.textColor = .white;
				[self.startText, self.nextClassText,self.currentClassText].forEach {$0.textColor = .groupTableViewBackground}
                [self.infoButton, self.settingsButton].forEach {$0?.tintColor = .white}
			}
		});
		populateFields()
		SpecialTimings.lazyCheckForSpecialTimings(for: Date()) { (areSpecialTimings, error) in
			DispatchQueue.main.async {
				self.populateFields()
				LocalNotifications.clearNotifications();
				LocalNotifications.registerNotificationsForWeek(after: Date());
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = Settings.getColour()
		let date = NSDate().addingTimeInterval(5)
		let timer = Timer(fireAt: date as Date, interval: 0, target: self, selector: #selector(populateFields), userInfo: nil, repeats: true)
		if(promoView != nil) {
			promoView!.mainScreen = self;
			print(Settings.shouldShowPromo());
			if(Settings.hasPremium() || !Settings.shouldShowPromo()) {
				promoView!.isHidden = true;
			} else {
				Settings.hasSeenPromo();
			}
		}
		RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
		timer.fire();
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func unwindToMainScreen (sender: UIStoryboardSegue){
		
	}
	
	func gotoPremiumSettings() {
		isGoingToPremiumSettings = true;
		self.performSegue(withIdentifier: "mainScreenToSettingsSegue", sender: self);
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(self.promoView != nil && self.promoView!.stillExists) {
        self.promoView!.stillExists = false;
        self.promoView!.close();
        }
		if(segue.identifier != nil && segue.identifier! == "mainScreenToSettingsSegue") {
			if(isGoingToPremiumSettings) {
				let destination = segue.destination as! StylisedNavigationController
				if(destination.topViewController != nil) {
					let finalDestination = destination.topViewController! as! SettingsTableViewController;
					finalDestination.isGoingToPremiumSettings = true;
					self.isGoingToPremiumSettings = false;
				}
			}
		}
	}
	
	
}
