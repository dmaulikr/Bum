#pragma strict


var engageRange :int = 1000;
var attackRange :int = 500;
var deathAnimation :OTAnimation;

private var _player : GameObject;
private var _sprite :OTAnimatingSprite;

enum AIState { idle, attacking }

function Start () {
	_player = GameObject.Find("Player");
	_sprite = this.GetComponentInChildren(OTAnimatingSprite);
}

function Update () {
	
}


// called by the Health component when we die.
function GameObjectDied () {
	
	Debug.Log("AI Enemy Died");
	
	if (_sprite == null) {
		Debug.Log("no sprite");
	}
	else {
		Debug.Log("found sprite");
	}
	
	// play death animation
	_sprite.animation = deathAnimation;
	_sprite.Play();
	
	// remove physics
	Destroy(this.rigidbody);
	Destroy(this.collider);
	
	// and then destroy
	Destroy(this.gameObject, 1);
}