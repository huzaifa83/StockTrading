import UIKit

struct Core {
    let today = DateUtil.getYesterdaysDate()
}

let core = Core()

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

        cell.layer.borderWidth = 1.5
        
        //Get data
        let stock = allStocks[indexPath.row]
        cell.stockDetails = stock
        cell.stockLogo.image = UIImage(named: stock.metaData.symbol)
        return cell
    }
    
    func getStockData() {
        for (stockSymbol, _) in self.companies {
            
            StockService.getStockData(symbol: stockSymbol, onSuccess: { (stockResult) in
            if let stock = stockResult {
                    self.allStocks.append(stock)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DetailStockViewController") as! DetailStockViewController
        destinationVC.stockName = allStocks[indexPath.row].metaData.symbol
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
    
        guard let openingPrice = stock.timeSeriesDaily[core.today]?.open else {return ""}
        return openingPrice
    }
    
    func getStockPrice(stock: Stock) -> String {
        guard let closingPrice = stock.timeSeriesDaily[core.today]?.close else {return ""}
        return closingPrice
    }
    
    func getStockVolume(stock: Stock) -> String {
        guard let volume = stock.timeSeriesDaily[core.today]?.volume else {return ""}
        return volume
    }
    
    func getStockHigh(stock: Stock) -> String {
        guard let high = stock.timeSeriesDaily[core.today]?.high else {return ""}
        return high
    }
    
    func getStockLow(stock: Stock) -> String {
        guard let low = stock.timeSeriesDaily[core.today]?.low else {return ""}
        return low
    }
}
