//
//  Constants.swift
//  WeatherApp
//
//  Created by Badr  on 10/17/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import Foundation

var BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
var LATITUDE = "lat="
var LONGITUDE = "&lon="
var API_KEY = "&appid=8e7da17ec657b26a9fe78b83c9840bb9"

var WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedLocationInstance.Latitude!)\(LONGITUDE)\(Location.sharedLocationInstance.longitude!)\(API_KEY)"

var FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?\(LATITUDE)\(Location.sharedLocationInstance.Latitude!)\(LONGITUDE)\(Location.sharedLocationInstance.longitude!)&cnt=10&mode=json\(API_KEY)"

typealias DownloadComplete = () -> ()
