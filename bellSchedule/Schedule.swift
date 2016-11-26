//
//  Schedule.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation

public class Schedule {
    public var asDates: [(Date, Date, String)] = [];
    public init(timings: [(String, String, String)]) {
        for periodStrings in timings {
            let period = Period(start: periodStrings.0, end: periodStrings.1);
            asDates.append((period.startDate, period.endDate, periodStrings.2));
        }
    }
}
