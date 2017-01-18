//
//  Forecast.swift
//  WeatherApp
//
//  Created by Badr  on 10/19/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _lowTemp : String!
    var _highTemp : String!
    var _date : String!
    var _weatherType : String!
    
    var lowTemp :String {
        
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    var highTemp :String {
        
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }

    var date :String {
        
        if _date == nil {
            _date = ""
        }
        return _date
    }

    var weatherType :String {
        
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
       
    init(weatherDict obj: Dictionary<String, AnyObject>) {
        //initialize the attributes of a forecast object
        
        if let temp = obj["temp"] as? Dictionary<String, AnyObject> {
            
            if let minTempk = temp["min"] as? Double {
                let toFahrenheit = (minTempk * 1.8) - 459.67
                let minTempF = Double(round(10 * toFahrenheit / 10))
                self._lowTemp = "\(minTempF)"
                //print("low temp is : \(lowTemp)")
            }
            if let maxTempk = temp["max"] as? Double {
                let toFahrenheit = (maxTempk * 1.8) - 459.67
                let maxTempF = Double(round(10 * toFahrenheit / 10))
                self._highTemp = "\(maxTempF)"
                //print("high temp is : \(highTemp)")
            }
        }
        
        if let weather = obj["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                //print("weather type is : \(weatherType)")
            }
        }
        
        if let date = obj["dt"] as? Double {
            let unixFormat = Date(timeIntervalSince1970 : date)
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "EEEE"
            dateformatter.dateStyle = .full
            dateformatter.timeStyle = .none
            self._date = unixFormat.dayOfTheWeek()
            print("here is the date check it out : \(date)")
        }
    
    }

    
}

extension Date{
    
    func dayOfTheWeek () -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
    }
}



















