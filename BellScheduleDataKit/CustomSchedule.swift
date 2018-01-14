//
//  CustomSchedule.swift
//  BellScheduleDataKit
//
//  Created by Ari Stassinopoulos on 11/13/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation

public class CustomSchedule {
	
	public static let defaults: [String: String] = [
		"per0":"0 Period",
		"per1":"1st Period",
		"per2":"2nd Period",
		"per3":"3rd Period",
		"per4":"4th Period",
		"per5":"5th Period",
		"per6":"6th Period",
		"per7":"7th Period"
	];
	
	public static let keys: [String] = [
		"per0",
		"per1",
		"per2",
		"per3",
		"per4",
		"per5",
		"per6",
		"per7"
	];
	
	public var scheduleContents: [String: String] = [:];
	
	public init(scheduleContents:[String: String]) {
		self.scheduleContents = populateMissingDefaults(scheduleContents);
	}
	public convenience init() {
		self.init(scheduleContents:[:]);
	}
	
	public func populateMissingDefaults(_ scheduleContents: [String:String]) -> [String:String] {
		var newScheduleContents = scheduleContents;
		for (k,v) in CustomSchedule.defaults {
			if(!scheduleContents.keys.contains(k)) {
				newScheduleContents[k] = v;
			}
		}
		return newScheduleContents;
	}
	
	public func replaceWithCustomScheduleString(_ strToReplace: String) -> String{
		var str = strToReplace;
		for(k,v) in scheduleContents {
			str = str.replacingOccurrences(of:"$(\(k))", with: v);
		}
		return str;
	}
}
