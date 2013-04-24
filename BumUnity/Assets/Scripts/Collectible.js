#pragma strict

public var type :String;
public var value :int;

function Awake () {
	this.gameObject.tag = "Collectible";
}

function Update () {

}

/* Collision Detection =========================================================================== */

function OnTriggerEnter( collision:Collider )
{
	if (collision.gameObject.tag == "Player") {
		print("hit player");
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