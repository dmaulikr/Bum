#pragma strict

import Holoville.HOTween;

public var type :String = "can";
public var value :int = 1;

public var rewardText : GameObject;

private var _player:GameObject;
private var _controls:PlayerControls;
private var _currency:PlayerCurrency;

private var _rewardTextObj :GameObject;


function Awake () {
	this.gameObject.tag = "Collectible";
}

function Start() 
{
	_player = GameObject.Find("Player");
	_controls = _player.GetComponent(PlayerControls);
	_currency = _player.GetComponent(PlayerCurrency);
}

function Update () {

}

protected function playPickupAnimation() 
{
	// create reward clone of the reward text and set its value
	_rewardTextObj = Instantiate(rewardText, transform.position, Quaternion.identity);
	
	// display our value as the text
	_rewardTextObj.GetComponent(tk2dTextMesh).text = "+" + value;
	
	// position tween
	var tweenProps :TweenParms = new TweenParms();
	tweenProps.Prop("position", _rewardTextObj.transform.position + (Vector3.up *30) );
	tweenProps.OnComplete(destroy);
	HOTween.To(_rewardTextObj.transform, 1, tweenProps);
	
	// alpha tween
	var textMesh : tk2dTextMesh = _rewardTextObj.GetComponent(tk2dTextMesh);
	var colorTo : Color = textMesh.color;
    colorTo.a = 0;
    
	tweenProps = new TweenParms();
	tweenProps.Prop("color", colorTo);
	tweenProps.OnUpdate(textMesh.Commit);
	HOTween.To(textMesh, 1, tweenProps);
	
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