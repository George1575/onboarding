//
//  DetailView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//


import SwiftUI

struct DetailView: View {
    
    var subject: Subject
    var dataService = JSONdecoder()
    
    var body: some View {
        
        VStack {
            
            Image(subject.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(15)
            
            ScrollView {
    //            Image(subject.imageName)
    //                .resizable()
                Text(subject.name)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text(subject.details)
                    .padding(30)
            }

        }
        
        
    }
}
