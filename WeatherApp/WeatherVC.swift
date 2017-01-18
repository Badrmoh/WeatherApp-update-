//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Badr  on 10/17/16.
//  Copyright © 2016 Badr. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationPreview: UILabel!
    @IBOutlet weak var degreePreview: UILabel!
    @IBOutlet weak var datePreview: UILabel!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var forecastPreview: UILabel!
    
    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 2, animations: {
            self.imagePreview.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        animate()
    }
    
    //Getting the current Location
    func setLocation() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
            Location.sharedLocationInstance.Latitude = currentLocation.coordinate.latitude
            Location.sharedLocationInstance.longitude = currentLocation.coordinate.longitude
            print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            print(WEATHER_URL)
            print(FORECAST_URL)
            currentWeather.downloadWeatherDeatils {
                self.downloadForecastData{
                    self.updateUI()
                    self.animateTableView()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            setLocation()
        }
    }
    
    //fecth the JSON data
    func downloadForecastData(Completed: @escaping DownloadComplete) {
        
        Alamofire.request(FORECAST_URL, method: .get).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for weatherDict in list {
                        let forecast = Forecast(weatherDict: weatherDict)
                        self.forecasts.append(forecast)
                        print(weatherDict)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            Completed()
        }
    }

    //TableView settings
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            cell.configureCell(forecast: self.forecasts[indexPath.row])
            return cell
        }else {
            return WeatherCell()
        }
    }
    
    //Update icons and fetched weather data
    func updateUI() {
        
        self.locationPreview.alpha = 0
        self.degreePreview.alpha = 0
        self.forecastPreview.alpha = 0
        self.datePreview.alpha = 0
        self.imagePreview.alpha = 0
        
        UIView.animate(withDuration: 0.7) {
        self.locationPreview.text = self.currentWeather.city
        self.locationPreview.alpha = 1
        }
        UIView.animate(withDuration: 1.0) {
        self.degreePreview.text = "\(self.currentWeather.currentTemp)"
        self.degreePreview.alpha = 1
        }
        UIView.animate(withDuration: 0.9) {
        self.forecastPreview.text = self.currentWeather.weatherType
        self.forecastPreview.alpha = 1
        }
        UIView.animate(withDuration: 0.7) {
        self.datePreview.text = self.currentWeather.date
        self.datePreview.alpha = 1
        }
        UIView.animate(withDuration: 0.9) {
        self.imagePreview.image = UIImage(named: self.currentWeather.weatherType)
        self.imagePreview.alpha = 1
        }
        
    }
    
    //A trial of embedding animation
    func animate() {
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.imagePreview.transform = CGAffineTransform.identity
        }) { (Success: Bool) in
            if Success {
                UIView.animate(withDuration: 3, animations: {
                    self.imagePreview.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                self.animate()
            }
        }
    }
    
    func animateTableView (){
        
        tableView.reloadData()
        let cells = tableView.visibleCells
        let height = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: height)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.3, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }
    }
}

