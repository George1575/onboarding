//
//  ProfileView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    //app storage - should now have values
    @AppStorage("name") var currentUserEducation: String?
    @AppStorage("age") var currentUserInterestedEducation: Int?
    @AppStorage("gender") var currentUserInterestedSubject: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        
        VStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(currentUserEducation ?? "Your current education level is here")
            Text("This user is \(currentUserInterestedEducation ?? 0)")
            Text("Their gender is \(currentUserInterestedSubject ?? "Unknown")")
            
            
            Text("Sign Out")
                .onTapGesture {
                    signOut()
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

#Preview {
    HomeView()
}
