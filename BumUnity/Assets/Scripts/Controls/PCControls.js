#pragma strict

private var _player :PlayerController;

function Start () {
	_player = GameObject.Find("Player").GetComponent(PlayerController);
}

function Update () {

	if (Input.GetButtonDown("Left")) {
		_player.MoveLeft();
	}
	
	if (Input.GetButtonDown("Right")) {
		_player.MoveRight();
	}
	
	// jump action
	if (Input.GetButtonDown("Jump")) {
		_player.Jump();
	}
	
	// attack 
	if (Input.GetButtonDown("Fire1")) {
		_player.Attack();
	}
}