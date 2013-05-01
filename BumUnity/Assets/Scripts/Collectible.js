#pragma strict

public var type :String = "can";
public var value :int = 1;

private var _player:Player;
private var _currency:PlayerCurrency;

function Awake () {
	this.gameObject.tag = "Collectible";
}

function Start() 
{
	_player = GameObject.Find("Player").GetComponent(Player);
	_currency = _player.gameObject.GetComponent(PlayerCurrency);
}

function Update () {

}

/* Collision Detection =========================================================================== */

function OnTriggerEnter( collision:Collider )
{
	if (collision.gameObject.tag == "Player") {
		print("hit player");
		
		// add the value of this can to the player scores.
		switch(this.type) {
			case "can":
				_currency.addCans( value );
				break;
			case "cash":
				_currency.addCash( value );
				break;
			default:
				Debug.LogWarning("Unknown Collectible Type Touched Player!");
				break;
		}
	}
}

function OnTriggerStay( collision:Collider )
{
	if (collision.gameObject.tag == "Player") {
		print("stay player");
	}
}

function OnTriggerExit( collision:Collider )
{
	if (collision.gameObject.tag == "Player") {
		print("left player");
	}
}