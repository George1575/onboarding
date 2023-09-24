//
//  ContentView.swift
//  SearchableView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI
import Foundation

struct SubjectSelectionView: View {
    @State private var activeView: ActiveView = .list
    @State private var selectedSubject: Subject?
    @State private var searchText = ""
    @State private var subjects: [Subject] = []
    
    var filteredSubjects: [Subject] {
        subjects.filter { $0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty }
    }
    
    var body: some View {
            Group {
                switch activeView {
                case .list:
                    VStack {
                        Spacer()
                        TextField("Search...", text: $searchText)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        Spacer()
                        
                        // Conditionally render List when searchText is not empty
                        if !searchText.isEmpty {
                            List(filteredSubjects) { subject in
                                Button(action: {
                                    selectedSubject = subject
                                    activeView = .detail
                                }) {
                                    Text(subject.name)
                                }
                            }
                            .onAppear(perform: loadSubjects)
                        }
                    }
            case .detail:
                if let subject = selectedSubject {
                    SubjectDetailView(subject: subject, activeView: $activeView)
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

struct SubjectDetailView: View {
    let subject: Subject
    @Binding var activeView: ActiveView
    
    var body: some View {
        VStack {
            Text(subject.details)
                .padding()
            Button("Back to List") {
                activeView = .list
            }
        }
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

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            SubjectSelectionView()
        }
    }
}
