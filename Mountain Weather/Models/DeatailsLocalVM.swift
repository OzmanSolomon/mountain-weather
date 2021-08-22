//
//  DeatailsLocalVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import RealmSwift

class DetailsLocalModel: Object {
    @Persisted var temp: String
    @Persisted var windSpeed  : String?
    @Persisted var windDeg   : String?
    @Persisted var tempMin  : String?
    @Persisted var tempMax  : String?
    @Persisted var pressure  : String?
    @Persisted var howItFeel  : String?
    @Persisted var weatherDescription  : String?
    @Persisted var city  : String?
}
