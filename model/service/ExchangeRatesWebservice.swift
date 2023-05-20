//
//  ExchangeRatesWebservice.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import Foundation
import RxSwift

protocol ExchangeRatesWebservice{
    func loadLatest(base: String) -> Single<Latest?>
}
