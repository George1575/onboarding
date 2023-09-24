//
//  IntroView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI

struct IntroView: View {
    
    //app storage says that if there is a user signed in, it will be true.
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {

        ZStack{
            //background
            Color(.mint)
                .ignoresSafeArea()
            
            //if user is signed in
            //show homescreen
            //else 
            //onboarding view
            
            if currentUserSignedIn {
                HomeView()
            }
            else {
                OnboardingView()
            }
        }
        
        
    }
}

#Preview {
    IntroView()
}
