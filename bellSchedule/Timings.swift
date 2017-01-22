//
//  Timings.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/13/16.
//  Copyright © 2016 Stassinopoulos. All rights reserved.
//

import Foundation

public class Timings {
    public static let scheduleMondayTuesdayThursday: [(String,String,String)] = [
        ("07:00","07:51","0 Period"),
        ("08:00","08:51","1st Period"),
        ("08:56","09:51","2nd Period"),
        ("09:56","10:47","3rd Period"),
        ("10:52","11:43","4th Period"),
        ("11:48","12:08","FMP"),
        ("12:09","12:39","Lunch"),
        ("12:44","13:35","5th Period"),
        ("13:40","14:31","6th Period"),
        ("14:36","15:27","7th Period")
    ];
    public static let scheduleFriday: [(String,String,String)] = [
        ("07:00","07:51","0 Period"),
        ("08:00","08:51","1st Period"),
        ("08:56","09:51","2nd Period"),
        ("09:56","10:47","3rd Period"),
        ("10:52","11:43","4th Period"),
        ("11:43","12:39","Lunch"),
        ("12:44","13:35","5th Period"),
        ("13:40","14:31","6th Period"),
        ("14:36","15:27","7th Period")
    ];
    public static let scheduleWednesday: [(String,String,String)] = [
        ("07:05","07:49","0 Period"),
        ("07:55","08:55","Collaboration"),
        ("09:00","09:44","1st Period"),
        ("09:49","10:33","2nd Period"),
        ("10:38","11:22","3rd Period"),
        ("11:27","12:11","4th Period"),
        ("12:12","13:01","Lunch"),
        ("13:06","13:50","5th Period"),
        ("13:55","14:39","6th Period"),
        ("14:44","15:28","7th Period")
    ];
	public static let scheduleRally: [(String, String, String)] = [
		("07:00","07:55","0 Period"),
		("08:00","08:46","1st Period"),
		("08:51","09:42","2nd Period"),
		("09:47","10:33","3rd Period"),
		("10:38","11:24","4th Period"),
		("11:29","12:13","Rally in Sports Complex"),
		("12:14","12:54","Lunch"),
		("12:59","13:45","5th Period"),
		("13:50","14:36","6th Period"),
		("14:41","15:27","7th Period")
	]
}
