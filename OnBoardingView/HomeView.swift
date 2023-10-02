//
//  ProfileView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI
struct HomeView: View {
    
    @AppStorage("education") var currentUserEducation: String?
    @AppStorage("interestedEducation") var currentUserInterestedEducation: String?
    @AppStorage("subject") var currentUserInterestedSubject: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    @EnvironmentObject var dataService: JSONdecoder
    
    @State private var subjectDetails: String = ""
    @State private var subjects: [Subject] = []
    
    @State private var selectedImageName: String?
    
    var body: some View {
        
        ZStack{
            Color(.systemMint)
//                .ignoresSafeArea()

            VStack{
                Image(systemName: "house.fill")
                
                Text("Showing you results for \(currentUserInterestedEducation ?? "Unknown") \(currentUserInterestedSubject ?? "Unknown")")
                    .font(.headline)
                
                Image(uiImage: imageForSelection())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: .fill)
                
                Text(subjectDetails) // Display the subject details here
                    .padding()
                Spacer()
                Text("Sign Out")
                    .onTapGesture {
                        signOut()
                    }
            }
            //            .onAppear(perform: dataService.loadSubjects())
        }
        .onAppear {
            // Fetch the details of the selected subject when the view appears
            loadSubjectDetails()
        }
    }
        
        func loadSubjectDetails() {
            if let url = Bundle.main.url(forResource: "subjects", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    subjects = try JSONDecoder().decode([Subject].self, from: data)
                    
                    // Find the details of the selected subject
                    if let subjectName = currentUserInterestedSubject,
                       let subject = subjects.first(where: { $0.name == subjectName }) {
                        subjectDetails = subject.details
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Cannot find subjects.json")
            }
        }
        
        
        func imageForSelection() -> UIImage {
            // Determine the image name based on the user's selections
            var imageName = ""
            
            if let education = currentUserInterestedEducation, let subject = currentUserInterestedSubject {
                imageName = "\(subject)"
            }
            
            // Return the appropriate image, or a default image if none matches
            return UIImage(named: imageName) ?? UIImage(named: "defaultImage")!
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

