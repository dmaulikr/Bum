#pragma strict

public var damageAmount : int = 10;
public var bounceBackVelocity :float = 200.0;

private var _player :GameObject;
private var _health :Health;
private var _playerController :PlayerController;

function Start () {
	_player = GameObject.Find("Player");
	_health = _player.GetComponent(Health);
	_playerController = _player.GetComponent(PlayerController);
}

function OnTriggerEnter( collider : Collider )
{
	if (collider.gameObject.name == "Player") {
	
		_health.Damage( damageAmount );
		
		// apply a reactive force to the player to knock them back		
		var distance :Vector3 = _player.transform.position - this.gameObject.transform.position;
		var normalizedDistance :Vector3 = distance.normalized;
		_player.rigidbody.AddForce( Vector3(bounceBackVelocity * normalizedDistance.x, bounceBackVelocity * normalizedDistance.y, 0), ForceMode.VelocityChange );
	}
}