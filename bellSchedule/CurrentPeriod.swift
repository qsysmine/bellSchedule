//
//  CurrentPeriod.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation
public class CurrentPeriod {
    public var periodOffset:Int;
    public var isCurrentPeriod:Bool;
    public init() {
        let currentDate = Date();
        let currentSchedule = CurrentSchedule(currentDate).currentSchedule;
        var offset = 0;
        isCurrentPeriod = false;
        for period in currentSchedule {
            let start = period.0;
            let end = period.1;
            if(start < currentDate && end > currentDate) {
                isCurrentPeriod = true;
                break;
            } else {
                offset += 1;
            }
        }
        periodOffset = offset;
    }
}
