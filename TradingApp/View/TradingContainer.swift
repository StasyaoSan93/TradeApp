//
//  TradingContainer.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import SwiftUI

struct TradingContainer: View {
    
    @EnvironmentObject var mainVC: MainVM
    @State var tabSelection: Int = 1
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            CustomTabView([
                TabBarItem(
                    id: 0,
                    view: TradeView(),
                    image: tabSelection == 0 ? Image("tradeGreen", bundle: nil) : Image("tradeGray", bundle: nil),
                    title: "Trade"),
                TabBarItem(
                    id: 1,
                    view: TopUserView(),
                    image: tabSelection == 1 ? Image("topGreen", bundle: nil) : Image("topGray", bundle: nil),
                    title: "Top"),
                
            ], selectedIndex: $tabSelection)
        }
        .onAppear {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UserNotifications.UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        }
    }
}

#Preview {
    TradingContainer()
        .environmentObject(MainVM())
}

