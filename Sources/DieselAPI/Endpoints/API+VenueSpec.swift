// Copyright © Fleuronic LLC. All rights reserved.

import struct DieselService.VenueBaseFields
import protocol DieselService.VenueSpec
import protocol Catenary.API

extension API: VenueSpec {
	public func storeVenues(from list: Void) async -> Self.Result<[VenueBaseFields]> {
		await fetch(VenueBaseFields.self)
	}
}
