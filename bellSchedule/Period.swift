//
//  Period.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation
public class Period {
    public var startDate: Date;
    public var endDate: Date;
    public init(start: String, end: String) {
        let today = Today();
        let todayDateString = today.dateString;
        let dateFormat = "dd MMM yyyy HH:mm";
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = dateFormat;
        startDate = dateFormatter.date(from: "\(todayDateString) \(start)")!;
        endDate = dateFormatter.date(from: "\(todayDateString) \(end)")!;
    }
}
