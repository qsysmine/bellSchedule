//
//  SettingsTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 1/13/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit
import MessageUI
import BellScheduleDataKit

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
	@IBOutlet weak var militaryTimeSwitch: UISwitch!
	
    override func viewDidLoad() {
		super.viewDidLoad();
		self.tableView.allowsSelection = false;
		let timeType = Settings.getTimeType();
		militaryTimeSwitch.isOn = timeType == .twentyfour;
    }
	
	func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
		guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
			completion(false)
			return
		}
		guard #available(iOS 10, *) else {
			completion(UIApplication.shared.openURL(url))
			return
		}
		UIApplication.shared.open(url, options: [:], completionHandler: completion)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
	}
	
	@IBAction func militaryTimeSwitched(_ sender: UISwitch) {
		switch sender.isOn {
		case true:
			Settings.setTimeType(type: SettingType.twentyfour)
			break
		case false:
			Settings.setTimeType(type: SettingType.twelve)
			break
		}
	}
	
	@IBAction func rateClick(_ sender: UIButton) {
		rateApp(appId: "1158589523") { success in
		}
	}
	
	@IBAction func sendFeedback(_ sender: UIButton) {
		let mailVC = MFMailComposeViewController()
		mailVC.mailComposeDelegate = self
		mailVC.setToRecipients(["clients0@qsysmine.tk"])
		mailVC.setSubject("Bell Schedule Feedback")
		mailVC.setMessageBody("I have some feedback for the DHS Bell Schedule app: ", isHTML: false)
		if(mailVC != nil) {
			present(mailVC, animated: true, completion: nil)
		}
		
	}
	// MARK: MFMailComposeViewControllerDelegate Method
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}
