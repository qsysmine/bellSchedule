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
		//FINALS SCHEDULE
		if(dateString == "19 DEC 2016") {
			currentTimings = Timings.scheduleMondayFinal;
		} else if (dateString == "20 DEC 2016") {
			currentTimings = Timings.scheduleTuesdayFinal;
		} else if (dateString == "21 DEC 2016") {
			currentTimings = Timings.scheduleWednesdayFinal;
		} else if(dateString == "22 DEC 2016") {
			currentTimings = Timings.scheduleThursdayFinal;
		} else if(dateString == "23 DEC 2016") {
			currentTimings = [];
		}
        else /*END FINALS SCHEDULE*/if(dayOfTheWeek == "MON" || dayOfTheWeek == "TUE" || dayOfTheWeek == "THU") {
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
