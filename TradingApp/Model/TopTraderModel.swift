//
//  TopTraderModel.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import Foundation

struct TopTraderModel: Identifiable, Hashable {
    let id: Int
    let countyCode: String
    let name: String
    let deposit: Int
    let profit: Int
    
    func plus(change: Int) -> TopTraderModel {
        return TopTraderModel(id: self.id, countyCode: self.countyCode, name: self.name, deposit: self.deposit + change, profit: self.profit + change)
    }
}
