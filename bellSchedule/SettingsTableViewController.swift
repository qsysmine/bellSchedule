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

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var militaryTimeSwitch: UISwitch!;
	@IBOutlet weak var colourPickerView: UIPickerView!;
    @IBOutlet var iconMatchesSwitch: UISwitch!;
    @IBOutlet var studentNumberField: UITextField!;
    
    var colourData = ["Blue", "Red", "Black"];
	
	override func viewDidLoad() {
		super.viewDidLoad();
		self.tableView.allowsSelection = false;
		let timeType = Settings.getTimeType();
		militaryTimeSwitch.isOn = timeType == .twentyfour;
		iconMatchesSwitch.isOn = Settings.getIconMatchesColour();
		colourPickerView.delegate = self;
		colourPickerView.dataSource = self;
        if(Settings.getStudentNumber() != nil){
            studentNumberField.text = Settings.getStudentNumber()!;
        }
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		let colourType = Settings.getColourType();
		print(colourType);
		if(colourType == .blue) {
			colourPickerView.selectRow(0, inComponent: 0, animated: false);
		} else if(colourType == .red) {
			colourPickerView.selectRow(1, inComponent: 0, animated: false);
		} else  {
			colourPickerView.selectRow(2, inComponent: 0, animated: false);
		}
		
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
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return colourData.count;
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return colourData[row];
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let colour = colourData[row];
		var colourSettingType: ColourSettingType = .blue;
		if(colour == "Red") {
			colourSettingType = .red;
		} else if(colour == "Black") {
			colourSettingType = .black;
		}
		Settings.setColourType(type: colourSettingType);
		(self.navigationController as! StylisedNavigationController).updateTint()
		if(Settings.getIconMatchesColour()) { Colour.resolveIcon() }
	}
    
    @IBAction func studentNumberFieldEdited(_ sender: Any) {
        if(Settings.setStudentNumber(number: studentNumberField.text ?? "")) {
            UIView.animate(withDuration: 0.5) {
                self.studentNumberField.backgroundColor = UIColor.green;
                UIView.animate(withDuration:0.25) {
                    self.studentNumberField.backgroundColor = UIColor.white;
                }
            }
        }
    }
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1;
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}
