//
//  ViewController.swift
//  Holidays
//
//  Created by Clay Suttner on 4/3/20.
//  Copyright © 2020 skite. All rights reserved.
//

import UIKit

class HolidaysTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    // {} makes this a computed property
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            // since this updates the UI, we need to perform it on the main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found"
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the HolidaysTableViewController class is responsible for managing
        // the searchBar we got from Interface Builder
        searchBar.delegate = self
    }
    
    // set the number of sections in the tableview equal to one
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    // managing individual table view cells...
    // return a UITVCell type
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = listOfHolidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        return cell
    }
    
    
}

extension HolidaysTableViewController : UISearchBarDelegate {
    
    // one of the many methods available to you after implementing a the UISearchBar
    // delegate extension
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
        holidayRequest.getHolidays(completion: <#T##(Result<[HolidayDetail], HolidayError>) -> Void#>)
    }
}
