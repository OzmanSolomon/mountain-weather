//
//  APIManager.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation
import Alamofire

typealias apiSuccess = (_ data: Data?,_ errorString: String?,_ statusCode:Int?) -> ()
typealias apiFailure = (_ errorString: Error) -> ()
class ApiManager{
   
    let apiKey = EnvironmentManager().configuration(PlistKey.apiKey)
    func baseUrl() ->String {
        return "https://api.openweathermap.org/data/2.5/forecast?q=Dubai&mode=json&appid=\(self.apiKey)&units=metric"
    }
   
    func iconUrl(_ id:String) -> String?{
        return "http://openweathermap.org/img/wn/\(id)@2x.png"
    }
 
    
}
 

extension ApiManager{
    
    func fetchFilms(url:String, withSuccess success: @escaping apiSuccess, withapiFiluer failure: @escaping apiFailure) {
        AF.request(url)
            .responseData() { response in
                switch response.result {
                case .success(let value):
                    success(value, response.error?.localizedDescription, response.response?.statusCode)
                 case .failure(let error):
                    failure(error)
                  
                }
            }
      }
}
