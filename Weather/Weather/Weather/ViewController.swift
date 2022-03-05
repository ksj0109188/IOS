//
//  ViewController.swift
//  Weather
//
//  Created by 김성준 on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapFetchWeatherButton(_ sender: Any) {
        if let cityName = self.cityNameTextField.text{
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
        }
        
    }

    func getCurrentWeather(cityName:String){
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=22f8587848fe0871812e2e7f56b38bb8") else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){ [weak self]
            data, response, error in
            guard let data = data, error == nil else {return}
            let decoder = JSONDecoder()
            guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from:data) else {return}
            DispatchQueue.main.async {
                self?.weatherStackView.isHidden = false
                self?.configureView(weatherInformation: weatherInformation)
            }
        }.resume()
    }
    
    func configureView(weatherInformation:WeatherInformation){
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first{
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        self.minTempLabel.text = "최저 :\(Int(weatherInformation.temp.minTemp - 273.15))°C"
        self.maxTempLabel.text = "최저 :\(Int(weatherInformation.temp.maxTemp - 273.15))°C"
        
    }

}

