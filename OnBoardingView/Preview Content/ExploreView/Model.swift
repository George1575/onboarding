//
//  Model.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 01/10/2023.
//

import Foundation


struct Level: Identifiable, Decodable {
    
    let id = UUID()
    var name: String
    var summary: String
    var imageName: String
    
    //level will be at the beginning, you will need information on questions to drill down into
    var subjects: [Subject]
}

struct Subject: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let details: String
    var imageName: String
}

