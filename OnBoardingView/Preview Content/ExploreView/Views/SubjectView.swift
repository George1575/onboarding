//
//  SubjectView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//

import SwiftUI

struct SubjectView: View {
    
    @State var subjects = [Subject]()
    var dataService = JSONdecoder()
    var level: Level
    
    var body: some View {
        
            ScrollView {
                
                VStack {
                    
                    ForEach(level.subjects) { subject in
                        
                        NavigationLink {
                            DetailView(subject: subject)
                        } label: {
                            ExploreRow(subject: subject)
                                .padding(.bottom, 50)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
    }
