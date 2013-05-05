#pragma strict

public var player : GameObject;
public var spawnPoint :GameObject;

function Awake () {
	
	spawnPlayer();
}

function Start () {

	// after a second, start moving the player
	yield WaitForSeconds(1);
	startMovement();
}

function Update () {

}


private function spawnPlayer() :void
{
	player = Instantiate(player, spawnPoint.transform.position, Quaternion.identity);
	player.name = "Player";
	var level :GameObject = GameObject.Find("Level");
	player.transform.parent = level.transform;
}


private function startMovement():void
{
	player.GetComponent(PlayerController).startMovement();
}