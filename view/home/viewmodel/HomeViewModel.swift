//
//  HomeViewModel.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import Foundation
import RxSwift
protocol HomeViewModel {
    var rates: PublishSubject<Dictionary<String,String>> { get }
    var lastUpdate: PublishSubject<String> { get }
    
    func loadLatest(base: String)

}
