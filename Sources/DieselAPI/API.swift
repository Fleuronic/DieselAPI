// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenary.Request
import struct Catena.IDFields
import struct Diesel.Event
import struct Diesel.Slot
import struct Foundation.URL
import struct Foundation.Date
import class Foundation.JSONDecoder
import class Foundation.DateFormatter
import class Foundation.ISO8601DateFormatter
import protocol Catenary.API
import protocol Caesura.HasuraAPI
import protocol DieselService.EventFields
import protocol DieselService.SlotFields

public struct API<
	EventListFields: EventFields,
	EventDetailsFields: EventFields,
	SlotListFields: SlotFields
> {
	private let apiKey: String
	private let dateFormatter: DateFormatter
	private let timeFormatter: ISO8601DateFormatter
}

public extension API {
	init(
		apiKey: String,
		eventListFields: EventListFields.Type = IDFields<Event.Identified>.self,
		eventDetailsFields: EventDetailsFields.Type = IDFields<Event.Identified>.self,
		slotListFields: SlotListFields.Type = IDFields<Slot.Identified>.self
	) {
		self.apiKey = apiKey

		dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-dd"
		timeFormatter = ISO8601DateFormatter()
	}
}

// MARK: -
extension API: HasuraAPI {
	// MARK: API
	public var authenticationHeader: Request.Header? {
		.init(
			field: "x-hasura-admin-secret",
			value: apiKey
		)
	}

	public var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .custom { decoder -> Date in
			let container = try decoder.singleValueContainer()
			let dateString = try container.decode(String.self)
			return dateFormatter.date(from: dateString) ?? timeFormatter.date(from: dateString)!
		}
		return decoder
	}

	public func url(for path: String) -> URL {
		URL(string: "https://diesel.hasura.app/v1/\(path)")!
	}
}
