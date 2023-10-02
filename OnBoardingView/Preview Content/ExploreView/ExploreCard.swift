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

struct SubjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCard(level: Level(name: "Apprenticeships", summary: "Truro and Penwith College offers quality apprenticeship programmes in 30 exciting job roles in partnership with Cornwall's top employers. Our continually expanding range of training is designed in partnership with employers to address the skills needed and career routes available at local businesses.", imageName: "apprenticeships", subjects: [Subject]()))
    }
}
