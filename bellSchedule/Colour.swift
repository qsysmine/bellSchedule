//
//  Colour.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 7/30/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation
import UIKit
import BellScheduleDataKit

class Colour {
	public static func resolveIcon() {
		let colourSettingType = Settings.getColourType();
		if #available(iOS 10.3, *) {
			if UIApplication.shared.supportsAlternateIcons {
				print(UIApplication.shared.alternateIconName ?? "Primary")
				switch(colourSettingType) {
				case .red:
					return UIApplication.shared.setAlternateIconName("AppIconRed") { (err:Error?) in
						print("set icon error：\(String(describing: err))")
					}
				case .blue:
					return UIApplication.shared.setAlternateIconName("AppIconBlue") { (err:Error?) in
						print("set icon error：\(String(describing: err))")
					}
				case .black:
					return UIApplication.shared.setAlternateIconName("AppIconBlack") { (err:Error?) in
						print("set icon error：\(String(describing: err))")
					};
				}
			}
		}
	}
	public static func resetIcon() {
		if #available(iOS 10.3, *) {
			if UIApplication.shared.supportsAlternateIcons {
				return UIApplication.shared.setAlternateIconName(nil);
			}
		}
	}
}
