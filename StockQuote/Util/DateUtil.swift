import Foundation

class DateUtil {
    
    static func getYesterdaysDate() -> String {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formater = DateFormatter()
        //example: 2019-01-25
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: date)
    }
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
}
