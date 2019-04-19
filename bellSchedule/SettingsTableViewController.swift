
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
import CoreTelephony

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MFMessageComposeViewControllerDelegate{
	
	@IBOutlet weak var militaryTimeSwitch: UISwitch!;
	@IBOutlet weak var colourPickerView: UIPickerView!;
    @IBOutlet var iconMatchesSwitch: UISwitch!;
	@IBOutlet var feedBackButton: UIButton!;
	@IBOutlet var updatesButton: UIButton!;
	@IBOutlet var goToSpecialSchedule: UIButton!;
	@IBOutlet var goToPremiumSettings: UIButton!;
    @IBOutlet var goToNotificationsSettings: UIButton!;
	
	var isGoingToPremiumSettings: Bool = false;
		
	var colourData: [(String, ColourSettingType)] = [("Blue",.blue), ("Red",.red), ("Black",.black)];
	let premiumColourData: [(String, ColourSettingType)] = [("Blue",.blue), ("Red",.red), ("Black",.black), ("Gold",.gold), ("Silver",.silver), ("White",.white)];
	
	override func viewDidLoad() {
		super.viewDidLoad();
		self.tableView.allowsSelection = false;
		let timeType = Settings.getTimeType();
		militaryTimeSwitch.isOn = timeType == .twentyfour;
		iconMatchesSwitch.isOn = Settings.getIconMatchesColour();
		colourPickerView.delegate = self;
		colourPickerView.dataSource = self;
		if(Settings.hasPremium()) {
			colourData = premiumColourData;
		
           
            goToPremiumSettings.isEnabled = false;
			goToPremiumSettings.setTitle("Thank you for purchasing premium!", for: .normal);
		} else {
			goToSpecialSchedule.isEnabled = false;
            goToNotificationsSettings.isEnabled = false;
		}
	}
    
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		if(self.isGoingToPremiumSettings) {
			self.performSegue(withIdentifier: "settingsToPremiumSettingsSegue", sender: self)
		}
		let colourType = Settings.getColourType();
        if(!MFMailComposeViewController.canSendMail()) {
            feedBackButton.isEnabled = false;
        }
        if (!MFMessageComposeViewController.canSendText()) {
			updatesButton.isEnabled = false;
        }
		if(!ProcessInfo.processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 3, patchVersion: 0))) {
			iconMatchesSwitch.isEnabled = false
		}
		colourPickerView.selectRow(colourData.firstIndex(where:{$0.1 == colourType}) ?? 0, inComponent: 0, animated: false);
		if(colourData.firstIndex(where:{$0.1 == colourType}) == nil) {
			Settings.setColourType(type: .blue);
		}
		colourData = (Settings.hasPremium() ? premiumColourData : colourData);
        colourPickerView.reloadAllComponents();
        
        goToNotificationsSettings.isEnabled = Settings.hasPremium();
		goToSpecialSchedule.isEnabled = Settings.hasPremium();
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
	}
	
	@IBAction func militaryTimeSwitched(_ sender: UISwitch) {
		switch sender.isOn {
		case true:
			Settings.setTimeType(type: TimeSettingType.twentyfour);
			break;
		case false:
			Settings.setTimeType(type: TimeSettingType.twelve);
			break;
		}
	}
    @IBAction func iconMatchSwitched(_ sender: UISwitch) {
		if(!ProcessInfo.processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 3, patchVersion: 0))) {
			sender.isOn = false;
			let alertController = UIAlertController(title: "Not Supported", message: "Changing the icon is only available for iOS 10.3+", preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "OK", style: .default) { _ in }
			alertController.addAction(OKAction)
			return self.present(alertController, animated: true) {}
		}
        Settings.setIconMatchesColour(matches: sender.isOn);
		if(sender.isOn) {
			Colour.resolveIcon();
		} else {
			Colour.resetIcon();
		}
    }
    
    @IBAction func sendFeedback(_ sender: UIButton) {
		let mailVC = MFMailComposeViewController()
		mailVC.mailComposeDelegate = self
		mailVC.setToRecipients(["clients0@qsysmine.tk"])
		mailVC.setSubject("Bell Schedule Feedback")
		mailVC.setMessageBody("I have some feedback for the DHS Bell Schedule app: ", isHTML: false)
		present(mailVC, animated: true, completion: nil)
	}
	
	@IBAction func subscribeToUpdates() {
		let messageVC = MFMessageComposeViewController()
		messageVC.body = "follow DHSBellSchedule";
		messageVC.recipients = ["404-04"]
		messageVC.messageComposeDelegate = self;
		
		self.present(messageVC, animated: true, completion: nil)
	}
	
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return colourData.count;
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return colourData[row].0;
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let colour = colourData[row];
		Settings.setColourType(type: colour.1);
		(self.navigationController as! StylisedNavigationController).updateTint()
		if(Settings.getIconMatchesColour()) { Colour.resolveIcon() }
	}
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1;
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		switch (result) {
		case .cancelled:
			self.dismiss(animated: true, completion: nil)
		case .failed:
			self.dismiss(animated: true, completion: nil)
			let alertController = UIAlertController(title: "Something's gone wrong.", message: "We couldn't subscribe you. Please try again later.", preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "Okay", style: .default) { _ in }
			alertController.addAction(OKAction)
			return self.present(alertController, animated: true) {}
		case .sent:
			self.dismiss(animated: true, completion: nil)
			let alertController = UIAlertController(title: "Thank you", message: "It looks like you've been successfully subscribed to DHS Bell Schedule App updates.", preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "You're welcome", style: .default) { _ in }
			alertController.addAction(OKAction)
			return self.present(alertController, animated: true) {}
		
			// something goes here I really don't know what this function does
			// - Shreyas
		}
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier != nil && segue.identifier == "settingsToPremiumSettingsSegue") {
			if(self.isGoingToPremiumSettings) {
				self.isGoingToPremiumSettings = false;
			}
		}
	}
}
