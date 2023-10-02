//
//  TabView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//

import SwiftUI

struct MainTabView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false

    var body: some View {
        
        

        TabView{
            
            HomeView()
                .tabItem{
                    VStack{
                        Image(systemName: "menucard")
                        Text("Home")
                    }
                    .onAppear() {
                        UITableView.appearance().backgroundColor = .yellow
                    }
                }
            
            ExploreView()
                .tabItem{
                    VStack{
                        Image(systemName: "info.circle")
                        Text("Explore")
                    }
                }
                .onAppear() {
                    UITableView.appearance().backgroundColor = .yellow
                }
                .tint(.blue)
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = .yellow
        }
    }
}

#Preview {
    MainTabView()
}
