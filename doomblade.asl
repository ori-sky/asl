state("DOOMBLADE") {}

startup {
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
	vars.Helper.LoadSceneManager = true;
}

init {
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
		vars.Helper["SessionTime"] = mono.Make<float>("GameTimeManager", "sessionGameTime");
		vars.Helper["SaveTime"]    = mono.Make<float>("SaveManager", "instance", "save", "gameTime");
		vars.Helper["RoomID"]      = mono.MakeString("RoomChanger", "instance", "currentRoom", "id");

		return true;
	});
}

start {
	return current.SceneName == "Home Hole Room" && current.SessionTime < 5.0f && current.SaveTime == 0.0f;
}

split {
	bool result = false;

	result |= old.RoomID == "Dread Lords" && current.RoomID == "End";

	return result;
}

update {
	current.SceneName = vars.Helper.Scenes.Loaded[0].Name;
}

gameTime {
	return TimeSpan.FromSeconds(current.SessionTime + current.SaveTime);
}

isLoading {
	return true;
}
