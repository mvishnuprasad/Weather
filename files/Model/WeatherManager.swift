//
//  WeatherManager.swift
//  Weather
//
//  Created by VISHNU PRASAD M on 11/06/22.
//

import Foundation

struct WeatherManager {
  
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=40ca58efce193db0fc801564afb08283"
    var delegate : WeatherManagerDelegate?
  
    func fetchWeather(cityName: String){
        let url = "\(weatherURL)&q=\(cityName)"
        performURLRequest(with: url)
    }
    func performURLRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {(data,response,error) -> Void in
                
                if(error != nil){
                    if let err = error{
                        print(err)
                    }
                }
                else{
                    if let dataReceived = data{
                        if let weather = parseJSONData(weatherData: dataReceived){
                            delegate?.getLatestWeather(weather: weather)
                        }
                        
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSONData(weatherData : Data) -> WeatherData?{
        let decoder = JSONDecoder()
        do {
            let result =  try decoder.decode(WeatherDataModel.self, from: weatherData)
            let weatherData = WeatherData(temperature: result.main.temp, description: result.weather[0].description,  pressure: result.main.pressure, humidity: result.main.humidity)
            debugPrint(result)
            return weatherData
        } catch let error{
            debugPrint("error \(error) occured")
            return nil
        }
    }
}
