//
//  AllSchedulesTableTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/14/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit
class AllSchedulesTableTableViewController: UITableViewController {
	var sections : [[(String, String, String)]] = [];
	
	override func viewDidLoad() {
		sections = [Timings.scheduleMondayTuesdayThursday,
		            Timings.scheduleWednesday,
		            Timings.scheduleFriday,
		            Timings.scheduleRally
		];
		super.viewDidLoad();
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count;
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].count;
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if(section == 0) {
			return "Monday, Tuesday, and Thursday";
		} else if (section == 1) {
			return "Wednesday";
		} else if (section == 2) {
			return "Friday";
		} else if (section == 3) {
			return "Rally";
		}
		return "Section \(section)"
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
		let schedule = sections[indexPath.section];
		let period = schedule[indexPath.row];
		let startTime = DisplayTime(period.0).resolved;
		let endTime = DisplayTime(period.1).resolved;
		let label = period.2;
		let labelText = "\(startTime) – \(endTime)   \(label)";
		cell.textLabel!.text = labelText;
		if(cell.textLabel!.text?.contains("Passing Period"))! {
			cell.textLabel!.font = UIFont.systemFont(ofSize: 10)
		} else {
			cell.textLabel!.font = UIFont.systemFont(ofSize: 14)
		}
		return cell
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let schedule = sections[indexPath.section];
		let period = schedule[indexPath.row];
		let text = period.2;
		if(text.contains("Passing Period")) {
			return 25;
		} else {
			return 44;
		}
	}
	
}
