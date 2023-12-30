//
//  CustomTabView.swift
//  TradingApp
//
//  Created by Стас Ильиных on 02.12.2023.
//

import Foundation
import SwiftUI

struct CustomTabView: View {
    var views: [TabBarItem]
    @Binding var selectedIndex: Int
    
    init(_ views: [TabBarItem], selectedIndex: Binding<Int>) {
        self.views = views
        self._selectedIndex = selectedIndex
    }

    var body: some View {
        ZStack {
            ForEach(self.views) { v in
                v.view
                    .opacity(self.selectedIndex == v.id ? 1 : 0)
            }
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    ZStack(alignment: .top) {
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 70 + geometry.safeAreaInsets.bottom)

                        HStack {
                            ForEach(self.views) { v in
                                Button(action: {
                                    self.selectedIndex = v.id
                                }) {
                                    VStack {
                                        v.image
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.top,10)
                                            .font(.title)
                                        
                                        Text(v.title)
                                            .foregroundColor(v.id == selectedIndex ? Color.appTheme.green : Color.appTheme.gray2)
                                            .font(Font.system(size: 12, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct TabBarItem: Identifiable {
    let id: Int
    var view: AnyView
    var image: Image
    var title: String

    init<V: View>(id: Int, view: V, image: Image, title: String) {
        self.id = id
        self.view = AnyView(view)
        self.image = image
        self.title = title
    }
}

