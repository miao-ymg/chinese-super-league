//
//  Date+Formatting.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 05.07.26.
//

import Foundation

extension Date {
    /// Return a Date in 'dd MMM yyyy' format
    var date: String {
        return self.formatted(.dateTime
            .locale(Locale(identifier: "en_GB"))
            .day(.twoDigits)
            .month(.abbreviated)
            .year()
        )
    }

    /// Return the time of a Date in 24-hour time format
    var time: String {
        return self.formatted(.dateTime
            .hour(.twoDigits(amPM: .omitted))
            .minute(.twoDigits)
        )
    }

    /// Return the weekday name, or "Today"/"Tomorrow" if applicable
    var day: String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            return self.formatted(.dateTime.weekday(.wide))
        }
    }
}
