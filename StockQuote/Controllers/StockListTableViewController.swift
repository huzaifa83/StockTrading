//
//  StockListTableViewController.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 27/1/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import UIKit

class StockListTableViewController: UITableViewController {

    private let companies = ["AAPL" : "Apple Inc", "GOOG" : "Google Inc", "AMZN" : "Amazon.com, Inc", "FB" : "Facebook Inc", "MSFT": "Microsoft Inc"]
    
    var allStocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStocks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        //Set UI properties
//        cell.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        cell.layer.borderWidth = 1.5
        
        //Get data
        let stock = allStocks[indexPath.row]
        cell.stockDetails = stock
        cell.stockLogo.image = UIImage(named: stock.metaData.the2Symbol)
        return cell
    }
    
    func getStockData() {
            for (stockSymbol, _) in self.companies {
                StockService.getStockData(symbol: stockSymbol) { (stockResult) in
                if let stock = stockResult {
                        self.allStocks.append(stock)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
//            print("******************")
//            print(self.allStocks.count)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DetailStockViewController") as! DetailStockViewController
        destinationVC.stockName = allStocks[indexPath.row].metaData.the2Symbol
         let stockDetail = allStocks[indexPath.row]
        destinationVC.stockVolume = getStockVolume(stock: stockDetail)
        destinationVC.stockOpen = getStockOpen(stock: stockDetail)
        destinationVC.stockClose = getStockPrice(stock: stockDetail)
        destinationVC.stockHigh = getStockHigh(stock: stockDetail)
        destinationVC.stockLow = getStockLow(stock: stockDetail)
        destinationVC.stockImage = UIImage(named: destinationVC.stockName) ?? UIImage()
     self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func getStockOpen(stock: Stock) -> String {
        guard let openingPrice = stock.timeSeriesDaily["2019-01-25"]?.the1Open else {return ""}
        return openingPrice
    }
    
    func getStockPrice(stock: Stock) -> String {
        guard let closingPrice = stock.timeSeriesDaily["2019-01-25"]?.the4Close else {return ""}
        return closingPrice
    }
    
    func getStockVolume(stock: Stock) -> String {
        guard let volume = stock.timeSeriesDaily["2019-01-25"]?.the5Volume else {return ""}
        return volume
    }
    
    func getStockHigh(stock: Stock) -> String {
        guard let high = stock.timeSeriesDaily["2019-01-25"]?.the2High else {return ""}
        return high
    }
    
    func getStockLow(stock: Stock) -> String {
        guard let low = stock.timeSeriesDaily["2019-01-25"]?.the3Low else {return ""}
        return low
    }
}
