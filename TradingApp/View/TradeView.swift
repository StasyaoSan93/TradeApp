//
//  TradeView.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import SwiftUI
import WebKit

struct TradeView: View {
    
    @EnvironmentObject var mainVM: MainVM
    @State var minuteField: Int = 0
    @State var secondField: Int = 0
    @State var investmentField: Double = 1000
    @State var balanceField: Double = 10000
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appTheme.background.ignoresSafeArea()
                
                VStack {
                    Text("Trade")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 3) {
                        Text("Balance")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTheme.gray5)
                        
                        Text("\(Int(balanceField))$")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 315, height: 54)
                    .background(Color.appTheme.fieldBackground)
                    .cornerRadius(12)
                    
                    if mainVM.webView != nil {
                        mainVM.webView
                            .frame(height: 300)
                    }

                    NavigationLink {
                        CurrencyPairList()
                    } label: {
                        HStack(spacing: 3) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16))
                                .opacity(0.0)
                            
                            Spacer()
                            
                            Text(mainVM.currencyName)
                                .font(.system(size: 16))
                                .foregroundStyle(Color.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.white)
                        }
                        .padding(.horizontal, 8)
                        .frame(width: 315, height: 54)
                        .background(Color.appTheme.fieldBackground)
                        .cornerRadius(12)
                    }

                    tradeViewNumbers
                    
                    tradViewbuttons

                    Spacer()
                }
            }
            .onReceive(mainVM.$webUrl, perform: { webUrl in
                mainVM.webView = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    mainVM.webView = WebView(viewModel: webUrl)
                }
            })
        }
    }
}

#Preview {
    TradeView()
        .environmentObject(MainVM())
}

extension TradeView {
    
    private var tradeViewNumbers: some View {
        HStack {
            VStack(spacing: 3) {
                Text("Timer")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.appTheme.gray5)
                
                HStack {
                    Image(systemName: "minus.circle")
                        .onTapGesture {
                            if secondField > 0 {
                                secondField -= 1
                            } else if secondField == 0 {
                                secondField = 0
                                minuteField -= 1
                            }
                        }
                    
                    Spacer()
                    
                    Text("\(minuteField):\(secondField)")
                    
                    Spacer()
                    
                    Image(systemName: "plus.circle")
                        .onTapGesture {
                            if secondField < 60 {
                                secondField += 1
                            } else if secondField == 60 {
                                secondField = 0
                                minuteField += 1
                            }
                        }
                }
                .font(.system(size: 16))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 8)
            }
            .frame(width: 152, height: 54)
            .background(Color.appTheme.fieldBackground)
            .cornerRadius(12)
            
            VStack(spacing: 3) {
                Text("Investment")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.appTheme.gray5)
                
                HStack {
                    Image(systemName: "minus.circle")
                        .onTapGesture {
                            if investmentField > 0 {
                                investmentField -= 100
                            }
                        }
                    
                    Spacer()
                    
                    Text("\(Int(investmentField))")
                    
                    Spacer()
                    
                    Image(systemName: "plus.circle")
                        .onTapGesture {
                            if investmentField < balanceField {
                                investmentField += 100
                            }
                        }
                }
                .font(.system(size: 16))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 8)
            }
            .frame(width: 152, height: 54)
            .background(Color.appTheme.fieldBackground)
            .cornerRadius(12)
        }
    }
    
    private var tradViewbuttons: some View {
        HStack {
            Button(action: {
                balanceField = balanceField + investmentField
            }, label: {
                HStack {
                    Text("Sell")
                    Spacer()
                }
                .padding(.leading, 16)
            })
            .frame(width: 152, height: 54)
            .background(Color.appTheme.red)
            .foregroundColor(Color.white)
            .font(.system(size: 24))
            .cornerRadius(12)
            
            Button(action: {
                if balanceField >= investmentField {
                    balanceField = balanceField - investmentField
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let chance = Bool.random()
                    if chance {
                        balanceField = balanceField + investmentField * 1.7
                    }
                }
            }, label: {
                HStack {
                    Text("Buy")
                    Spacer()
                }
                .padding(.leading, 16)
            })
            .frame(width: 152, height: 54)
            .background(Color.appTheme.green)
            .foregroundColor(Color.white)
            .font(.system(size: 24))
            .cornerRadius(12)
        }
    }
    
}

