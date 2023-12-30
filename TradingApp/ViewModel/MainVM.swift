//
//  MainVM.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import Foundation

class MainVM: ObservableObject {
    @Published var loadingTimer: Timer? = nil
    
    @Published var topTraderInfoTimer: Timer? = nil
    
    @Published var topTraders: [TopTraderModel] = [
        TopTraderModel(id: 1, countyCode: "USA", name: "Oliver", deposit: 2367, profit: 336755),
        TopTraderModel(id: 2, countyCode: "CAN", name: "Jack", deposit: 1175, profit: 148389),
        TopTraderModel(id: 3, countyCode: "BRZ", name: "Harry", deposit: 1000, profit: 113888),
        TopTraderModel(id: 4, countyCode: "SKR", name: "Jacob", deposit: 999, profit: 36755),
        TopTraderModel(id: 5, countyCode: "GER", name: "Charley", deposit: 888, profit: 18389),
        TopTraderModel(id: 6, countyCode: "BRZ", name: "Thomas", deposit: 777, profit: 16086),
        TopTraderModel(id: 7, countyCode: "FRA", name: "George", deposit: 666, profit: 13064),
        TopTraderModel(id: 8, countyCode: "NZL", name: "Oscar", deposit: 555, profit: 9988),
        TopTraderModel(id: 9, countyCode: "IND", name: "James", deposit: 444, profit: 4765),
        TopTraderModel(id: 10, countyCode: "SPN", name: "William", deposit: 333, profit: 1000),
    ]
    
    @Published var webUrl = WebViewModel(url: "https://www.tradingview.com/chart/?symbol=FX%3AEURUSD")
    @Published var currencyName = "EUR/USD"
    
    @Published var currencyList: [CurrencyPairModel] = [
        CurrencyPairModel(name: "EUR/USD", url: "https://www.tradingview.com/chart/?symbol=FX%3AEURUSD"),
        CurrencyPairModel(name: "GBP/USD", url: "https://www.tradingview.com/chart/?symbol=OANDA%3AGBPUSD"),
    ]
    
    @Published var webView: WebView? = nil
}
