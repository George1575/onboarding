//
//  OnboardingView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI
import Foundation

struct OnboardingView: View {
    
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    //onboarding inputs
    @State var currentEducation: String = ""
    @State var interestedEducation: String = ""
    @State var interestedSubject: String = ""
    
    @State private var isEducationPickerActive = false
    @State private var isInterestedPickerActive = false

    
    var filteredSubjects: [Subject] {
        subjects.filter { $0.name.lowercased().contains(interestedSubject.lowercased()) || interestedSubject.isEmpty }
    }
    
    //alers
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //app storage
    @AppStorage("education") var currentUserEducation: String?
    @AppStorage("interestedEducation") var currentUserInterestedEducation: String?
    @AppStorage("subject") var currentUserInterestedSubject: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @AppStorage("subject_info") var getSubjectInfo: String?
    
    //dataService
    @State var subjects: [Subject] = []
    var dataService = JSONdecoder()
    
    var body: some View {
        ZStack{
            //content layer
            ZStack{
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    currentEducationSection
                        .transition(transition)
                case 2:
                    interestedEducationSection
                        .transition(transition)
                case 3:
                    interestedSubjectSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.green)
                }
            }
            
            //buttons layer
            VStack{
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text (alertTitle))
        })
    }
}

#Preview {
    OnboardingView()
        .background(Color.mint)
}

//MARK: components
extension OnboardingView {
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "Start Onboarding" : onboardingState == 3 ? "Finish" : "Next")
            .font(.headline)
            .foregroundColor(.mint)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .animation(nil)
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Image(systemName: "graduationcap")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.black)
            Text("SoMo")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)

        }
        .padding()
    }
    
    private var currentEducationSection: some View {
        
        
        ZStack{
            
            Color(.blue)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Text("Which level of education are you currently in?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()

                Button(action: {
                    isEducationPickerActive.toggle()
                }) {
                    Text(currentEducation.isEmpty ? "Select a level" : currentEducation)
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()

                }
                .actionSheet(isPresented: $isEducationPickerActive) {
                    ActionSheet(title: Text("Select a Level"), buttons: [
                        .default(Text("GCSE")) { currentEducation = "GCSE" },
                        .default(Text("Alevel")) { currentEducation = "Alevel" },
                        .default(Text("Tlevel")) { currentEducation = "Tlevel" },
                        .default(Text("Apprenticship")) { currentEducation = "Apprenticship" },
                        .cancel()
                        
                    ])
                    
                }
            }
            .padding()
        }
    }
    
    private var interestedEducationSection: some View {
        
        
        ZStack{
            
            Color(.blue)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {

                Text("Which level of education are you interested in?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()

                Button(action: {
                    isInterestedPickerActive.toggle()
                }) {
                    Text(interestedEducation.isEmpty ? "Select a level" : interestedEducation)
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()

                }
                .actionSheet(isPresented: $isInterestedPickerActive) {
                    ActionSheet(title: Text("Select a Level"), buttons: [
                        .default(Text("GCSE")) { interestedEducation = "GCSE" },
                        .default(Text("Alevel")) { interestedEducation = "Alevel" },
                        .default(Text("Tlevel")) { interestedEducation = "Tlevel" },
                        .default(Text("Apprenticship")) { interestedEducation = "Apprenticship" },
                        .default(Text("Undergraduate")) { interestedEducation = "Undergraduate" },
                        .cancel()

                    ])
                }
            }
            .padding()
        }
    }
    
    private var interestedSubjectSection: some View{
        
        ZStack{
            
            Color(.blue)
                .ignoresSafeArea()
            
            Group {
                VStack {
                    Text("Which subject would you like to know more about?")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                    
                    TextField("Search...", text: $interestedSubject)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    if !interestedSubject.isEmpty {
                        List(filteredSubjects) { subject in
                            Button(action: {
                                interestedSubject = subject.name
                            }) {
                                Text(subject.name)
                                    .foregroundColor(.black)
                            }
                        }
                        .onAppear {
                            subjects = dataService.loadSubjects()
                        }
                    }
                }
            }
        }
    }
}
extension OnboardingView {
    
    func handleNextButtonPressed(){
        
        switch onboardingState {
        case 3:
            guard subjects.contains(where: { $0.name == interestedSubject }) else {
                showAlert(title: "Please enter a valid subject")
                return
            }
        case 2:
            guard interestedEducation.count > 1 else {
                showAlert(title: "Please select a level of education")
                return
            }
        default:
            break
        }
        
        if onboardingState == 3 {
            signIn()
        }
        
        else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    func signIn(){
        currentUserEducation = currentEducation
        currentUserInterestedSubject = interestedSubject
        currentUserInterestedEducation = interestedEducation
        withAnimation(.spring()){
            currentUserSignedIn = true
            
        }
    }
    
    func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
}
