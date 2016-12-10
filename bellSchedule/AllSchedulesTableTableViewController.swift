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
	let scheduleMondayTuesdayThursday = Timings.scheduleMondayTuesdayThursday;
	let scheduleWednesday = Timings.scheduleWednesday;
	let scheduleFriday = Timings.scheduleFriday;
	let scheduleRally = Timings.scheduleRally;
	/*FINALS SCHEDULE*/
	let scheduleMondayFinal = Timings.scheduleMondayFinal;
	let scheduleTuesdayFinal = Timings.scheduleTuesdayFinal;
	let scheduleWednesdayFinal = Timings.scheduleWednesdayFinal;
	let scheduleThursdayFinal = Timings.scheduleThursdayFinal;
	/*END FINALS SCHEDULE*/
	var sections : [[(String, String, String)]] = [];
	override func viewDidLoad() {
		sections = [scheduleMondayTuesdayThursday,
		            scheduleWednesday,
		            scheduleFriday,
					scheduleRally/*FINALS SCHEDULE*/,
					scheduleMondayFinal,
					scheduleTuesdayFinal,
					scheduleWednesdayFinal,
					scheduleThursdayFinal/*END FINALS SCHEDULE*/
		]
		super.viewDidLoad();
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return sections.count;
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
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
		}/*FINALS SCHEDULE*/ else if (section == 4) {
			return "Monday Final";
		} else if (section == 5) {
			return "Tuesday Final";
		} else if (section == 6) {
			return "Wednesday Final";
		} else if (section == 7) {
			return "Thursday Final";
		}
		return "Section \(section)"
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
		let schedule = sections[indexPath.section];
		let period = schedule[indexPath.row];
		let startTime = period.0;
		let endTime = period.1;
		let label = period.2;
		let labelText = "\(startTime) – \(endTime)   \(label)";
		cell.textLabel!.text = labelText;
		return cell
	}
	
}
