//
//  MatchStatus.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 09.07.26.
//

enum MatchStatus: String {
    case notStarted = "NS"
    case live = "LIVE"
    case halfTime = "HT"
    case fullTime = "FT"
    case interrupted = "INT"
    case postponed = "PST"
    case unknown = "UNK"

    var isInPlay: Bool {
        return self == .live || self == .halfTime
    }

    var isPreMatch: Bool {
        return self == .notStarted || self == .postponed
    }

    var isDisrupted: Bool {
        return self == .interrupted || self == .postponed
    }
}
