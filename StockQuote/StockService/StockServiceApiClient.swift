//
//  StockServiceApiClient.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 4/2/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import Foundation

typealias StockDataCallback = (Stock?) -> Void
typealias ErrorCallback = (Error?) -> Void

protocol StockServiceApiClient {
    static func getStockData(symbol: String, onError: ErrorCallback?, onSuccess: @escaping StockDataCallback)
}
