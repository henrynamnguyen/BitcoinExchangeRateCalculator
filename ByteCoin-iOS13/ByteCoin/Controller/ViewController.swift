import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }

}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,
                    inComponent component: Int) {
        let chosenCurrency = currencyArray[row]
        currencyLabel.text = chosenCurrency
        coinManager.fetchExchangeRate(fromBitcoinTo: chosenCurrency)
    }
    
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRate: CoinExchangeRate) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", exchangeRate.rate)
        }
    }
    
}
