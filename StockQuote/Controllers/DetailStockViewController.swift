//
//  DetailStockViewController.swift
//  StockQuote
//
//  Created by Huzaifa Gadiwala on 27/1/19.
//  Copyright © 2019 Huzaifa Gadiwala. All rights reserved.
//

import UIKit

class DetailStockViewController: UIViewController {

    //Properties
    var stockName = String()
    var stockOpen = String()
    var stockHigh = String()
    var stockLow = String()
    var stockClose = String()
    var stockVolume = String()
    var stockImage = UIImage()
    
    // Outlets
  //  @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var close: UILabel!
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
//        detailScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        name.text = stockName
        open.text = stockOpen
        close.text = stockClose
        low.text = stockLow
        high.text = stockHigh
        volume.text = stockVolume
        image.image = stockImage
    }
}
