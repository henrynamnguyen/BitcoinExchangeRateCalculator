import Foundation

struct CoinExchangeRate: Decodable {
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
}
