//
//  JSONdecoder.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 25/09/2023.
//

import Foundation

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
