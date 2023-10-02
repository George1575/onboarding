//
//  ExploreCard.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 02/10/2023.
//

import SwiftUI

struct ExploreCard: View {
    
    var level: Level
    
    var body: some View {

            ZStack{
                
                Rectangle()
                    .background(content: {
                        Image(level.imageName)
                            .resizable()
                            .cornerRadius(15)
                            .aspectRatio(contentMode: .fill)
                    })
                    .foregroundColor(.clear)
                    .cornerRadius(15)
                    
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .cornerRadius(15)
                
                VStack (alignment: .leading) {
                    Text(level.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    
                }
                .padding()
                .foregroundColor(.white)
            }
            .frame(height: 100)

        
        }
}


