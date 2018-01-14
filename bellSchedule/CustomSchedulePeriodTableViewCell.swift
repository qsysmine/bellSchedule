//
//  CustomSchedulePeriodTableViewCell.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 11/13/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit

class CustomSchedulePeriodTableViewCell: UITableViewCell {

	@IBOutlet var input: UITextField!;
	
	public var customScheduleViewController: CustomScheduleTableViewController?;
	public var key: String?;
	public var defaultValue: String?;
	
    override func awakeFromNib() {
        super.awakeFromNib()
		input.addTarget(self, action: #selector(setPeriod), for: .allEvents);
	}
		
	func updateText(_ text: String) {
		input.text = text;
	}
	
	@objc func setPeriod() {
		if(customScheduleViewController == nil || key == nil) {
			return;
		}
		if(input.text == nil || input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
			return customScheduleViewController!.removePeriod(key: key!);
		}
		customScheduleViewController!.updatePeriod(key: key!, value: input.text ?? "");
	}

}
