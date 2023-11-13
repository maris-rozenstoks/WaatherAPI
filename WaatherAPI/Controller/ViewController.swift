//
//  ViewController.swift
//  WaatherAPI
//
//  Created by maris.rozenstoks on 13/11/2023.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    let apiKey: String = ""
    let apiHost: String = "weatherapi-com.p.rapidapi.com"
    let apiUrl: String = "https://weatherapi-com.p.rapidapi.com/current.json"
    var city: String = "Riga"
    
    var currentWeather: CurrentWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
    }
    
    func loadWeatherData() {
        let headers: [String: String] = ["X-RapidAPI-Key": apiKey, "X-RapidAPI-Host": apiHost]
        let params: [String: String] = ["q": city]
        AF.request(apiUrl, method: .get, parameters: params, headers: HTTPHeaders(headers)).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let value):
                self.currentWeather = value
                self.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI() {
        guard let weather = currentWeather else { return }
        temperatureLabel.text = "\(weather.current.tempC ?? 0)°C"
        cityLabel.text = weather.location.name
    }
    
    @IBAction func updateWeatherButtonPressed(_ sender: UIButton) {
        if let newCity = cityTextField.text, !newCity.isEmpty {
            print("Updating weather for city: \(newCity)")
            city = newCity
            loadWeatherData()
        }
    }
}

