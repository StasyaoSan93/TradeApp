//
//  TopUserView.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import SwiftUI

struct TopUserView: View {
    
    @EnvironmentObject var mainVM: MainVM
  
    var body: some View {
        ZStack {
            Color.appTheme.background.ignoresSafeArea()
            
            VStack {
                Text("TOP 10 Traders")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                VStack(spacing: 0) {
                    HStack {
                        Text("№")
                            .frame(width: 20)
                            .padding(.trailing, 12)
                        Text("Country")
                            .frame(width: 50, alignment: .leading)
                            .padding(.trailing, 18)
                        Text("Name")
                            .frame(width: 65, alignment: .leading)
                            Spacer()
                        Text("Deposit")
                            .frame(width: 65, alignment: .leading)
                            Spacer()
                        Text("Profit")
                            .frame(width: 65, alignment: .trailing)
                    }
                    .font(.system(size: 12))
                    .foregroundColor(Color.appTheme.gray3)
                    .padding(12)
                    
                    ForEach(mainVM.topTraders) { trader in
                        HStack {
                            Text("\(trader.id)")
                                .frame(width: 20)
                                .padding(.trailing, 20)
                            Image(trader.countyCode, bundle: nil)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .padding(.trailing, 35)
                            Text(trader.name)
                                .frame(width: 65, alignment: .leading)
                            
                            Spacer()
                            
                            Text("$\(trader.deposit)")
                                .frame(width: 65, alignment: .leading)
                                
                            Spacer()
                            
                            Text("$\(trader.profit)")
                                .foregroundStyle(Color.appTheme.green)
                                .frame(width: 65, alignment: .trailing)
                        }
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                        .padding(12)
                        .background(trader.id % 2 == 0 ? Color.appTheme.gray4 : Color.appTheme.background)
                    }
                }
                .background(Color.appTheme.gray4)
                .cornerRadius(10)
                .padding(.horizontal, 12)
                
                Spacer()
            }
        }
        .onAppear {
            mainVM.topTraderInfoTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let topTraderId = Int.random(in: 0..<10)
                let topTraderPlus = Int.random(in: 50...150)
                mainVM.topTraders[topTraderId] = mainVM.topTraders[topTraderId].plus(change: topTraderPlus)
            }
        }
    }
}

#Preview {
    TopUserView()
        .environmentObject(MainVM())
}
