//
//  Today.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation
public class Today {
    public var weekday: String;
    public var dateString: String;
    public init() {
        let date = Date();
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "EEE";
        weekday = dateFormatter.string(from: date).uppercased();
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateString = dateFormatter.string(from:date).uppercased();
    }
}
