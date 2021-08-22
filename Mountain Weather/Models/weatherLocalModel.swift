//
//  weatherLocalModel.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import RealmSwift
class weatherLocalModel: Object {
    @Persisted var id = UUID()
    @Persisted var day: String?
    @Persisted var detail:DetailsLocalModel?
    @Persisted var image: String?
}

