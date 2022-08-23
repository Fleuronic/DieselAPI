// Copyright © Fleuronic LLC. All rights reserved.

import struct DieselService.AddressBaseFields
import protocol DieselService.AddressSpec
import protocol Catenary.API

extension API: AddressSpec {
	public func storeAddresses(from list: Void) async -> Self.Result<[AddressBaseFields]> {
		await fetch(AddressBaseFields.self)
	}
}
