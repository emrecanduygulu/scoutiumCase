//
//  Models.swift
//  scoutiumProject
//
//  Created by emre can duygulu on 26.01.2021.
//  Copyright © 2021 emre can duygulu. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let title: String
    let url: String
}
