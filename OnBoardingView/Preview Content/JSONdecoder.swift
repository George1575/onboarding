//
//  JSONdecoder.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 25/09/2023.
//
import SwiftUI
import Foundation

class JSONdecoder: ObservableObject {
    
    @Published var chosenSubject = [Subject]()

    @Published var currentSubject: Subject?
    
    init() {
        //parese local included json data
        loadSubjects()
    }
    
    func loadSubjects() -> [Subject] {
        
        
        if let url = Bundle.main.url(forResource: "subjects", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                do {
                    let subjects = try decoder.decode([Subject].self, from: data)
                    return subjects
                }
                catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            catch {
                print("Cannot find subjects.json")
            }
        }
        return [Subject]()
    }
}

