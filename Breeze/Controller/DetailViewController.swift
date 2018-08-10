//
//  DetailViewController.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 09/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblCheckInId: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblShiftName: UILabel!
    @IBOutlet weak var lblTimeDifference: UILabel!
 
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckTime: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
