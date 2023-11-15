//
//  ViewController.swift
//  WaatherAPI
//
//  Created by maris.rozenstoks on 13/11/2023.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let apiKey: String = "d239831fd9msh4ad7cb7ac973f08p13968ejsn70e9adc40ca5"
    let apiHost: String = "weatherapi-com.p.rapidapi.com"
    let apiUrl: String = "https://weatherapi-com.p.rapidapi.com/current.json"
    var location: String = "Riga"
    
    var currentWeather: CurrentWeather?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getTemperatureButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        getTemperatureButton.addTarget(self, action: #selector(getTemperature(_:)), for: .touchUpInside)
        loadWeatherData()
        cityTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn called")
        textField.resignFirstResponder()
        loadWeatherData()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            self.location = lat + "," + long
            self.loadWeatherData()
            locationLabel.text = "\(location.coordinate.longitude) , \(location.coordinate.latitude)"
        }
    }
    
    
    @IBAction func getTemperature(_ sender: Any) {
        self.location = self.cityTextField.text!
        self.loadWeatherData()
    }
    
    func loadWeatherData() {
        let headers: [String: String] = ["X-RapidAPI-Key": apiKey, "X-RapidAPI-Host": apiHost]
        let params: [String: String] = ["q": self.location]
        
        AF.request(apiUrl, method: .get, parameters: params, headers: HTTPHeaders(headers)).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let value):
                self.currentWeather = value
                self.temperatureLabel.text = (self.currentWeather?.current.tempC?.description ?? "...") + " °C"
                self.cityLabel.text = (self.currentWeather?.location.name ?? self.location)
                
            case .failure(let error):
                print(error)
                self.presentErrorAlert()
            }
        }
    }
    
    func presentErrorAlert() {
        let alert = UIAlertController(title: "Wrong Input", message: "Please check your input and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
