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

    init(_ rawValue: String) {
        self = MatchStatus(rawValue: rawValue) ?? .unknown
    }

    var fullString: String {
        switch self {
        case .notStarted:   "Not started"
        case .live:         "Live"
        case .halfTime:     "Half-time"
        case .fullTime:     "Full-time"
        case .interrupted:  "Interrupted"
        case .postponed:    "Postponed"
        case .unknown:      "UNKNOWN"
        }
    }

    var isInPlay: Bool {
        return self == .live || self == .halfTime || self == .interrupted
    }

    var isPreMatch: Bool {
        return self == .notStarted || self == .postponed
    }

    var isDisrupted: Bool {
        return self == .interrupted || self == .postponed
    }
}
