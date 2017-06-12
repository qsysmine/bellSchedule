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
}

public enum SettingLabel: String {
	case timeType = "settingUserTimeType"
	case colourType = "settingUserColour"
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
	
	public static func getColourType() -> ColourSettingType {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		let setting = userDefaults.string(forKey: SettingLabel.colourType.rawValue);
		if(setting == ColourSettingType.red.rawValue) {
			return ColourSettingType.red;
		} else {
			return ColourSettingType.blue;
		}
	};
	
	public static func setColourType(type: ColourSettingType) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		userDefaults.setValue(type.rawValue, forKey: SettingLabel.colourType.rawValue);
	};
	
	public static func getColour() -> UIColor {
		let colourType = self.getColourType();
		switch colourType {
		case .blue:
			return UIColor(displayP3Red:0.09, green:0.26, blue:0.36, alpha:1.0);
		case .red:
			return UIColor(displayP3Red: 0.43, green: 0.06, blue: 0.15, alpha: 1.0);
		}
	};
	
}
