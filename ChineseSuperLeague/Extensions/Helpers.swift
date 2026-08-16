//
//  Helpers.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.08.26.
//


/// Return a minute of play as a String
func minuteOfPlay(regular: Int, added: Int?) -> String {
    let added = added.map { "+\($0)" } ?? ""
    return "\(regular)\(added)'"
}
