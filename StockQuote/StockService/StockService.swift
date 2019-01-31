//
//  StickService.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 27/1/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import Foundation

class StockService {
    
    private static let baseURL = URL(string: "https://www.alphavantage.co/query")
    private static let jsonDecoder = JSONDecoder()
    
    static func getStockData(symbol: String, completion: @escaping ((Stock?) -> Void)) {
        
        guard let url = baseURL else {completion(nil); return}
        guard let request = getPopulatedURLRequest(url: url, symbol: symbol) else {completion(nil); return}
        
        //Call the API
        URLSession.shared.dataTask(with: request) { (data,_,error) in
            //Handle response
            if let error = error  {
                print("Error calling API: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let responseData = data else {completion(nil); return }
            do {
                let stockInfo = try jsonDecoder.decode(Stock.self, from: responseData)
                print("stocks: \(stockInfo.metaData.the2Symbol)")
                completion(stockInfo)
                return
            } catch {
                print("Error decoding data \(error)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    static func getPopulatedURLRequest(url: URL, symbol: String) -> URLRequest?{
        let symbolQueryParam = URLQueryItem.init(name: "symbol", value: symbol)
        let functionQueryParam = URLQueryItem.init(name: "function", value: "TIME_SERIES_DAILY")
        let apiKeyQueryParam = URLQueryItem.init(name: "apikey", value: "O3RD70ZFTWGWD91F")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [symbolQueryParam, functionQueryParam, apiKeyQueryParam]
    
        guard let fullConsolidatedURL = components?.url else {return nil}
        print(fullConsolidatedURL)
        var request = URLRequest(url: fullConsolidatedURL)
        request.httpMethod = "GET"
        return request
    }
    
    
}
