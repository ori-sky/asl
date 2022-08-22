state("ZaplingBygone") {
	uint room            : 0x015A9D40;
	uint b_collect_skull : 0x015A0574, 0x0, 0x24, 0xC, 0x4, 0x0, 0x1C, 0x4C;
	byte b_ingame        : 0x015A9D18, 0xF4, 0xA8, 0xEC, 0x6C, 0xF0, 0xE0, 0x8;
	float core_health    : 0x014E8850, 0xBA8, 0xC, 0x24, 0x10, 0xC, 0x4;
}

startup {
	settings.Add("CollectSkull", true, "Collect Skull");
}

start {
	return current.room == 0x3E && old.room == 0x84;
}

split {
	bool result = false;

	// on collect skull
	result |= settings["CollectSkull"] && current.b_collect_skull == 1 && old.b_collect_skull == 0;

	// on kill infection core
	result |= current.room == 0x98 && current.core_health <= 0 && old.core_health > 0;

	return result;
}
