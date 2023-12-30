//
//  ContentView.swift
//  TradingApp
//
//  Created by Стас Ильиных on 19.10.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainVM = MainVM()
    @State var preloaderProcent: Int = 0
    @State var preloaderWidth: CGFloat = 0
    
    var body: some View {
        ZStack {
            if (preloaderProcent < 100) {
                preloaderBackground
                
                preloaderStatusLine
            } else {
                TradingContainer()
            }
        }
        .environmentObject(mainVM)
        .onAppear {
            mainVM.loadingTimer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
                withAnimation(.default) {
                    if preloaderProcent < 100 {
                        preloaderProcent += 1
                        preloaderWidth = CGFloat(preloaderProcent*3)
                    } else {
                        if mainVM.loadingTimer != nil {
                            mainVM.loadingTimer?.invalidate()
                            mainVM.loadingTimer = nil
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}

extension MainView {
    private var preloaderBackground: some View {
        ZStack {
            Color.appTheme.background.ignoresSafeArea()
            
            Circle()
                .fill(Color.appTheme.green)
                .frame(width: 123, height: 123)
                .blur(radius: 80)
                .offset(x: 100, y: -150)
            
            Circle()
                .fill(Color.appTheme.red)
                .frame(width: 123, height: 123)
                .blur(radius: 80)
                .offset(x: -100, y: 150)
        }
    }
    
    private var preloaderStatusLine: some View {
        ZStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.appTheme.gray)
                    .frame(width: 300, height: 24)
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.appTheme.green)
                    .frame(width: preloaderWidth, height: 24)
            }
            
            Text("\(preloaderProcent)%")
                .foregroundStyle(Color.white)
                .fontWeight(.bold)
                .font(.system(size: 16))
        }
    }
}
