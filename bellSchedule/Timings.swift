//
//  Timings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation

public class Timings {
	public static var scheduleMondayTuesdayThursday:[(String,String,String)] = [
		("07:00","07:51","$(per0)"),
		("07:51","08:00","Passing Period"),
		("08:00","08:51","$(per1)"),
		("08:51","08:56","Passing Period"),
		("08:56","09:51","$(per2)"),
		("09:51","09:56","Passing Period"),
		("09:56","10:47","$(per3)"),
		("10:47","10:52","Passing Period"),
		("10:52","11:43","$(per4)"),
		("11:43","11:48","Passing Period"),
		("11:48","12:08","FMP"),
		("12:09","12:39","Lunch"),
		("12:39","12:44","Passing Period"),
		("12:44","13:35","$(per5)"),
		("13:35","13:40","Passing Period"),
		("13:40","14:31","$(per6)"),
		("14:31","14:36","Passing Period"),
		("14:36","15:27","$(per7)")
	];
	public static let scheduleFriday: [(String,String,String)] = [
		("07:00","07:51","$(per0)"),
		("07:51","08:00","Passing Period"),
		("08:00","08:51","$(per1)"),
		("08:51","08:56","Passing Period"),
		("08:56","09:51","$(per2)"),
		("09:51","09:56","Passing Period"),
		("09:56","10:47","$(per3)"),
		("10:47","10:52","Passing Period"),
		("10:52","11:43","$(per4)"),
		("11:43","12:39","Lunch"),
		("12:39","12:44","Passing Period"),
		("12:44","13:35","$(per5)"),
		("13:35","13:40","Passing Period"),
		("13:40","14:31","$(per6)"),
		("14:31","14:36","Passing Period"),
		("14:36","15:27","$(per7)")
	];
	public static let scheduleWednesday: [(String,String,String)] = [
		("07:05","07:49","$(per0)"),
		("07:55","08:55","Collaboration"),
		("08:55","09:00","Passing Period"),
		("09:00","09:44","$(per1)"),
		("09:44","09:49","Passing Period"),
		("09:49","10:33","$(per2)"),
		("10:33","10:38","Passing Period"),
		("10:38","11:22","$(per3)"),
		("11:22","11:27","Passing Period"),
		("11:27","12:11","$(per4)"),
		("12:12","13:01","Lunch"),
		("13:01","13:06","Passing Period"),
		("13:06","13:50","$(per5)"),
		("13:50","13:55","Passing Period"),
		("13:55","14:39","$(per6)"),
		("14:39","14:44","Passing Period"),
		("14:44","15:28","$(per7)")
	];
	public static let scheduleRally: [(String, String, String)] = [
		("07:00","07:55","$(per0)"),
		("07:55","08:00","Passing Period"),
		("08:00","08:46","$(per1)"),
		("08:46","08:51","Passing Period"),
		("08:51","09:42","$(per2)"),
		("09:42","09:47","Passing Period"),
		("09:47","10:33","$(per3)"),
		("10:33","10:38","Passing Period"),
		("10:38","11:24","$(per4)"),
		("11:24","11:29","Passing Period"),
		("11:29","12:13","Rally in Sports Complex"),
		("12:13","12:54","Lunch"),
		("12:54","12:59","Passing Period"),
		("12:59","13:45","$(per5)"),
		("13:45","13:50","Passing Period"),
		("13:50","14:36","$(per6)"),
		("14:36","14:41","Passing Period"),
		("14:41","15:27","$(per7)")
	];
/*WINTER FINALS 2017 [*/	public static let scheduleMondayFinals: [(String, String, String)] = [
		("07:00","07:51","$(per0)"),
		("07:51","08:00","Passing Period"),
		("08:00","10:00","$(per7) Final"),
		("10:00","10:20","Passing Period"),
		("10:20","11:00","$(per1)"),
		("11:00","11:05","Passing Period"),
		("11:05","11:45","$(per2)"),
		("11:45","11:50","Passing Period"),
		("11:50","12:30","$(per3)"),
		("12:30","13:10","Lunch"),
		("13:10","13:15","Passing Period"),
		("13:15","13:55","$(per4)"),
		("13:55","14:00","Passing Period"),
		("14:00","14:40","$(per5)"),
		("14:40","14:45","Passing Period"),
		("14:45","15:25","$(per6)")
	];
	public static let scheduleTuesdayFinals: [(String, String, String)] = [
		("07:00","07:55","$(per0) Final (pt. 1)"),
		("07:55","08:00","Passing Period"),
		("08:00","10:00","$(per6) Final"),
		("10:00","10:15","Break"),
		("10:15","10:20","Passing Period"),
		("10:20","12:20","$(per5) Final")
	];
	public static let scheduleWednesdayFinals: [(String, String, String)] = [
		("07:00","07:55","$(per0) Final (pt. 2)"),
		("07:55","08:00","Passing Period"),
		("08:00","10:00","$(per4) Final"),
		("10:00","10:15","Break"),
		("10:15","10:20","Passing Period"),
		("10:20","12:20","$(per3) Final")
	];
	public static let scheduleThursdayFinals: [(String, String, String)] = [
		("08:00","10:00","$(per2) Final"),
		("10:00","10:15","Break"),
		("10:15","10:20","Passing Period"),
		("10:20","12:20","$(per1) Final")
	];/*] END WINTER FINALS 2017*/
}
