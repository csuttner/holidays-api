//
//  HolidayRequest.swift
//  Holidays
//
//  Created by Clay Suttner on 4/4/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation

// good place to create cases for all API errors documented
enum HolidayError: Error {
    case noDataAvailable
    case cantProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "ENTER_API_KEY_HERE"
    
    init(countryCode: String) {
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=2019"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    // a common way of doing things...
    // once we have the info from the web we need, we'll need to have a completion closure (())
    // result always has a success and a failure case
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        
        // trailing closure syntax - "syntactic sugar"
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.cantProcessData))
            }
            
        }
        dataTask.resume()
    }
    
}
