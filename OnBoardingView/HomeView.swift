//
//  ProfileView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    //app storage - should now have values
    @AppStorage("education") var currentUserEducation: String?
    @AppStorage("interestedEducation") var currentUserInterestedEducation: String?
    @AppStorage("subject") var currentUserInterestedSubject: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
  //  let subject: Subject
    
    var body: some View {
        ZStack{
            
            Color(.mint)
                .ignoresSafeArea()
            
            Spacer()
     
        VStack{
            
            Spacer()
            Image(systemName: "house.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            Text("Showing you results for \(currentUserInterestedEducation ?? "Unknown") \(currentUserInterestedSubject ?? "Unknown")")
                .font(.headline)
            
            //Text(currentUserInterestedSubject.details)
                        
            Spacer()
            
            Text("Sign Out")
                .onTapGesture {
                    signOut()
                }
        }
    }
}
    
    func signOut() {
        currentUserInterestedEducation = nil
        currentUserEducation = nil
        currentUserInterestedSubject = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false

        }
    }
}


