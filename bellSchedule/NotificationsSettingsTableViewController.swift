//
//  NotificationsSettingsTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 1/28/18.
//  Copyright © 2018 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class NotificationsSettingsTableViewController: UITableViewController {
	
	@IBOutlet var sendNotificationsSwitch: UISwitch!;
	@IBOutlet var zeroPeriodSwitch: UISwitch!;
	@IBOutlet var warningSegment: UISegmentedControl!;
	
	override func viewDidLoad() {
		super.viewDidLoad();
		resolveValues();
		resolveTargets();
		if(Settings.hasNotifications()) {
			zeroPeriodSwitch.isEnabled = true;
			warningSegment.isEnabled = true;
		} else {
			zeroPeriodSwitch.isEnabled = false;
			warningSegment.isEnabled = false;
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func resolveValues() {
		sendNotificationsSwitch.isOn = Settings.hasNotifications();
		zeroPeriodSwitch.isOn = Settings.getShowsZeroPeriodNotifications();
		resolveSelectedWarning();
	}
	
	func resolveTargets() {
		warningSegment.addTarget(self, action: #selector(changedWarningValue), for: .allEvents);
		sendNotificationsSwitch.addTarget(self, action: #selector(changedSendNotifications), for: .allEvents);
		zeroPeriodSwitch.addTarget(self, action: #selector(changedSendZeroPeriodNotifications), for: .allEvents);
	}
	
	
	func resolveSelectedWarning() {
		var selectedSegment: Int;
		switch(Settings.getNotificationWarning()) {
		case 0:
			selectedSegment = 0;
		case 1:
			selectedSegment = 1;
		case 2:
			selectedSegment = 2;
		case 4:
			selectedSegment = 3;
		case 5:
			selectedSegment = 4;
		default:
			selectedSegment = 0;
		}
		warningSegment.selectedSegmentIndex = selectedSegment;
		
	}
	
	@objc func changedSendNotifications() {
		let shouldSendNotifications = sendNotificationsSwitch.isOn;
		if(shouldSendNotifications) {
			LocalNotifications.canSendLocalNotifications {canSendNotifications in
				if(canSendNotifications) {
					self.enableNotifications();
					return;
				}
				LocalNotifications.verifyLocalNotificationAuthorisation { verificationSucceeded in
					if(verificationSucceeded) {
						self.enableNotifications();
						return;
					}
					self.giveUpOnNotifications();
				}
			}
		} else {
			disableNotifications();
		}
	}
	
	func enableNotifications() {
		DispatchQueue.main.async {
			Settings.setHasNotifications(hasNotifications: true);
			self.zeroPeriodSwitch.isEnabled = true;
			self.warningSegment.isEnabled = true;
			self.changedAnything();
		}
	}
	func disableNotifications() {
		DispatchQueue.main.async {
			Settings.setHasNotifications(hasNotifications: false);
			self.zeroPeriodSwitch.isEnabled = false;
			self.warningSegment.isEnabled = false;
		}
	}
	func giveUpOnNotifications() {
		DispatchQueue.main.async {
			self.sendNotificationsSwitch.isOn = false;
		}
	}
	@objc func changedSendZeroPeriodNotifications() {
		Settings.setShowsZeroPeriodNotifications(showsZeroPeriodNotifications: zeroPeriodSwitch.isOn);
		changedAnything();
	}
	
	@objc func changedWarningValue() {
		let selectedIndex = warningSegment.selectedSegmentIndex;
		var warning = Settings.getNotificationWarning();
		switch selectedIndex {
		case 0:
			warning = 0;
		case 1:
			warning = 1;
		case 2:
			warning = 2;
		case 3:
			warning = 4;
		case 4:
			warning = 5;
		default:
			break;
		}
		changedAnything();
		Settings.setNotificationWarning(notificationWarning: warning);
	}
	
	func changedAnything() {
		LocalNotifications.canSendLocalNotifications { (canSend) in
			LocalNotifications.clearNotifications();
			LocalNotifications.registerNotificationsForWeek(after: Date());
		}
	}
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
