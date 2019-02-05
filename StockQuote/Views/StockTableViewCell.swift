//
//  StockTableViewCell.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 27/1/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var stockLogo: UIImageView!
    @IBOutlet weak var stockClose: UILabel!
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockVolume: UILabel!
    
    var stockDetails: Stock? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews() {
        guard let stockDetail = stockDetails else {return}
        self.stockName.text = stockDetail.metaData.symbol
        self.stockVolume.text = getStockVolume(stock: stockDetail)
        self.stockClose.text = getStockPrice(stock: stockDetail)
    }
    
    func getStockPrice(stock: Stock) -> String {
        guard let closingPrice = stock.timeSeriesDaily[core.today]?.close else {return ""}
        return closingPrice
    }
    
    func getStockVolume(stock: Stock) -> String {
        guard let volume = stock.timeSeriesDaily[core.today]?.volume else {return ""}
        return volume
    }
}
