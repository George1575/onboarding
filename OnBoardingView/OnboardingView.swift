//
//  OnboardingView.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI
import Foundation

struct OnboardingView: View {
    //onboarding states
    /*
     0 - welcome screen
     1 - ability to add name
     2- ability to add age
     3- ability to add gender
     */
    
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    //onboarding inputs
    @State var currentEducation: String = ""
    @State var interestedEducation: String = ""
    @State var interestedSubject: String = ""
    
    @State var selectedSubject: Subject?
    @State var subjects: [Subject] = []
    
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
        Text(onboardingState == 0 ? "Sign up" : onboardingState == 3 ? "Finish" : "Next")
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
            Spacer()
            Image(systemName: "graduationcap")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.black)
            Text("SoMo")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    private var currentEducationSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What education level are you currently at?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            //currentEducation.count > 1 ? currentEducation:
            Picker(selection: $currentEducation,
                   label:
                    Text("select a level")){
                Text("GCSE")
                    .tag("GCSE")
                Text("Alevel")
                    .tag("Alevel")
                Text("Tlevel")
                    .tag("Tlevel")
                Text("Apprenticship")
                    .tag("Apprenticship")
                
            }
                    .pickerStyle(MenuPickerStyle())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .padding()
    }
    
    private var interestedEducationSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What eduation level are you interested in?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Picker(selection: $interestedEducation,
                   label:
                    Text("select a level")){
                Text("GCSE")
                    .tag("GCSE")
                Text("Alevel")
                    .tag("Alevel")
                Text("Tlevel")
                    .tag("Tlevel")
                Text("Apprenticship")
                    .tag("Apprenticship")
                Text("Undergraduate")
                    .tag("Undergraduate")
                
            }
                    .pickerStyle(MenuPickerStyle())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .padding()
    }
    
    private var interestedSubjectSection: some View{
        
        Group {
            VStack {
                Spacer()
                Text("Which subject would you like to know more about?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                Spacer()
                
                TextField("Search...", text: $interestedSubject)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                if !interestedSubject.isEmpty {
                    List(filteredSubjects) { subject in
                        Button(action: {
                            interestedSubject = subject.name
                        }) {
                            Text(subject.name)
                                .foregroundColor(.black)
                            
                        }
                        
                    }
                    .onAppear(perform: loadSubjects)
                    Spacer()
                }
            }
        }
    }
    func loadSubjects() {
        
        
        if let url = Bundle.main.url(forResource: "subjects", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                subjects = try JSONDecoder().decode([Subject].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Cannot find subjects.json")
        }
    }
}

//MARK: Functions
extension OnboardingView {
    
    func handleNextButtonPressed(){
        
        switch onboardingState {
        case 3:
            guard subjects.contains(where: { $0.name == interestedSubject }) else {
                showAlert(title: "Please enter a valid subject")
                return
            }
        default:
            break
        }
        
        //go to next section
        if onboardingState == 3 {
            //sign in
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
struct Subject: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let details: String
    
}

enum ActiveView {
    case list, detail
}


