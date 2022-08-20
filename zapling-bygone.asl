state("ZaplingBygone") {
	uint room         : 0x015A9D40;
	byte is_ingame    : 0x015A9D18, 0xF4, 0xA8, 0xEC, 0x6C, 0xF0, 0xE0, 0x8;
	float core_health : 0x014E8850, 0xBA8, 0xC, 0x24, 0x10, 0xC, 0x4;
}

start {
	return current.room == 0x3E && old.room == 0x84;
}

split {
	bool current_alive = current.core_health > 0;
	bool old_alive     = old.core_health     > 0;
	return current.room == 0x98 && current_alive == false && old_alive == true;
}
