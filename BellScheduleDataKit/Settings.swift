//
//  Settings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 1/12/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation
import UIKit

public enum TimeSettingType: String {
	case twelve = "twelve"
	case twentyfour = "twentyfour"
}

public enum ColourSettingType: String {
	case blue = "Blue"
	case red = "Red"
	case black = "Black"
}

public enum SettingLabel: String {
	case timeType = "settingUserTimeType"
	case colourType = "settingUserColour"
	case iconMatches = "settingIconMatches"
	case studentID = "settingStudentNumber"
}


public class Settings {
	
	public static let suiteName = "group.com.Stassinopoulos.ari.bellGroup"
	
	public static func resolveNilTimeType(_ userDefaults: UserDefaults) {
		if(userDefaults.object(forKey: SettingLabel.timeType.rawValue) == nil) {
			userDefaults.setValue(TimeSettingType.twelve.rawValue, forKey: SettingLabel.timeType.rawValue);
		}
	}
	
	public static func getTimeType() -> TimeSettingType {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		let setting = userDefaults.string(forKey: SettingLabel.timeType.rawValue);
		if(setting == TimeSettingType.twelve.rawValue) {
			return TimeSettingType.twelve;
		} else {
			return TimeSettingType.twentyfour;
		}
	};
	
	public static func setTimeType(type: TimeSettingType) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		userDefaults.setValue(type.rawValue, forKey: SettingLabel.timeType.rawValue);
	};
	
	public static func setColourType(type: ColourSettingType) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		userDefaults.setValue(type.rawValue, forKey: SettingLabel.colourType.rawValue);
	};
	
	public static func getColourType() -> ColourSettingType {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		let setting = userDefaults.string(forKey: SettingLabel.colourType.rawValue);
		if(setting == ColourSettingType.red.rawValue) {
			return ColourSettingType.red;
		} else if(setting == ColourSettingType.black.rawValue) {
			return ColourSettingType.black;
		} else {
			return ColourSettingType.blue;
		}
	};
	
	public static func getColour() -> UIColor {
		let colourType = self.getColourType();
		switch colourType {
		case .blue:
			return UIColor(displayP3Red:0.09, green:0.26, blue:0.36, alpha:1.0);
		case .red:
			return UIColor(displayP3Red: 0.43, green: 0.06, blue: 0.15, alpha: 1.0);
		case .black:
			return UIColor.black;
		}
	};
	
	public static func setIconMatchesColour(matches: Bool) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		userDefaults.setValue(matches, forKey: SettingLabel.iconMatches.rawValue);
	}
	
	public static func getIconMatchesColour() -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		if(userDefaults.object(forKey: SettingLabel.iconMatches.rawValue) == nil) {
			return false;
		}
		let setting = userDefaults.bool(forKey: SettingLabel.iconMatches.rawValue);
		return setting;
	}
	
	public static func setStudentNumber(number: String?) -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		if(number == nil) {
			return false;
		} else if(number == "") {
			userDefaults.set(nil, forKey: SettingLabel.studentID.rawValue);
			return true;
		}
		var settableNumber = number!.trimmingCharacters(in: .whitespacesAndNewlines);
		if(Int(settableNumber) == nil || settableNumber.characters.count < 5 || settableNumber.characters.count > 6) {
			return false;
		}
		userDefaults.set(settableNumber, forKey: SettingLabel.studentID.rawValue);
		return true;
	}
	
	public static func getStudentNumber() -> String? {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		return userDefaults.string(forKey: SettingLabel.studentID.rawValue);
	}
}
