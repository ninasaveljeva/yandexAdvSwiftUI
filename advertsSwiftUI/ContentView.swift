//
//  ContentView.swift
//  advertsSwiftUI
//
//  Created by Nina Saveljeva on 10/7/2024.
//

import SwiftUI


struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Button("Show View Created via UIKit") {
                    isPresented = true
                }
                .sheet(isPresented: $isPresented) {
                    MyView()
                        .ignoresSafeArea()
                }
                
                Text("Yandex Adverts List:")
                ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], id: \.self) { gif in
                    VStack {
                        Text(gif.description)
                        AdvertView()
                            .frame(height: 80)
                    }
                }
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
