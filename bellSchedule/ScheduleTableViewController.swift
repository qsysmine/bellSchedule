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
	var data : [(String, String, String)] = [],
	isWeekend = false,
	dateString = "";
	override func viewDidLoad() {
		super.viewDidLoad();
		let timer = Timer(timeInterval: 5.0, target: self, selector:#selector(refresh), userInfo: nil, repeats: true);
		timer.fire();
	}
	@objc func refresh() {
		let weekday = Today(Date()).weekday;
		if(weekday == "SAT" || weekday == "SUN") {
			isWeekend = true;
		}
		dateString = Today(Date()).dateString;
		data = CurrentTimings(Date()).currentTimings;
		SpecialTimings.lazyCheckForSpecialTimings(for: Date()) { (areSpecialTimings, _) in
			if(SpecialTimings.getSpecialTimings(for: Date()) != nil) {
				self.data = SpecialTimings.getSpecialTimings(for: Date())!;
				self.navigationItem.title = "Today's Schedule ✨";
			} else {
				self.navigationItem.title = "Today's Schedule";
			}
			DispatchQueue.main.async { self.tableView.reloadData(); }
		}
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
	}
	@IBAction func doRefresh(_ sender: UIRefreshControl) {
		refresh();
		SpecialTimings.checkForSpecialTimings(for: Date()) { (areSpecialTimings, error) in
			self.refresh();
			DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
				sender.endRefreshing()
			})
		}
		
		
	}
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(data.count == 0) {return 1;}
		return data.count;
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let customSchedule = Settings.getCustomSchedule();
		let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath);
		if((data.count == 0) && indexPath.row == 0){
			cell.textLabel!.text = "No class today";
			cell.textLabel!.textAlignment = .center;
			return cell;
		}
		let currentPeriod = CurrentPeriod().periodOffset;
		let period = data[indexPath.row];
		let startTime = DisplayTime(period.0).resolved;
		let endTime = DisplayTime(period.1).resolved;
		let label = customSchedule.replaceWithCustomScheduleString(period.2);
		if(indexPath.row == currentPeriod) {
			cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 14)
		} else {
			cell.textLabel!.font = UIFont.systemFont(ofSize: 14);
		}
		if(label.contains("Passing Period")) {
			cell.textLabel!.font = UIFont.systemFont(ofSize: 10)
		}
		cell.textLabel!.text! = "\(startTime) – \(endTime)   \(label)";		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(!isWeekend && data.count > indexPath.row) {
			let period = data[indexPath.row];
			let text = period.2;
			if(text.contains("Passing Period")) {
				return 25;
			} else {
				return 44;
			}
		}
		return 44;
	}
	
	@IBAction func unwindToSchedule (sender: UIStoryboardSegue){
		
	}
}
