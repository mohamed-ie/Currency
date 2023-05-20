//
//  HomeViewModel.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import Foundation
import RxSwift

class HomeViewModelImpl : HomeViewModel {
    let rates: PublishSubject<Dictionary<String, String>> = PublishSubject.Observer()
    let lastUpdate: PublishSubject<String> = PublishSubject.Observer()
    
    private let diposableBag = DisposeBag()
    private lazy var calendar = Calendar.current
    
    private let webservice : ExchangeRatesWebservice!
    
    init(webservice: ExchangeRatesWebservice!) {
        self.webservice = webservice
    }
    
    func loadLatest(base: String){
        webservice.loadLatest(base: base)
            .subscribe(onSuccess:{[weak self] latest in
                guard let latest = latest else { return }
                self?.updateRates(rates: latest.rates)
                self?.updateLastUpdate()
            }).disposed(by: diposableBag)
    }
    
    private func updateRates(rates:Dictionary<String,Double>){
        let rates = rates.mapValues({ value in
            return String(format: "%.2f", value)
        })
        self.rates.onNext(rates)
    }
    
    private func updateLastUpdate(){
        let date = Date()
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        lastUpdate.onNext("\(hour):\(minutes):\(seconds)")
    }
    
}
