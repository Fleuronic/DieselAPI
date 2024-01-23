// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Diesel.Slot
import protocol DieselService.SlotSpec
import protocol Catenary.API

extension API: SlotSpec {
	public func listSlots(comprisingEventWith id: Event.ID) -> AsyncStream<Self.Result<[SlotListFields]>> {
		.init { await fetch(SlotListFields.self, where: Slot.isPartOfEvent(with: id)) }
	}
}
