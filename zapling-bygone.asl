state("ZaplingBygone") {
	uint room_id         : 0x015A9D40;
	byte is_ingame       : 0x015A9D18, 0xF4, 0xA8, 0xEC, 0x6C, 0xF0, 0xE0, 0x8;
	uint core_health     : 0x014E8850, 0xBA8, 0xC, 0x24, 0x10, 0xC, 0x4;
	uint ptr_core_health : 0x014E8850, 0xBA8, 0xC, 0x24, 0x10, 0xC;
}

start {
	return current.is_ingame == 1 && old.is_ingame == 0;
}

split {
	bool valid_old_health = old.core_health > 0x30000000 && old.core_health < 0x4FFFFFFF;
	bool valid_ptr = current.ptr_core_health != 0 && old.ptr_core_health != 0;
	return current.room_id == 152 && current.core_health == 0 && valid_old_health && valid_ptr;
}
