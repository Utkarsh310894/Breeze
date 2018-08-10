//
//  WebModel.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 07/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class Employee: Decodable {
    
    var id: Int?
    var employeeId: String?
    var companyId: Int?
    var firstName: String?
    var lastName: String?
    var address: String?
    var email: String?
    var phoneNumber: String?
    var deviceToken: String?
    var designation: String?
    var hourlyPay: String?
    var isDisplay: String?
    var created:String?
    var modified:String?

}

class Shift:NSObject{
    
    var pageCount:Int?
    var hour:Int?
    var employeeName:String?
    var history: [History?] = []
}
class History{
    var date: String?
    var checkInTime: String?
    var checkOutTime: String?
    var breakTime: String?
    var timeDifference: String?
    var notes: String?
    var shiftName: String?
    var checkInCheckOutId: Int?
    var siteName: String?
    var lattitude: String?
    var longitude:String?
}
