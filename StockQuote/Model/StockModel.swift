struct Stock: Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

struct MetaData: Codable {
    let info, symbol: String
    
    enum CodingKeys: String, CodingKey {
        case info = "1. Information"
        case symbol = "2. Symbol"
    }
}

struct TimeSeriesDaily: Codable {
    let open, high, low, close, volume: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}
