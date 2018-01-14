//
//  CustomScheduleTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 11/13/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class CustomScheduleTableViewController: UITableViewController {
	
	var customSchedule: CustomSchedule?;
	var scheduleDictionary: [String:String]?;
	override func viewDidLoad() {
		super.viewDidLoad()
		
		customSchedule = Settings.getCustomSchedule();
		scheduleDictionary = customSchedule!.scheduleContents;
		
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Custom Schedule";
	}
	
	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return "All changes are saved automatically";
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(customSchedule == nil || scheduleDictionary == nil) {
			return 0;
		} else {
			return scheduleDictionary!.count;
		}
	}
	
	func updatePeriod(key: String, value: String) {
		if(customSchedule == nil || scheduleDictionary == nil) {
			return;
		}
		scheduleDictionary![key] = value;
		customSchedule = CustomSchedule(scheduleContents: scheduleDictionary!);
		saveChanges()
	}
	
	func removePeriod(key: String) {
		if(customSchedule == nil || scheduleDictionary == nil) {
			return;
		}
		scheduleDictionary![key] = CustomSchedule.defaults[key];
		customSchedule = CustomSchedule(scheduleContents: scheduleDictionary!);
		saveChanges();
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "customScheduleCell", for: indexPath) as! CustomSchedulePeriodTableViewCell;
		let key = CustomSchedule.keys[indexPath.row];
		let value = scheduleDictionary![key];
		let defaultValue = CustomSchedule.defaults[key] ?? "";
		cell.customScheduleViewController = self;
		cell.defaultValue = defaultValue;
		cell.key = key
		if(value != defaultValue) {
			cell.updateText(customSchedule?.scheduleContents[CustomSchedule.keys[indexPath.row]] ?? "")
		}
		cell.input.placeholder = defaultValue;
		return cell
	}
	
	func saveChanges() {
		if(customSchedule == nil) {
			return;
		}
		Settings.setCustomSchedule(schedule: customSchedule);
	}
	
}
