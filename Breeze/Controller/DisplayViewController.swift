//
//  DisplayViewController.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 09/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblsite: UILabel!
    @IBOutlet weak var lblCheckId: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblShiftName: UILabel!
    @IBOutlet weak var lblTimeDifference: UILabel!
    @IBOutlet weak var lblbreakTime: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    
    var details : History?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblEmployeeName.text = name
        lblDate.text = details?.date
        lblNotes.text = details?.notes
        if let id = details?.checkInCheckOutId{
            lblCheckId.text = "\(id)"
        }
        lblLatitude.text = details?.lattitude
        lblbreakTime.text = details?.breakTime
        lblLongitude.text = details?.longitude
        lblShiftName.text = details?.shiftName
        lblCheckInTime.text = details?.checkInTime
        lblCheckOutTime.text = details?.checkOutTime
        lblTimeDifference.text = details?.timeDifference
        lblsite.text = details?.siteName

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
