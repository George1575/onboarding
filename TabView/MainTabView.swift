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

        TabView {
            
            HomeView()
                .tabItem{
                    VStack{
                        Image(systemName: "menucard")
                        Text("Home")
                    }
                }
                .foregroundColor(.black)
                .background(.mint.opacity(0.8))
                
                            
            ExploreView()
                .tabItem{
                    VStack{
                        Image(systemName: "info.circle")
                        Text("Explore")
                            
                    }
                }
                .background(.mint.opacity(0.8))
        }
        .accentColor(.black)
        }
    }

#Preview {
    MainTabView()
}
