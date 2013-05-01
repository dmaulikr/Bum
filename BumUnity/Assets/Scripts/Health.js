#pragma strict

var current : int = 100;
var total : int = 100;

public function isDead() :boolean 
{
	return current <= 0;
}

public function apply( amount : int )
{
	current += amount;
}

function Start () {

}

function Update () {

}