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
	case gold = "Gold"
	case silver = "Silver"
	case white = "White"
}

public enum SettingLabel: String {
	case timeType = "settingUserTimeType"
	case colourType = "settingUserColour"
	case iconMatches = "settingIconMatches"
	case hasPremium = "settingHasPremium"
	case customSchedule = "settingCustomSchedule"
	case lastShownPromo = "promoHomeScreenLastSeenAt"
	case userHasCancelledPromo = "promoHomeScreenUserHasCancelled"
	case hasNotifications = "settingHasClassEndingNotifications"
	case hasZeroPeriodNotifications = "settingHasZeroPeriodClassEndingNotifications"
	case notificationWarning = "settingClassEndingNotificationWarning"
}


public class Settings {
	
	public static let suiteName = "group.com.Stassinopoulos.ari.bellGroup"
	
	public static func shouldShowPromo() -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		if(userDefaults.bool(forKey: SettingLabel.userHasCancelledPromo.rawValue) == false) {
			let lastShownDateString: String? = userDefaults.string(forKey: SettingLabel.lastShownPromo.rawValue);
			if(lastShownDateString == nil) { return true; }
			let dateFormatter = DateFormatter();
			dateFormatter.dateFormat = "dd MMM yyyy";
			let date = dateFormatter.date(from: lastShownDateString!);
			if(date!.addingTimeInterval(60*60*24*2) < Date()) { return true; }
			return false;
		}
		return false;
	}
	
	public static func hasSeenPromo() {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		let date = Date();
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "dd MMM yyyy";
		let dateString = dateFormatter.string(from: date);
		userDefaults.set(dateString, forKey: SettingLabel.lastShownPromo.rawValue);
	}
	
	public static func hasCancelledPromo() {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		userDefaults.set(true, forKey: SettingLabel.userHasCancelledPromo.rawValue);
	}
	
	public static func getNotificationWarning() -> Int {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		return userDefaults.integer(forKey: SettingLabel.notificationWarning.rawValue);
	}
	
	public static func setNotificationWarning(notificationWarning: Int) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		userDefaults.set(notificationWarning, forKey: SettingLabel.notificationWarning.rawValue);
	}
	
	public static func getShowsZeroPeriodNotifications() -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		return userDefaults.bool(forKey: SettingLabel.hasZeroPeriodNotifications.rawValue);
	}
	
	public static func setShowsZeroPeriodNotifications(showsZeroPeriodNotifications: Bool) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		userDefaults.set(showsZeroPeriodNotifications, forKey: SettingLabel.hasZeroPeriodNotifications.rawValue);
	}
	
	public static func hasNotifications() -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		return userDefaults.bool(forKey: SettingLabel.hasNotifications.rawValue);
	}
	
	public static func setHasNotifications(hasNotifications: Bool) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		userDefaults.set(hasNotifications, forKey: SettingLabel.hasNotifications.rawValue);
	}
	
	public static func hasPremium() -> Bool {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		return userDefaults.bool(forKey: SettingLabel.hasPremium.rawValue);
	}
	
	public static func setHasPremium(hasPremium: Bool) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		self.resolveNilTimeType(userDefaults);
		userDefaults.set(hasPremium, forKey: SettingLabel.hasPremium.rawValue);
	}
	
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
		return ColourSettingType(rawValue: setting ?? "Blue")!;
	};
	
	public static func validatePremium() {
		if(self.hasPremium()) {return}
		self.setCustomSchedule(schedule: nil);
		switch self.getColourType() {
		case .gold:
			self.setColourType(type: .blue)
		case .silver:
			self.setColourType(type: .blue);
		case .white:
			self.setColourType(type: .blue);
		default:
			return;
		}
	}
	
	public static func getColour() -> UIColor {
		self.validatePremium();
		let colourType = self.getColourType();
		switch colourType {
		case .blue:
			return UIColor(displayP3Red:0.09, green:0.26, blue:0.36, alpha:1.0);
		case .red:
			return UIColor(displayP3Red: 0.43, green: 0.06, blue: 0.15, alpha: 1.0);
		case .black:
			return UIColor.black;
		case .gold:
			return UIColor(red:0.83, green:0.69, blue:0.22, alpha:1.0)
		case .silver:
			return UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)			
		case .white:
			return UIColor.white;
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
	
	public static func setCustomSchedule(schedule: CustomSchedule?) {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		if(schedule == nil) {
			return userDefaults.set(nil, forKey:SettingLabel.customSchedule.rawValue);
		}
		userDefaults.set(schedule!.scheduleContents, forKey:SettingLabel.customSchedule.rawValue);
	}
	
	public static func getCustomSchedule() -> CustomSchedule {
		let userDefaults = UserDefaults(suiteName: self.suiteName)!;
		let dictionary = userDefaults.dictionary(forKey: SettingLabel.customSchedule.rawValue)
		if(!self.hasPremium() || dictionary == nil) {
			return CustomSchedule();
		}
		return CustomSchedule(scheduleContents: dictionary as! [String:String])
	}
}
