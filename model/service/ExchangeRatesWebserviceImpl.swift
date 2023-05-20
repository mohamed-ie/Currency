//
//  ExchangeRatesWebservice.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import Foundation
import RxSwift

class ExchangeRatesWebserviceImpl : ExchangeRatesWebservice {
    
    func loadLatest(base: String) -> Single<Latest?> {
        return Single<Latest?>.create {[weak self] emitter in
            guard let self = self else {
                emitter(SingleEvent.success(nil))
                return Disposables.create()
            }
    
            var url = "https://api.apilayer.com/exchangerates_data/latest"
            url.append("?base=\(base)")
//            url.append("&symbols=GBP,JPY,USD")
            
            guard let url = URL(string: url) else {
                emitter(SingleEvent.success(nil))
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("7UOin90iTQKAvDUYcVSoGj8DNSBGFisZ", forHTTPHeaderField: "apikey")
            
            self.startTask(request: request) { (dto : Latest?) in
                emitter(SingleEvent.success(dto))
            }
            
            return Disposables.create()

        }
    }
    
    private func startTask <T : Decodable> (
        request : URLRequest,
        onComplete : @escaping (T?) ->Void
    ){
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            var dto : T? = nil
            do{
                guard let data = data else {return}
                dto = try JSONDecoder().decode(T.self, from: data)
            }catch let error {
                print(error)
            }
            onComplete(dto)
        }.resume()
    }
}
