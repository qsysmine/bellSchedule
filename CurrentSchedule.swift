//
//  CurrentSchedule.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation

public class CurrentSchedule {
    public var currentSchedule:[(Date, Date, String)];
    public init() {
        let currentTimings = CurrentTimings().currentTimings;
        currentSchedule = Schedule(timings: currentTimings).asDates;
    }
}
