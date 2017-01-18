//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Badr  on 10/17/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    var _city :String!
    var _weatherType :String!
    var _date :String!
    var _currentTemp :Double!
    
    var city : String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
        
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDeatils (Completed: @escaping DownloadComplete) {
        
        Alamofire.request(WEATHER_URL, method: .get).responseJSON {response in
            let result = response.result
            //print(response)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                //print(dict)
                if let name = dict["name"] as? String {
                    self._city = name.capitalized
                    
                    //print(self.city)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]  {
                    
                    if let type = weather[0]["main"] as? String {
                        self._weatherType = type.capitalized
                        
                        //print(self.weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let tempK = main["temp"] as? Double {
                        let toFahrenheit = (tempK * 1.8) - 459.67
                        let temp = Double(round(10 * toFahrenheit / 10))
                        self._currentTemp = temp
                        
                        //print(self.currentTemp)
                    }
                }
            }
            
         Completed()
            
        }
    }
}


