//
//  employeeDataTableViewController.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 07/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class EmployeeDataTableViewController: UITableViewController {


    var ShiftData : Shift?
    var total: Int?
    var page = 1
    var displayData = [History]()
    lazy var refreshData : UIRefreshControl={
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(handleRefreshData), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshData
        ApiService.sharedInstance.sendShiftData(url: "http://api.breezworkforce.com/v1/employee/history", page: page) { (data) in
           DispatchQueue.main.async {
            self.ShiftData = data
            self.displayData = data.history as! [History]
            self.page = data.pageCount ?? 1
            self.total = self.page * 10
            self.tableView.reloadData()
            self.handleRefreshData()
            if let name = self.ShiftData?.employeeName,let hours = self.ShiftData?.hour
            {
                self.navigationItem.title = "\(name) ( \(hours) )"
            }
        }
      }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return ShiftData?.history.count ?? 0
        return displayData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
         
        if let startTime = displayData[indexPath.row].checkInTime,let endTime = displayData[indexPath.row].checkOutTime
        {
            let sTime = getWorkingTime(time: startTime)
            cell.lblStartTime.text = sTime
            
            let eTime = getWorkingTime(time: endTime)
            cell.lblEndTime.text = eTime
        }
        if let notes = displayData[indexPath.row].notes{
            cell.lblNotes.text = notes
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
  @objc  func handleRefreshData(){
       refreshData.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       performSegue(withIdentifier: "toDisplay", sender: self)
       tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayData.count - 2{
            if let count = total{
                if displayData.count < count{

                    page = page+1
                    ApiService.sharedInstance.sendShiftData(url: "http://api.breezworkforce.com/v1/employee/history", page: page) { (data) in
                        DispatchQueue.main.async {
                            for i in data.history{
                                self.displayData.append(i!)
                            }

                        self.perform(#selector(self.loadData))
                        }
                    }
                    
                }
            }
        }
    }
    
    @objc func loadData(){
        self.tableView.reloadData()
    }

    func getWorkingTime(time:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let timezone = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "h:mm a"
        let hour = dateFormatter.string(from:timezone!)
        return hour
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDisplay"{
            if let destination = segue.destination as? DisplayViewController{
                if let index = self.tableView.indexPathForSelectedRow?.row{
                    destination.details = ShiftData?.history[index]
                    destination.name = ShiftData?.employeeName
                }
            }
        }
    }
}

