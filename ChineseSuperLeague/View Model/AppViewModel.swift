//
//  AppViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import Foundation
import os

class AppViewModel: ObservableObject {

    func fetchTeams() async {
        do {
            let teams: [TeamDTO] = try await NetworkClient.fetch(path: "/teams")
            Logger().debug("\(teams)")
        } catch NetworkError.invalidURL {
            Logger().error("Invalid URL!")
        } catch NetworkError.invalidResponse {
            Logger().error("Invalid response!")
        } catch NetworkError.invalidData {
            Logger().error("Invalid data!")
        } catch {
            Logger().error("Request failed!")
        }
    }
}
