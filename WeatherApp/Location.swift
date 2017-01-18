//
//  Location.swift
//  WeatherApp
//
//  Created by Badr  on 10/19/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedLocationInstance = Location()
    private init () {}
    
    var longitude : Double!
    var Latitude :Double!
}
