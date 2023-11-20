// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenary.Request
import struct Catena.IDFields
import struct Diesel.Event
import struct Diesel.Slot
import struct Foundation.URL
import class Foundation.JSONDecoder
import class Foundation.DateFormatter
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
}

public extension API {
	init(
		apiKey: String,
		eventListFields: EventListFields.Type = IDFields<Event.Identified>.self,
		eventDetailsFields: EventDetailsFields.Type = IDFields<Event.Identified>.self,
		slotListFields: SlotListFields.Type = IDFields<Slot.Identified>.self
	) {
		self.apiKey = apiKey
	}
}

// MARK: -
extension API: HasuraAPI {
	// MARK: API
	public var baseURL: URL {
		URL(string: "https://diesel.hasura.app/v1/graphql")!
	}

	public var authenticationHeader: Request.Header? {
		.init(
			field: "x-hasura-admin-secret",
			value: apiKey
		)
	}

	public var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		return decoder
	}
}

// MARK: -
private let dateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "YYYY-MM-dd"
	return formatter
}()
