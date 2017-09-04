//
//  Barcode.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/8/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation
import UIKit
import RSBarcodes
import AVFoundation

public class Barcode {
	public static func generateBarcode(from string: String) -> UIImage? {
		return RSUnifiedCodeGenerator.shared.generateCode(string, machineReadableCodeObjectType: AVMetadataObjectTypeCode39Code);
	}
}
