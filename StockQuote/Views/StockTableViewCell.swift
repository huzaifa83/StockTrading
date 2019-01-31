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
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockVolume: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    @IBOutlet weak var stockLogo: UIImageView!
    
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
        self.stockName.text = stockDetail.metaData.the2Symbol
        self.stockVolume.text = getStockVolume(stock: stockDetail)
        self.stockClose.text = getStockPrice(stock: stockDetail)
    }
    
    func getStockPrice(stock: Stock) -> String {
        guard let closingPrice = stock.timeSeriesDaily["2019-01-25"]?.the4Close else {return ""}
        return closingPrice
    }
    
    func getStockVolume(stock: Stock) -> String {
        guard let volume = stock.timeSeriesDaily["2019-01-25"]?.the5Volume else {return ""}
        return volume
    }
}
