//
//  LocalNotifications.swift
//  BellScheduleDataKit
//
//  Created by Ari Stassinopoulos on 1/27/18.
//  Copyright © 2018 Stassinopoulos. All rights reserved.
//

import Foundation
import UserNotifications

public class LocalNotifications {
	
	public static func canSendLocalNotifications(_ withCompletionBlock: @escaping (Bool) -> Void) {
		let center = UNUserNotificationCenter.current();
		center.getNotificationSettings { (settings) in
			if settings.authorizationStatus != .authorized {
				return withCompletionBlock(false);
			}
			return withCompletionBlock(true);
		}
	}
	
	public static func verifyLocalNotificationAuthorisation(_ withCompletionBlock: @escaping (Bool) -> Void) {
		let center = UNUserNotificationCenter.current();
		center.getNotificationSettings { (settings) in
			if settings.authorizationStatus != .authorized {
				return self.userAuthoriseNotifications(withCompletionBlock);
			}
			return withCompletionBlock(true);
		}
		
	}
	private static func userAuthoriseNotifications(_ withCompletionBlock: @escaping (Bool) -> Void) {
		let center = UNUserNotificationCenter.current();
		let options: UNAuthorizationOptions = [.alert, .sound];
		center.requestAuthorization(options: options) {
			(granted, error) in
			if !granted {
				return withCompletionBlock(false);
			}
			withCompletionBlock(true);
		}
	}
	
	public static func clearNotifications() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
	}
	
	public static func registerNotificationsForDay(forDate baseDate: Date, withTimings currentTimings: [(String, String, String)], warningInMinutes:Int) {
		print(warningInMinutes);
		if(!Settings.hasNotifications()) {
			return;
		}
		let center = UNUserNotificationCenter.current()
		for timing in currentTimings {
			if(timing.2 == "Passing Period" || timing.2.lowercased().contains("happy birthday") || timing.1 == "23:59" || timing.0 == "00:01" || (timing.2 == "$(per0)" && !Settings.getShowsZeroPeriodNotifications())) {
				continue;
			}
			let dateFormatter = DateFormatter();
			dateFormatter.dateFormat = "dd MMM yyyy HH:mm";
			let dayString = Today(baseDate).dateString;
			let classEndTime = timing.1;
			let dateString = "\(dayString) \(classEndTime)";
			var date = dateFormatter.date(from: dateString);
			let dayOfWeek = Calendar(identifier: .gregorian).component(.weekday, from: date!);
			if(dayOfWeek % 6 == 1) { // If it's saturday or sunday (1 or 7)
				continue;
			}
			date = date?.addingTimeInterval(-60 * Double(warningInMinutes));
			let components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date!)
			let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false);
			let className = CustomSchedule().replaceWithCustomScheduleString(timing.2);
			let content = UNMutableNotificationContent()
			content.title = "Pack up!"
			content.body = "\(className) is ending in \(warningInMinutes) minutes!";
			let identifier = "Notification\(timing.2):forDate\(dayString)";
			let request = UNNotificationRequest(identifier: identifier,
												content: content, trigger: trigger)
			center.add(request, withCompletionHandler: { (error) in
				if error != nil {
					return print("well shit");
				}
				print("Added notification for \(String(describing:date!)): ")
				print("    DateS: \(dateString)")
				print("    Title: \(content.title)")
				print("     Body: \(content.body)");
			});
		}
	}
	
	public static func registerNotificationsForWeek(after startingDate: Date) {
		var days: [Date] = [];
		let daysInWeek: Double = 4;
		var offset: Double = 0;
		repeat {
			days.append(startingDate.addingTimeInterval(24 * 60 * 60 * offset));
			offset += 1;
		} while (offset < daysInWeek)
		for day in days {
			print(day);
			registerNotificationsForDay(forDate: day, withTimings: CurrentTimings(day).currentTimings, warningInMinutes: Settings.getNotificationWarning());
		}
	}
}
