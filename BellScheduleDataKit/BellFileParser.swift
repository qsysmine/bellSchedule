//
//  BellFileParser.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 9/4/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import Foundation

public extension String {
	func contentsOrBlank()->String {
		if let path = Bundle.main.path(forResource:self , ofType: nil) {
			do {
				let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
				return text
			} catch { print("Failed to read text from bundle file \(self)") }
		} else { print("Failed to load file from bundle \(self)") }
		return ""
	}
}

class BellFileParser {
	var timings: [(String, String, String)]?;
	init (_ fileContents:String) {
		if(fileContents == "") {
			self.timings = [(String, String, String)]();
			return;
		}
		let fileLines = fileContents.components(separatedBy: ";\n");
		var timingsToBe = [(String, String, String)]();
		fileLines.forEach { (line) in
			let lineComponents = line.components(separatedBy: "\",\"");
			if(lineComponents.count == 0) {
				return;
			}
			timingsToBe.append((lineComponents[0].trimmingCharacters(in: ["\""]), lineComponents[1], lineComponents[2].components(separatedBy: "\"").joined(separator: "")));
		}
		self.timings = timingsToBe;
	}
	convenience init (filePath: String) {
		do {
			self.init(filePath.contentsOrBlank())
		}
	}
}
