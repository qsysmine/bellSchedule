//
//  DisplayTime.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 1/12/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation

public class DisplayTime {
	public var resolved: String;
	public init(_ twentyFourString: String) {
		switch Settings.getTimeType() {
		case .twentyfour:
			resolved = twentyFourString;
			break;
		case .twelve:
			let dateFormatter = DateFormatter();
			dateFormatter.dateFormat = "HH:mm";
			let date = dateFormatter.date(from: twentyFourString);
			dateFormatter.dateFormat = "h:mm a"
			dateFormatter.locale = Locale(identifier:"en_US");
			resolved = dateFormatter.string(from: date!);
			break;
		}
	}
}
