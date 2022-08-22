state("ZaplingBygone") {
	uint room            : 0x015A9D40;
	uint b_collect_skull : 0x015A0574, 0x0, 0x24, 0xC, 0x4, 0x0, 0x1C, 0x4C;
	byte b_ingame        : 0x015A9D18, 0xF4, 0xA8, 0xEC, 0x6C, 0xF0, 0xE0, 0x8;
	float core_health    : 0x014E8850, 0xBA8, 0xC, 0x24, 0x10, 0xC, 0x4;
}

startup {
	settings.Add("Skull",               true,  "Skulls");
	settings.Add("SkullRatKing",        true,  "Skull of the Rat King (Wall Climb)", "Skull");
	settings.Add("SkullSharedBurden",   true,  "The Shared Burden (Dash)",           "Skull");
	settings.Add("SkullProtectorCore",  true,  "Protector Core (Beam)",              "Skull");
	settings.Add("SkullSewerSlumberer", true,  "Sewer Slumberer (Double Jump)",      "Skull");
	settings.Add("SkullGrappleHead",    false, "Grapple Head (Grapple)",             "Skull");
	settings.Add("SkullHardHat",        true,  "Hard Hat (Downward Dive)",           "Skull");
	settings.Add("SkullDamnedShame",    false, "A Damned Shame",                     "Skull");
	settings.Add("SkullTeacher",        false, "Teacher",                            "Skull");
	settings.Add("SkullNarcissist",     false, "Skull of the Narcissist",            "Skull");
	settings.Add("SkullBird",           false, "Bird",                               "Skull");
	settings.Add("SkullBilson",         false, "Bilson",                             "Skull");
	settings.Add("SkullBunny",          false, "Big Bunny",                          "Skull");
}

start {
	return current.room == 0x3E && old.room == 0x84;
}

split {
	bool result = false;

	// on collect skull
	if(settings["Skull"] && current.b_collect_skull == 1 && old.b_collect_skull == 0) {
		result |= settings["SkullRatKing"]        && current.room == 0xAD;
		result |= settings["SkullSharedBurden"]   && current.room == 0xB8;
		result |= settings["SkullProtectorCore"]  && current.room == 0xB9;
		result |= settings["SkullSewerSlumberer"] && current.room == 0x23;
		result |= settings["SkullGrappleHead"]    && current.room == 0x27;
		result |= settings["SkullHardHat"]        && current.room == 0x42;
		result |= settings["SkullDamnedShame"]    && current.room == 0x2D;
		result |= settings["SkullTeacher"]        && current.room == 0x59;
		result |= settings["SkullNarcissist"]     && current.room == 0x0C;
		result |= settings["SkullBird"]           && current.room == 0x1D;
		result |= settings["SkullBilson"]         && current.room == 0x5C;
		result |= settings["SkullBunny"]          && current.room == 0x5E;
	}

	// on kill infection core
	result |= current.room == 0x98 && current.core_health <= 0 && old.core_health > 0;

	return result;
}
