//
//  StickService.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 27/1/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import Foundation

class StockService: StockServiceApiClient {
    
    static let baseURL = URL(string: "https://www.alphavantage.co/query")
    private static let jsonDecoder = JSONDecoder()
    
    static func getStockData(symbol: String, onError: ErrorCallback? = nil, onSuccess: @escaping StockDataCallback) {
        
        guard let url = baseURL else {onSuccess(nil); return}
        guard let request = getPopulatedURLRequest(url: url, symbol: symbol) else {onSuccess(nil); return}
        
        let urlSession = URLSession.shared
        
        //Call the API
        urlSession.dataTask(with: request) { (data, response, error) in
            //Handle response
            if let error = error  {
                print("Error for Stock Data for symbol : \(symbol)")
                onError?(error)
                return
            }
            guard let responseData = data else {onSuccess(nil); return }
            do {
                let stockInfo = try jsonDecoder.decode(Stock.self, from: responseData)
                onSuccess(stockInfo)
                return
            } catch {
                print("Error decoding data \(error)")
                onSuccess(nil)
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
        print("fullConsolidatedURL: \(fullConsolidatedURL)")
        var request = URLRequest(url: fullConsolidatedURL)
        request.httpMethod = "GET"
        return request
    }
}
