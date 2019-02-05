//
//  BaseTestSpec.swift
//  StockQuoteTests
//
//  Created by Huzaifa Gadiwala on 4/2/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

@testable import StockQuote

class StockQuoteNetworkAPITest: QuickSpec  {
    
    override func spec() {
        super.spec()
        describe("StockService Tests") {
            
            context("Success") {
                it("returns success for stock prices ") {
                    var returnedData: Stock?
                    let path = Bundle(for: type(of: self)).path(forResource: "StockResults", ofType: "json")!
                    
                    let data = NSData(contentsOfFile: path)!
                    
                    self.stub(uri("https://www.alphavantage.co/query?symbol=GOOG&function=TIME_SERIES_DAILY&apikey=O3RD70ZFTWGWD91F"), jsonData(data as Data))
                    
                    StockService.getStockData(symbol: "GOOG", onSuccess: { stockResult in
                        returnedData = stockResult
                    })
                    expect(returnedData).toEventuallyNot(beNil())
                    expect(returnedData?.metaData.symbol) == "GOOG"
                    expect(returnedData?.timeSeriesDaily["2019-02-04"]?.high) == "1132.8000"
                }
            }
        }
    }
}
