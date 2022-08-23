// Copyright © Fleuronic LLC. All rights reserved.

import struct DieselService.LocationBaseFields
import protocol DieselService.LocationSpec
import protocol Catenary.API

extension API: LocationSpec {
    public func storeLocations(from list: Void) async -> Self.Result<[LocationBaseFields]> {
        await fetch(LocationBaseFields.self)
    }
}
