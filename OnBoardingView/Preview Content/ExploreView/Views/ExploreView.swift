//
//  LevelView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//

import SwiftUI

struct ExploreView: View {
    
    @State var levels = [Level]()
    var dataService = JSONdecoder()
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                VStack {
                    HStack{
                        Text("Explore")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    
                    ForEach(levels) { level in
                        
                        NavigationLink {
                            SubjectView(level: level)
                        } label: {
                            ExploreCard(level: level)

                        }
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .onAppear {
            levels = dataService.loadSubjects()
        }
    }
}

#Preview {
    ExploreView()
}
