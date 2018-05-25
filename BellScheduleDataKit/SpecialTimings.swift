//
//  SpecialTimings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 9/4/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation

public enum SpecialTimingsLabels: String {
	case timings = "specialTimings"
	case timingDate = "specialTimingDate"
	case lastChecked = "specialTimingLastChecked"
}

public enum SpecialTimingsError: Error {
	case networkError
	case dataIsEmptyError
	case couldNotParseScheduleError
	case noSchedule
}

public class SpecialTimings {
	public static let suiteName = "group.com.Stassinopoulos.ari.bellGroup"
	
	public static func checkForSpecialTimings(for date: Date, _ callback: @escaping (Bool, SpecialTimingsError?) -> Void) {
		print("explicit network check");
		let dateString = Today(Date()).dateString;
		let unq = Date().timeIntervalSince1970;
		let allowedCharacterSet = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted;
		let urlEncodedDateString = dateString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "";
		let url = URL(string: "https://raw.githubusercontent.com/qsysmine/bellSchedule/specialSchedule/schedules/\(urlEncodedDateString).bell?unq=\(unq)");
		let task = URLSession.shared.dataTask(with: url!) { data, response, error in
			guard error == nil else {
				print(error!)
				self.setLastChecked()
				return callback(false, .networkError);
			}
			guard let data = data else {
				self.setLastChecked()
				return callback(false, .dataIsEmptyError);
			}
			let dataString = String(data: data, encoding: .utf8);
			let dataStringComponents = dataString?.components(separatedBy: "\n==\n");
			if(dataStringComponents?[0] == Today(Date()).dateString) {
				let bellFileContents = dataStringComponents?[1] ?? "";
				if(BellFileParser(bellFileContents).timings != nil) {
					self.saveSpecialTimings(timings: bellFileContents);
					return callback(true, nil);
				} else {
					self.setLastChecked()
					return callback(false, .couldNotParseScheduleError);
				}
			} else {
				if(dataStringComponents?[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "404: Not Found") {
					saveSpecialTimings(timings: nil);
					return callback(false, .noSchedule);
				}
					return callback(false, .couldNotParseScheduleError);
			}
		}
		
		task.resume()
	}
	private static func saveSpecialTimings(timings: String?) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		let dateString = Today(Date()).dateString;
		userDefaults.set(timings, forKey: SpecialTimingsLabels.timings.rawValue);
		if(timings == nil) {
			userDefaults.set(nil, forKey: SpecialTimingsLabels.timingDate.rawValue);
			return self.setLastChecked();
		}
		userDefaults.set(dateString, forKey: SpecialTimingsLabels.timingDate.rawValue);
		self.setLastChecked()
	}
	public static func getSpecialTimings(for date: Date) -> [(String, String, String)]? {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		let specialTimingsDate = userDefaults.string(forKey: SpecialTimingsLabels.timingDate.rawValue);
		if(specialTimingsDate == nil || specialTimingsDate! != Today(date).dateString) {
			return nil;
		}
		let specialTimings = userDefaults.string(forKey: SpecialTimingsLabels.timings.rawValue);
		if(specialTimings == nil || BellFileParser(specialTimings!).timings == nil) {
			return nil;
		}
		return BellFileParser(specialTimings!).timings!;
	}
	public static func lazyCheckForSpecialTimings(for date: Date, _ callback: @escaping (Bool, SpecialTimingsError?) -> Void) {
		if(self.getSpecialTimings(for: date) != nil) {
			return callback(true, nil);
		}
		if(Date().timeIntervalSince1970 - 21600 > getLastChecked()) {
			return self.checkForSpecialTimings(for: date, callback);
		}
		callback(false, nil);

	}
	private static func setLastChecked() {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		let unq = Date().timeIntervalSince1970;
		userDefaults.set(unq, forKey: SpecialTimingsLabels.lastChecked.rawValue);
	}
	private static func getLastChecked()->Double {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		if(userDefaults.value(forKey: SpecialTimingsLabels.lastChecked.rawValue) != nil) {
			return userDefaults.double(forKey: SpecialTimingsLabels.lastChecked.rawValue);
		} else {
			return 0;
		}
	}
}
