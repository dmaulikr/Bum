#pragma strict

function Awake () {
	
	Debug.Log("screen w: " + Screen.width + ", h: + " + Screen.height);
	if (Screen.height <= 320) {
		tk2dSystem.CurrentPlatform = "1x";
	}
	// ipad
	else if (Screen.height < 640) {
		tk2dSystem.CurrentPlatform = "2x";
	}
	// ipad Retina
	else if (Screen.height >= 768) {
		tk2dSystem.CurrentPlatform = "4x";
	}
	Debug.Log("Platform resolution: " + tk2dSystem.CurrentPlatform);
}