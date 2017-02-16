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
		/* 2017 RALLY [*/
		if(dateString == "17 FEB 2017" || dateString == "14 APR 2017") {
			currentTimings = Timings.scheduleRally;
		}
		/*] END 2017 RALLY*/
		/* 2017 DAYS OFF [*/
		else if (dateString == "20 FEB 2017" || dateString == "17 MAR 2017" || dateString == "3 APR 2017" || dateString == "4 APR 2017" || dateString == "5 APR 2017" || dateString == "6 APR 2017" || dateString == "7 APR 2017" || dateString == "29 MAY 2017") {
			currentTimings = [];
		}
		/*] END 2017 DAYS OFF*/
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
