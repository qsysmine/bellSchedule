//
//  ScheduleTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit
class ScheduleTableViewController: UITableViewController {
	
	
	var data : [(String, String, String)] = [];
	var isWeekend = false;
	override func viewDidLoad() {
		super.viewDidLoad();
		let timer = Timer(timeInterval: 5.0, target: self, selector:#selector(refresh), userInfo: nil, repeats: true);
		timer.fire();
	}
	func refresh() {
		let weekday = Today().weekday;
		if(weekday == "SAT" || weekday == "SUN") {
			isWeekend = true;
		}
		data = CurrentTimings().currentTimings;
		self.tableView.reloadData();
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
	}
	@IBAction func doRefresh(_ sender: UIRefreshControl) {
		refresh();
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
			sender.endRefreshing()
		})

	}
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(isWeekend) {return 1;}
		return data.count;
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath);
		if(isWeekend){
			if(indexPath.row == 0) {
				cell.textLabel!.text = "No class today";
				cell.textLabel!.textAlignment = .center;
			}
			return cell;
		}
		let currentPeriod = CurrentPeriod().periodOffset;
		let period = data[indexPath.row];
		let startTime = period.0;
		let endTime = period.1;
		let label = period.2;
		if(indexPath.row == currentPeriod) {
			cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 16)
		} else {
			cell.textLabel!.font = UIFont.systemFont(ofSize: 14);
		}
		cell.textLabel!.text! = "\(startTime) – \(endTime)   \(label)";
		// Configure the cell...
		
		return cell
	}
	@IBAction func unwindToSchedule (sender: UIStoryboardSegue){
		
	}
}
