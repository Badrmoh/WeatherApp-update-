//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Badr  on 10/19/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell (forecast: Forecast) {
        
        lowTemp.text = forecast.lowTemp
        highTemp.text = forecast.highTemp
        weatherType.text = forecast.weatherType
        imageCell.image = UIImage(named: forecast.weatherType)
        day.text = forecast.date
    }

}
