import Foundation

public class CurrentSchedule {
	public var currentSchedule:[(Date, Date, String)];
	public init() {
		let currentTimings = CurrentTimings().currentTimings;
		currentSchedule = Schedule(timings: currentTimings).asDates;
	}
}
