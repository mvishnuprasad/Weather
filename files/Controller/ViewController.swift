//
//  ViewController.swift
//  Weather
//
//  Created by VISHNU PRASAD M on 11/06/22.
//

import UIKit
protocol WeatherManagerDelegate {
    func getLatestWeather(weather : WeatherData)
}
class ViewController: UIViewController, WeatherManagerDelegate {
    var weathermanager = WeatherManager()
    @IBOutlet weak var weatherImage : UIImageView!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var searchTextField : UITextField!
    @IBAction func searchButton(_ sender: UIButton) {

        searchTextField.endEditing(true)
    }
    @IBAction func locationButton(_ sender: UIButton){
        
    }
    @IBAction func detailsButton (_ sender : UIButton){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.cyan
        weathermanager.delegate = self
        searchTextField.delegate = self
    }
    func getLatestWeather(weather: WeatherData) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.temperature)"
            if let city = self.searchTextField.text{
                self.descriptionLabel.text = " its \(weather.description) in \(city)"
            }
            
        }
    }
 
}

extension ViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Tells the Delegate that editing ended for textfield
        if let city = searchTextField.text{
            weathermanager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Returns the first Responder/ textfield should process return button on keyboard
        searchTextField.endEditing(true)
        if let city = searchTextField.text{
            weathermanager.fetchWeather(cityName: city)
        }
        return true
        
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Method to ask if editing should stop in textfield also for validations
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder = "Search"
            return false
        }
    }
    

}
