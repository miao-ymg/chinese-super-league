//
//  Standings.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.09.24.
//

import SwiftUI

// --- CONSTANTS ---
let fontSize: CGFloat = 13

let tableRowHeight: CGFloat = 44
let triviaItemHeight: CGFloat = 20

let percentualPositions = [0.06, 0.3, 0.54, 0.62, 0.7, 0.78, 0.86, 0.95]    // Default percentual horizontal positions for table items


struct Team: Decodable {
    let name: String
    let played: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalDifference: Int
    let points: Int
    
    // All JSON properties to decode
    enum CodingKeys: CodingKey {
        case team, all  // A few parent keys
        case name, played, win, draw, lose, goalsDiff, points
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .team)
        let allContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .all)
        
        self.name = try teamContainer.decode(String.self, forKey: .name)
        self.played = try allContainer.decode(Int.self, forKey: .played)
        self.wins = try allContainer.decode(Int.self, forKey: .win)
        self.draws = try allContainer.decode(Int.self, forKey: .draw)
        self.losses = try allContainer.decode(Int.self, forKey: .lose)
        self.goalDifference = try container.decode(Int.self, forKey: .goalsDiff)
        self.points = try container.decode(Int.self, forKey: .points)
    }
}


// --- FUNCTIONS ---

// Percentual horizontal position of a table row item
extension View {
    func horizPosItem(index: Int, totalWidth: CGFloat) -> some View {
        self.position(x: percentualPositions[index] * totalWidth, y: tableRowHeight / 2)
    }
}


// --- ERRORS ---

enum MyError: Error {
    case invalidURL
    case invalidData
}


// --- VIEWS ---

struct StandingsHeader: View {
    var body: some View {
        ZStack {
            // ZStack & GeometryReader for fixed positioning
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                
                Text("Club")
                    .frame(width: 0.4 * screenWidth, alignment: .leading)
                    .horizPosItem(index: 1, totalWidth: screenWidth)
                Text("MP")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("W")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("D")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("L")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("+/-")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("Pts")
                    .horizPosItem(index: 7, totalWidth: screenWidth)
            }
        }
        .frame(height: tableRowHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .foregroundColor(Color.dark1)
        .fontWeight(.bold)
        .background(Color.accentColor)
    }
}


struct StandingsRow: View {
    let rank: Int
    let team: Team
    func outcomeColor() -> Color {
        switch rank {
        case 1:
            return Color.aclElite
        case 2:
            return Color.aclPlayoff
        case 3:
            return Color.aclTwo
        case 15, 16:
            return Color.relegation
        default:
            return Color.clear
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                // Outcome indicator
                Rectangle()
                    .foregroundColor(outcomeColor())
                    .frame(width: 6)
                    .cornerRadius(1)
                    .padding(2)
                // Rank
                Text("\(rank)")
                    .fontWeight(.semibold)
                    .horizPosItem(index: 0, totalWidth: screenWidth)
                // Club
                HStack {
                    // Crest
                    Circle()
                        .foregroundColor(.secondary)
                        .frame(height: 0.7 * tableRowHeight)
                        .aspectRatio(1, contentMode: .fit)
                    Text("\(team.name)")
                        .font(.poppinsFont(fontSize-1, weight: .regular))
                }
                .frame(width: 0.4 * screenWidth, alignment: .leading)
                .horizPosItem(index: 1, totalWidth: screenWidth)
                
                // Statistics
                Text("\(team.played)")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("\(team.wins)")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("\(team.draws)")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("\(team.losses)")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("\(team.goalDifference > 0 ? "+" : "")\(team.goalDifference)")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("\(team.points)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
                    .horizPosItem(index: 7, totalWidth: screenWidth)
            }
        }
        .frame(height: tableRowHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}


struct TriviaItem: View {
    let outcome: String
    let circleColor: Color
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(circleColor)
            Text(outcome)
        }
        .frame(height: triviaItemHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .font(.poppinsFont(0.8 * fontSize, weight: .regular))
    }
}


// Main view
struct Standings: View {
    let triviaItems = [
        ("AFC Champions League Elite", Color.aclElite),
        ("AFC Champions League Elite play-off", Color.aclPlayoff),
        ("AFC Champions League Two", Color.aclTwo),
        ("Relegation", Color.relegation),
    ]
    
    func getTeams() throws -> [Team] {
        // Read data from JSON file
        guard let filePath = Bundle.main.url(forResource: "test", withExtension: "json") else {
            throw MyError.invalidURL
        }
        let data = try Data(contentsOf: filePath)
        
        // Deserialization
        if let dataModel = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           // Navigate to target array within nested JSON
           let standings = (((dataModel["response"] as? [[String: Any]])?.first?["league"] as? [String: Any])?["standings"] as? [[[String: Any]]])?.first {
            
            // Serialization
            let teamsData = try JSONSerialization.data(withJSONObject: standings)
            // Decoding step
            return try JSONDecoder().decode([Team].self, from: teamsData)
        } else {
            throw MyError.invalidData
        }
    }
    
    // We need a teamList first
    
    // @State
    // - View will be re-rendered, once the variable state changes
    // - For local state variables only used by this View itself
    // Optional, because teamList doesn't exist yet before function call
    @State private var teamList: [Team]?
    
    var body: some View {
        VStack(spacing: 0) {
            // Upper bar
            HStack {
                Text("Standings")
                    .font(.ntfGrandItalicFont(36, weight: .medium))
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            }
            // Standings header
            StandingsHeader()
            
            ScrollView {
                // League standings
                VStack(spacing: 0) {
                    ForEach((teamList ?? []).indices, id: \.self) { i in
                        StandingsRow(rank: i+1, team: teamList![i])
                    }
                }
                VStack {
                    // Trivia
                    ForEach(triviaItems, id: \.0) { item in
                        TriviaItem(outcome: item.0, circleColor: item.1)
                    }
                    // Notes
                    Group {
                        Text("* One additional AFC Champions League Elite slot allocated to the Chinese FA Cup winner")
                        Text("* Last updated on <DATE>")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsFont(0.7 * fontSize, weight: .regular))
                }
                .padding(8)
            }
            .background(Color.dark1)
        }
        .foregroundColor(Color.light1)
        .background(Color.dark2)
        .font(.poppinsFont(fontSize, weight: .regular))
        
        .task {
            do {
                teamList = try getTeams()
                
            } catch MyError.invalidURL {
                print("ERROR: Invalid URL")
            } catch MyError.invalidData {
                print("ERROR: Invalid Data")
            } catch {
                print("ERROR: Unexpected error")
            }
        }
    }
}

#Preview {
    Standings()
}
