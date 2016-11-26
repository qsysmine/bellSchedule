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
