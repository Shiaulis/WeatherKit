//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 28.03.2021.
//

import Foundation

final class ForecastDateFormatter {

    // MARK: - Properties

    private let locale: Locale
    private let calendar: Calendar
    private let dateFormatter: DateFormatter

    // MARK: - Initialization

    init(locale: Locale = .current, calendar: Calendar = .current, dateFormatter: DateFormatter = .init()) {
        self.locale = locale
        self.calendar = calendar
        self.dateFormatter = dateFormatter
        self.dateFormatter.locale = .init(identifier: "et-EE")
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    // MARK: - Public

    func humanReadableDescription(for date: Date?) -> String? {
        guard let date = date else { return nil }

        guard var humanReadableDescription = string(from: date, calendar: self.calendar, locale: self.locale) else { return nil }

        if let description = textDescription(from: date, calendar: self.calendar, locale: self.locale) {
            humanReadableDescription += ", \(description)"
        }

        return humanReadableDescription
    }

    func shortReadableDescription(for date: Date?) -> String? {
        guard let date = date else { return nil }

        let formatter: DateFormatter = .init()
        formatter.locale = self.locale
        formatter.calendar = self.calendar
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true

        return formatter.string(from: date)
    }

    func date(from string: String?) -> Date? {
        guard let string = string else { return nil }
        return self.dateFormatter.date(from: string)
    }

    private func textDescription(from date: Date, calendar: Calendar, locale: Locale) -> String? {
        let formatter: DateFormatter = .init()
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true

        let description = formatter.string(from: date)

        guard let firstCharacter = description.first else { return nil }
        guard firstCharacter.isLetter else { return nil }

        return description.capitalized
    }

    private func string(from date: Date, calendar: Calendar, locale: Locale) -> String? {
        let formatter: DateFormatter = .init()
        formatter.locale = self .locale
        formatter.calendar = calendar
        formatter.setLocalizedDateFormatFromTemplate("dMMMM")

        return formatter.string(from: date)
    }

}
