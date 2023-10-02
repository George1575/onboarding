//
//  ExploreRow.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//

import SwiftUI

struct ExploreRow: View {
   
    var subject: Subject
    
    var body: some View {
        
        VStack{
            
            Image(subject.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .cornerRadius(15)
            
            Text(subject.name)
                .bold()
                .font(.largeTitle)
                
            
            Text(subject.details)
                .multilineTextAlignment(.leading)
            
            
        }
        .padding(10)
    }
}


