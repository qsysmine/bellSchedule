//
//  Settings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 1/12/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation

public enum SettingType: String {
	case twelve = "twelve"
	case twentyfour = "twentyfour"
}

public enum SettingLabel: String {
	case timeType = "settingUserTimeType"
	case colour = "settingUserColour"
}

public class Settings {
	public static func getTimeType() -> SettingType {
		let userDefaults = UserDefaults.standard;
		if(userDefaults.object(forKey: SettingLabel.timeType.rawValue) == nil) {
			userDefaults.setValue(SettingType.twelve.rawValue, forKey: SettingLabel.timeType.rawValue);
		}
		let setting = userDefaults.string(forKey: SettingLabel.timeType.rawValue);
		if(setting == SettingType.twelve.rawValue) {
			return SettingType.twelve;
		} else {
			return SettingType.twentyfour;
		}
	};
	public static func setTimeType(type: SettingType) {
		let userDefaults = UserDefaults.standard;
		userDefaults.setValue(type.rawValue, forKey: SettingLabel.timeType.rawValue);
	};
}
