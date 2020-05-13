//
//  Holiday.swift
//  Holidays
//
//  Created by Clay Suttner on 4/4/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation

// data model corresponds to json structure of API output

/*
{
    "meta": {
        "code": 200
    },
    "response": {
        "holidays": [
            {
                "name": "New Year's Day",
                "description": "New Year's Day is the first day of the Gregorian calendar, which is widely used in many countries such as the USA.",
                "country": {
                    "id": "us",
                    "name": "United States"
                },
                "date": {
                    "iso": "2019-01-01",
                    "datetime": {
                        "year": 2019,
                        "month": 1,
                        "day": 1
                    }
                },
*/

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
