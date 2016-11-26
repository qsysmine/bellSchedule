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
	var sections : [[(String, String, String)]] = [];
    override func viewDidLoad() {
		sections.append(scheduleMondayTuesdayThursday)
		sections.append(scheduleWednesday)
		sections.append(scheduleFriday)
		sections.append(scheduleRally);
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
