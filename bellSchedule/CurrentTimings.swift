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
		if(SpecialTimings.getSpecialTimings() != nil) {
			currentTimings = SpecialTimings.getSpecialTimings() ?? [(String, String, String)]();
			return;
		}
		
		/*RALLIES 2017 [*/
		//if() {
		//	currentTimings = Timings.scheduleRally;
		//} else
		/*] END RALLIES 2017*/
		/*DAYS OFF 2017 [*/
		if(dateString == "04 SEP 2017" || dateString == "10 NOV 2017" || dateString.range(of: "2[1-4] NOV 2017", options: .regularExpression, range: nil, locale: nil) != nil || dateString.range(of: "2[2-9] DEC 2017", options: .regularExpression, range: nil, locale: nil) != nil || dateString.range(of: "[1-6] JAN 2018", options: .regularExpression, range: nil, locale: nil) != nil) {
			currentTimings = [];
		} else
		/*] END DAYS OFF 2017*/
		if(dayOfTheWeek == "MON" || dayOfTheWeek == "TUE" || dayOfTheWeek == "THU") {
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
