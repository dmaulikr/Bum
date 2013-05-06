#pragma strict

var current : int = 100;
var total : int = 100;

public function isDead() :boolean 
{
	return current <= 0;
}

public function Heal( amount : int )
{
	current = Mathf.Min( current + amount, total);
	this.gameObject.SendMessage("OnHealthChange", current, SendMessageOptions.DontRequireReceiver);
	this.gameObject.SendMessage("OnHeal", current, SendMessageOptions.DontRequireReceiver);
}

public function Damage( amount : int )
{
	current = Mathf.Max( current - amount, 0);
	this.gameObject.SendMessage("OnHealthChange", current, SendMessageOptions.DontRequireReceiver);
	this.gameObject.SendMessage("OnDamage", current, SendMessageOptions.DontRequireReceiver);
}