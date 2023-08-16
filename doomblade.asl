state("DOOMBLADE") {
	float session_time : "UnityPlayer.dll",    0x019DEE30, 0x10, 0xD0, 0x80, 0x28, 0x28, 0x0, 0x68;
	float save_time    : "mono-2.0-bdwgc.dll", 0x00499C78, 0xE0, 0x0, 0xE0, 0x90, 0x60, 0x70, 0x60, 0x48, 0x3C;
	string255 room     : "UnityPlayer.dll",    0x019DEE30, 0x0, 0xC0, 0x28, 0x70, 0x0, 0x60, 0x120, 0x20, 0x18, 0x14;
}

start {
	return current.session_time > 0 && old.session_time == 0 && current.save_time == 0;
}

split {
	bool result = false;

	result |= current.room == "End";

	return result;
}

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromSeconds(current.session_time + current.save_time);
}
