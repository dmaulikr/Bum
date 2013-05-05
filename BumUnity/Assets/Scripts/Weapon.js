#pragma strict

enum WeaponType 
{ 
	melee, 		// weapon must be hit nearby enemies during attack animation
	gun 		// shoots projectiles that damage enemies hit
};

var ammo :int = -1;
var range :int = 500;
var attackSpeed :float = 1.0;

var equippedSprite :tk2dAnimatedSprite;
var projectileSprite :tk2dAnimatedSprite;

var weaponType :WeaponType = WeaponType.melee;


function Attack() {

}


function Start () {

}

function Update () {

}