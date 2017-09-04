//
//  TodayViewController.swift
//  bellScheduleWidget
//
//  Created by Ari Stassinopoulos on 8/14/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//
import UIKit
import NotificationCenter
import BellScheduleDataKit

class TodayViewController: UIViewController, NCWidgetProviding {
	
	
	@IBOutlet weak var startTimeLabel: UILabel!
	@IBOutlet weak var endTimeLabel: UILabel!
	@IBOutlet weak var classLabel: UILabel!
	@IBOutlet weak var nextClassLabel: UILabel!
	var isWeekend = false;
	var hasPeriod = false;
	
	override func viewDidLoad() {
		super.viewDidLoad()
		determineWeekend()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
		self.view.backgroundColor = Settings.getColour();
    }
	func determineWeekend() {
		let weekday = Today().weekday;
		if weekday == "SAT" || weekday == "SUN" {
			isWeekend = true;
			return;
		}
	}
	func determineHasPeriod() {
		let hasPeriod = CurrentPeriod().isCurrentPeriod
		self.hasPeriod = hasPeriod
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func widgetPerformUpdate(completionHandler: @escaping ((NCUpdateResult) -> Void)) {
		determineWeekend()
		determineHasPeriod()
		if isWeekend || !hasPeriod {
			populateEmpty(middle: "No class.")
		}
		if hasPeriod {
			populateWithTime();
		}
		self.view.backgroundColor = Settings.getColour();
		print(Settings.getColour());
		completionHandler(NCUpdateResult.newData)
	}
	
	func populateEmpty(middle: String) {
		startTimeLabel!.text = "";
		classLabel!.text = "";
		nextClassLabel!.text = "";
		endTimeLabel!.text = middle;
	}
	
	func populateWithTime() {
		let periodOffset = CurrentPeriod().periodOffset
		let currentTimings = CurrentTimings().currentTimings;
		let period = currentTimings[periodOffset];
		let startTime = DisplayTime(period.0).resolved;
		let endTime = DisplayTime(period.1).resolved;
		let label = period.2;
		startTimeLabel!.text = startTime;
		endTimeLabel!.text = endTime;
		classLabel!.text = label;
		if currentTimings.count > periodOffset + 1 {
			let nextPeriod = currentTimings[periodOffset + 1];
			let nextStart = DisplayTime(nextPeriod.0).resolved;
			let nextEnd = DisplayTime(nextPeriod.1).resolved;
			let nextLabel = nextPeriod.2;
			nextClassLabel!.text = "NEXT: \(nextLabel) (\(nextStart) – \(nextEnd))"
		} else {
			nextClassLabel!.text = ""
		}
	}
	
	@IBAction func InfoButtonPressed(_ sender: AnyObject) {
		self.extensionContext?.open(URL(string:"bellSchedule://")!, completionHandler: {_ in
		})
	}
	
}
