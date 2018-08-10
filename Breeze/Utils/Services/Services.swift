//
//  Services.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 07/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class ApiService : UIViewController
{
    static let sharedInstance = ApiService()
    let baseUrl = "http://api.breezworkforce.com/"
    let sendData = "v1/employee/login/"
    let getData = "v1/employee/getProfile"
    var employeeArray : [Employee]? = []
    var objShift : Shift?
    var objEmp : Employee?
    
    
    func sendData(url:String, completionHandler:@escaping(_ response: String,_ error:Error)->())
    {
        guard let Url = URL(string: url) else{ return}
        var request = URLRequest(url: Url)

        request.httpMethod = "POST"
        request.httpBody = "email=utsav.patel.sa@gmail.com&password=emp123".data(using: String.Encoding.utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {
                print("\(String(describing: error ))")
                return
            }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
//                    print(responseJSON)
                    if let access_token = responseJSON["access_token"]{
                        let defaults = UserDefaults()
                        defaults.set(access_token, forKey: "access_token")
                        defaults.synchronize()
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
    }
     task.resume()
  }
    
    func getEmpData(url:String,completion:@escaping(_ response:[Employee])->()){
        guard let Url = URL(string: url) else{ return }
        var request = URLRequest(url: Url)
        request.httpMethod = "GET"
        request.addValue(UserDefaults.standard.value(forKey: "access_token") as! String, forHTTPHeaderField: "x-auth-token")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard  error == nil && data != nil else{
                print("\(String(describing: error))")
                return
            }
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<String,Any>
                {
//                    print(responseJSON)
                    self.objEmp = Employee()
                    self.objEmp?.address = responseJSON["address"] as? String
                    self.objEmp?.id = responseJSON["id"] as? Int
                    self.objEmp?.companyId = responseJSON["companyId"] as? Int
                    self.objEmp?.employeeId = responseJSON["employeeId"] as? String
                    self.objEmp?.firstName = responseJSON["firstName"] as? String
                    self.objEmp?.lastName = responseJSON["lastName"] as? String
                    self.objEmp?.email = responseJSON["email"] as? String
                    self.objEmp?.phoneNumber = responseJSON["phoneNumber"] as? String
                    self.objEmp?.deviceToken = responseJSON["deviceToken"] as? String
                    self.objEmp?.designation = responseJSON["designation"] as? String
                    self.objEmp?.hourlyPay = responseJSON["hourlyPay"] as? String
                    self.objEmp?.isDisplay = responseJSON["isDisplay"] as? String
                    self.objEmp?.created = responseJSON["created"] as? String
                    self.objEmp?.modified = responseJSON["modified"] as? String
    
                    self.employeeArray?.append(self.objEmp!)
                    completion(self.employeeArray! )
                }
            }
            catch{
                print("\(error)")
            }
        }
        task.resume()
    }
    
    
    func sendShiftData(url:String, page:Int,completionHandler:@escaping(_ response: Shift)->())
    {
        guard let Url = URL(string: url) else{ return}
        var request = URLRequest(url: Url)
        request.httpMethod = "POST"
        request.httpBody = "startDate=2018-08-02&endDate=2018-08-09&pageNumber=\(page)".data(using: String.Encoding.utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(UserDefaults.standard.value(forKey: "access_token") as! String, forHTTPHeaderField: "x-auth-token")
        request.addValue("+05:30", forHTTPHeaderField: "Time-Zone")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {
                print("\(String(describing: error ))")
                return
            }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String,Any>{
//                                  print(responseJSON)
                    self.objShift = Shift()
                    self.objShift?.employeeName = responseJSON["employeeName"] as? String
                    self.objShift?.pageCount = responseJSON["totalPageCount"] as? Int
                    let totalHours = responseJSON["totalHours"] as? Dictionary<String,Any>
                    self.objShift?.hour = totalHours?["hour"] as? Int
//                    print("\(self.objShift?.hour)")
                    let history = responseJSON["history"] as? [[String:Any]]
                    for (index,element) in history!.enumerated(){
                        let obj = History()
                        obj.date = element["date"] as? String
                        obj.breakTime = element["breakTime"]as? String
                        obj.checkInCheckOutId = element["checkInCheckOutId"]as? Int
                        obj.checkInTime = element["checkInTime"]as? String
                        obj.checkOutTime = element["checkOutTime"]as? String
                        obj.longitude = element["longitude"]as? String
                        obj.lattitude = element["lattitude"]as? String
                        obj.notes = element["notes"]as? String
                        obj.shiftName = element["shiftName"]as? String
                        obj.siteName = element["siteName"]as? String
                        obj.timeDifference = element["timeDifference"]as? String
                        self.objShift?.history.append(obj)
                        if index == (history?.count)!-1{
                            completionHandler(self.objShift!)
                        }
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
