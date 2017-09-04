//
//  StudentIDViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 8/8/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit
import BellScheduleDataKit

class StudentIDViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Settings.getStudentNumber() == nil) {
            return;
        }
        let studentNumber = Settings.getStudentNumber()!;
        idNumber.text = studentNumber;
		imageView.image = Barcode.generateBarcode(from: studentNumber);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
