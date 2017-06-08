//
//  CurrentTimings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation
public class CurrentTimings {
	public var currentTimings:[(String, String, String)];
	public init() {
		let dayOfTheWeek = Today().weekday;
		let dateString = Today().dateString;
		/* RALLY DAYS 2017 [*/
		if (dateString == "19 MAY 2017") {
			currentTimings = Timings.scheduleRally;
		} else
			/*] END RALLY DAYS 2017*/
			/* 2017 DAYS OFF [*/
		if (dateString == "29 MAY 2017") {
			currentTimings = [];
		}
			/*] END 2017 DAYS OFF*/
			/* SPRING FINALS 2017 [*/
		else if(dateString == "30 MAY 2017") {
			currentTimings = Timings.schedule30May;
		} else if(dateString == "31 MAY 2017") {
			currentTimings = Timings.schedule31May;
		} else if(dateString == "01 JUN 2017") {
			currentTimings = Timings.schedule1June;
		}
			/* ] END SPRING FINALS 2017*/
		else if(dayOfTheWeek == "MON" || dayOfTheWeek == "TUE" || dayOfTheWeek == "THU") {
			currentTimings = Timings.scheduleMondayTuesdayThursday;
		} else if(dayOfTheWeek == "WED") {
			currentTimings = Timings.scheduleWednesday;
		} else if(dayOfTheWeek == "FRI") {
			currentTimings = Timings.scheduleFriday;
		} else {
			currentTimings = [];
		}
		
	}
}
