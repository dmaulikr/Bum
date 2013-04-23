#pragma strict

var damage : float = 50;
var duration : float = 1.5;
var explosion :GameObject;

function Start () {
	// destroy after a certain amount of time
	Destroy( this.gameObject, duration);
}

function Update () {

}

function OnCollisionEnter( collision : Collision ) 
{
	if (collision.gameObject.tag == "Enemy") {
	
		// do damage to the object's health
		collision.gameObject.SendMessage("damage", damage);
		
		// show a impact animation
		var average:Vector3  = Vector3(0,0,0);
		for (var contact:ContactPoint in collision.contacts) {
			average += contact.point;
		}
		var ln :int = collision.contacts.length;
		var collisionPoint :Vector3 = Vector3(average.x/ln, average.y/ln, average.z/ln);
		var impact :GameObject = Instantiate(explosion, collisionPoint, Quaternion.identity);
		Destroy(impact, impact.particleSystem.duration);
		
		// remove the projectile
		Destroy(this.gameObject);
	}
}