//
//  ResponseEnvelope.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import Foundation

struct ResponseEnvelope<T: Decodable>: Decodable {
    let success: Bool
    let lastUpdated: Date
    let data: T
}
