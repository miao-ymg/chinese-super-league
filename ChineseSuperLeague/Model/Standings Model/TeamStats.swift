//
//  TeamStats.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 29.12.24.
//

struct TeamStats: Decodable {
    let idApi: Int
    let rank: Int
    let played: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalDifference: Int
    let points: Int

    // All JSON properties to decode
    enum CodingKeys: CodingKey {
        case team, all  // A few parent keys
        case id, rank, played, win, draw, lose, goalsDiff, points
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .team)
        let allContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .all)

        self.idApi = try teamsContainer.decode(Int.self, forKey: .id)
        self.rank = try container.decode(Int.self, forKey: .rank)
        self.played = try allContainer.decode(Int.self, forKey: .played)
        self.wins = try allContainer.decode(Int.self, forKey: .win)
        self.draws = try allContainer.decode(Int.self, forKey: .draw)
        self.losses = try allContainer.decode(Int.self, forKey: .lose)
        self.goalDifference = try container.decode(Int.self, forKey: .goalsDiff)
        self.points = try container.decode(Int.self, forKey: .points)
    }
}
