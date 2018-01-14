//
//  PremiumPromoView.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 12/17/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class PremiumPromoView: UIView {

	@IBOutlet var promoButton: UIButton!;
    @IBOutlet var closeButton: UIButton!;
    @IBOutlet var textLabel: UILabel!;
	var mainScreen: MainScreenController?;
	var stillExists: Bool = true;
	override func awakeFromNib() {
		super.awakeFromNib()
		if(Settings.hasPremium()) {
			self.removeFromSuperview();
			return;
		}
		addButtonTargets()
		self.backgroundColor = Settings.getColour();
		let deadlineTime = DispatchTime.now() + .seconds(10);
		DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
			if(self.stillExists) {
				self.close();
			}
		}
	}
	func addButtonTargets() {
		self.closeButton.addTarget(self, action: #selector(self.registerClose), for: .touchUpInside);
		self.promoButton.addTarget(self, action: #selector(self.learnMore), for: .touchUpInside);
	}
	@objc func registerClose() {
		Settings.hasCancelledPromo();
		DispatchQueue.main.async {
			self.close();
		}
	}
	@objc func close() {
		stillExists = false;
		UIView.animate(withDuration: 0.5,
			delay: 0.0,
			options: [],
			animations: {
				self.transform = CGAffineTransform(translationX: 0, y: -100)
			}, completion: {finished in
				self.removeFromSuperview()
		})
	}
	@objc func learnMore() {
		if(self.mainScreen != nil) {
			self.mainScreen!.gotoPremiumSettings();
		}
	}
}
