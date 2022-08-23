// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct DieselService.EventBaseFields
import struct DieselService.EventListFields
import struct DieselService.EventDetailsFields
import protocol DieselService.EventSpec
import protocol Catenary.API

extension API: EventSpec {
    public func listEvents(for year: Int) -> AsyncStream<Self.Result<[EventListFields]>> {
        .init {
			await fetch(EventListFields.self).map {
				$0.sorted {
					($0.date, $0.city) < ($1.date, $1.city)
				}
			}
        }
    }

	public func fetchEventDetails(with id: Event.ID) -> AsyncStream<Self.Result<EventDetailsFields?>> {
		.init {
			await fetch(EventDetailsFields.self, with: id)
		}
	}

    public func storeEvents(from _: Void, for year: Int) async -> Self.Result<[EventBaseFields]> {
        await fetch(EventBaseFields.self)
    }
    
    public func deleteEvents(for year: Int) async {
        return
    }
}

import Foundation

private func timeFormatter(timeZone: TimeZone) -> DateFormatter {
	let formatter = DateFormatter()
	formatter.dateFormat = "h:mm a"
	formatter.timeZone = timeZone
	return formatter
}
