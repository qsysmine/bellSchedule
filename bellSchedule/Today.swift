//
//  Today.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation
public class Today {
    public var weekday: String = "";
    public var dateString: String = "";
    public init() {
        let date = Date();
		self.weekday = self.computeWeekday(date);
		self.dateString = self.computeDateString(date);
    }
	private func computeWeekday(_ date: Date) -> String {
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "EEE";
		return dateFormatter.string(from: date).uppercased();
		
	}
	private func computeDateString(_ date: Date) -> String {
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "dd MMM yyyy"
		return dateFormatter.string(from:date).uppercased();
	}
	
}
