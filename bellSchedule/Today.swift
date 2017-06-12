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
	public var isSummer: Bool = false;
    public init() {
        let date = Date();
		self.weekday = self.computeWeekday(date);
		self.dateString = self.computeDateString(date);
		self.isSummer = self.computeIsSummer(date);
		print(isSummer);
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
	/* SUMMER 2017 [*/
	private func computeIsSummer(_ date: Date) ->Bool {
		let endOfSummer = "14 Aug 2017 00:00";
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "dd MMM yyyy HH:mm";
		let endOfSummerDate = dateFormatter.date(from: endOfSummer)!;
		return date < endOfSummerDate;
		
	}
	/*] END SUMMER 2017 */
}
