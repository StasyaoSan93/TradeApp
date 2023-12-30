//
//  CurrencyPairList.swift
//  TradingApp
//
//  Created by Стас Ильиных on 22.10.2023.
//

import SwiftUI

struct CurrencyPairList: View {
    
    @EnvironmentObject var mainVM: MainVM
    @Environment(\.presentationMode) var presentationMode
    private var columns: [GridItem] = [
            GridItem(.flexible(minimum: 50, maximum: 160), spacing: 16),
            GridItem(.flexible(minimum: 50, maximum: 160), spacing: 16),
        ]
    
    var body: some View {
        ZStack {
            Color.appTheme.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.white)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    Spacer()
                    
                    Text("Currency pair")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 22))
                        .opacity(0.0)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
                
                LazyVGrid(columns: columns) {
                    ForEach(mainVM.currencyList, id: \.self) { currency in
                        VStack(spacing: 3) {
                            Text(currency.name)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 152, height: 54)
                        .background(Color.appTheme.fieldBackground)
                        .cornerRadius(12)
                        .onTapGesture {
                            mainVM.webUrl = WebViewModel(url: currency.url)
                            mainVM.currencyName = currency.name
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CurrencyPairList()
        .environmentObject(MainVM())
}
