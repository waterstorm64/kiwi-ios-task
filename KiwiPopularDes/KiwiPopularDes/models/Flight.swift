//
//  Flight.swift
//  KiwiPopularDes
//
//  Created by Hung Nguyen on 3/7/17.
//  Copyright © 2017 Hung Nguyen. All rights reserved.
//

import Foundation


import Foundation

class Flight {
    
    var cityFromId: String = ""
    var cityToId: String = ""
    var cityFrom: String = ""
    var cityTo: String = ""
    var flyFrom: String = ""
    var flyTo: String = ""
    
    var countryFrom: String = ""
    var countryTo: String = ""
    var price: Float = 0
    var currency = ""
    var timeDeparture: Double = 0
    var timeArrival: Double = 0
    var duration: String = ""
    var date: String = ""
    var route: [Flight] = []
    
    init(json: [String:Any]){
        cityFrom = (json["cityFrom"] as? String)!
        cityFromId = (json["mapIdfrom"] as? String)!
        cityTo = (json["cityTo"] as? String)!
        cityToId = (json["mapIdto"] as? String)!
        
        flyFrom = (json["flyFrom"] as? String)!
        flyTo = (json["flyTo"] as? String)!
        
        if json.index(forKey: "countryTo") != nil {
            let countryDict = (json["countryTo"]as? [String:Any])!
            countryTo = (countryDict["name"] as? String)!
        }
        
        if json.index(forKey: "countryFrom") != nil {
            let countryDict = (json["countryFrom"]as? [String:Any])!
            countryFrom = (countryDict["name"] as? String)!
        }
        
        if json.index(forKey: "fly_duration") != nil {
            duration = (json["fly_duration"] as? String)!
        }
        
        price = (json["price"] as? Float)!
        
        if json.index(forKey: "dTime") != nil {
            timeDeparture = (json["dTime"] as? Double)!
        }
        
        if json.index(forKey: "aTime") != nil {
            timeArrival = (json["aTime"] as? Double)!
        }
        
        if json.index(forKey: "route") != nil {
            let list = json["route"] as? [[String:Any]]
            route = (list?.map{ Flight(json: $0) })!
        }
    }
    
    open class func parseFlight(_ json: [String:Any]) -> [Flight] {
        let list = json["data"] as? [[String:Any]]
        
        if !(list?.isEmpty)!{
            let result = (list?.map{ Flight(json: $0) })!
            for flight in result{
                flight.currency = Helper.getCurrencySymbol(currency: (json["currency"] as? String)!)
            }
            return result
        }
        else{
            return []
        }
    }
}



