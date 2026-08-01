//
//  Date+Formatting.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 05.07.26.
//

import Foundation

extension Date {
    private static let formatter = ISO8601DateFormatter()

    /// Initialize a Date from a date string
    init?(from dateString: String) {
        guard let date = Date.formatter.date(from: dateString) else {
            return nil
        }
        self = date
    }

    /// Return a Date in 'dd MMM yyyy' format
    var date: String {
        return self.formatted(.dateTime
            .locale(Locale(identifier: "en_GB"))
            .day(.twoDigits)
            .month(.abbreviated)
            .year()
        )
    }

    var withoutTime: Date {
        return Calendar.current.startOfDay(for: self)
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
