//
//  LatestDto.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import Foundation
struct Latest : Decodable {
    let base : String
    let rates : Dictionary<String,Double>
}
