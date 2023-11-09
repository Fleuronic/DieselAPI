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
			await fetch(EventListFields.self, where: Event.takesPlace(in: year))
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
