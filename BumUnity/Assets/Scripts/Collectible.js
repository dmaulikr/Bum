#pragma strict

public var type :String = "can";
public var value :int = 1;

public var rewardText : GameObject;

private var _player:Player;
private var _currency:PlayerCurrency;

private var _rewardTextObj :GameObject;


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

protected function playPickupAnimation() 
{
	// create reward clone of the reward text and set its value
	_rewardTextObj = Instantiate(rewardText, transform.position, Quaternion.identity);
	_rewardTextObj.GetComponent(tk2dTextMesh).text = "+" + value;
	
//	// fade out
//	iTween.FadeTo(_rewardTextObj, {
//		"alpha": 0.0,
//		"delay": 1.0,
//		"duration": 2.0,
//		"NamedValueColor" : "_color"
//	});
//	
//	// then animate it up and out
//	iTween.MoveTo(_rewardTextObj, { 
//		"position": _rewardTextObj.transform.position + (Vector3.up *30),
//		"duration": 2,
//		"oncomplete": "destroy",
//		"oncompletetarget": this.gameObject
//	});
	
	// hide the can
	this.renderer.enabled = false;
}

protected function destroy()
{
	// first destroy the reward text
	Destroy(_rewardTextObj);
	
	// and remove the original collectible object
	Destroy(this.gameObject);
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
		
		// stop colliding with stuff
		this.collider.enabled = false;
		
		// show animation
		playPickupAnimation();
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