import Foundation

protocol CoinManagerDelegate {
    func didUpdateExchangeRate(_ exchangeRate: CoinExchangeRate)
}

struct CoinManager {
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?

    func fetchExchangeRate(fromBitcoinTo currency: String) {
        self.performRequest(from: "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=3C4B60FB-12DD-4580-9CA4-CA1AC43AB2D8")
    }
    
    func performRequest(from urlString: String ) {
        // Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            //Give the URLSession a task
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            //Start the task
            task.resume()
            
        }
    }
    
    func handler (data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print("The error is: \(error)")
            return
        }
        if let safeData = data {
            if let exchangeRate = self.parseJSON(from: safeData) {
                delegate?.didUpdateExchangeRate(exchangeRate)
            }
        }
    }
    
    func parseJSON(from data: Data) -> CoinExchangeRate? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinExchangeRate.self, from: data)
            return decodedData
        } catch {
            print("The error is: \(error)")
            return nil
        }
    }
    
}
