#pragma strict

private var _player :GameObject;

function Start () {

	_player = GameObject.Find("Player");

	// after a second, start moving the player
	yield WaitForSeconds(1);
	startMovement();
}

function Update () {

}


private function startMovement():void
{
	_player.GetComponent(Player).startMovement();
}