#pragma strict

enum WeaponType 
{ 
	melee, 		// weapon must be hit nearby enemies during attack animation
	ranged 		// shoots projectiles that damage enemies hit
};

var ammo :int = -1;
var range :int = 500;
var attackSpeed :float = 1.0;

var equippedSprite :tk2dAnimatedSprite;
var projectileSprite :tk2dAnimatedSprite;
var weaponType :WeaponType = WeaponType.melee;

private var _isAttacking :boolean;



public function GetIsAttacking():boolean
{
	return _isAttacking;
}


function Attack() {

	switch(this.weaponType) 
	{
		case WeaponType.melee:
			performMeleeAttack();
			break;
			
		case WeaponType.ranged:
			performRangedAttack();
			break;
	}	

	// here mark this object as attacking for the duration
	// of the attack speed.
	_isAttacking = true;
	yield WaitForSeconds(attackSpeed);
	_isAttacking = false;
}


private function performMeleeAttack()
{
	Debug.Log("melee attack");
}


private function performRangedAttack()
{
	Debug.Log("ranged attack");
}