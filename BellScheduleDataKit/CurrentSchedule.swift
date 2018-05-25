import Foundation

public class CurrentSchedule {
	public var currentSchedule:[(Date, Date, String)];
	public init(_ date: Date) {
		let currentTimings = CurrentTimings(date).currentTimings;
		currentSchedule = Schedule(timings: currentTimings).asDates;
	}
}
