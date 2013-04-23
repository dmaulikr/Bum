#pragma strict

var owner :GameObject;
var currentHealth : int = 100;
var maxHealth : int = 100;

private var _isDead :boolean = false;

function heal( amount : int ) 
{
	currentHealth += amount;
	if (currentHealth > maxHealth) currentHealth = maxHealth;
	if (_isDead && currentHealth > 0) _isDead = false;
}

function damage( amount : int )
{
	Debug.Log("Took " + amount + " points of damage!");
	currentHealth -= amount;
	if (currentHealth < 0) {
		currentHealth = 0;
	}
	
	if (currentHealth == 0) {
		_isDead = true;
		Debug.Log("DEAD");
		owner.SendMessage("GameObjectDied");
	}
}

function isDead() : boolean
{
	return _isDead;
}