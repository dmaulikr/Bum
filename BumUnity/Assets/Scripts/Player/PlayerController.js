#pragma strict

/* Configurable Variables =========================================================================== */

protected var sprite : tk2dAnimatedSprite;

// velocity applied to character when moving
protected var runForce : float = 15.0;

// max speed allowed
protected var maxRunSpeed : float = 250.0; // points per frame

// factor applied to the x velocity when the character is not moving in any direction.
protected var brakeFactor : float = 0.95;

// factor applied to how much run force is applied to the character while in the air
protected var inAirVelocityReduction : float = .5;

/* Constants =========================================================================== */

enum MovementDirection { Left, Right, None }

/* Variables =========================================================================== */

private var _direction : MovementDirection;

private var _isTouchingFloor :boolean;
private var _isAttacking :boolean = false;


/* Components =========================================================================== */

private var _jump :JumpAbility;
private var _movement :Movement;

/* Getters/Setters =========================================================================== */

public function GetDirection():MovementDirection
{
	return _direction;
}

public function GetIsTouchingFloor():boolean
{
	return _isTouchingFloor;
}

public function GetIsAttacking():boolean
{
	return _isAttacking;
}


/* GameObject =========================================================================== */

function Start () {

	// get components
	_jump = this.gameObject.GetComponent(JumpAbility);
	_movement = this.gameObject.GetComponent(Movement);
	
	// get child components
	sprite = this.gameObject.GetComponentInChildren(tk2dAnimatedSprite);
	
	// set defaults
	_direction = MovementDirection.None;
}

function Update () {	
	updateDirection();
	updateAnimation();
}

function FixedUpdate() {

	//Debug.Log("velocity: " + this.rigidbody.velocity.x);
	updateMovement();
}


public function MoveLeft()
{
	setMovementDirection(MovementDirection.Left);
}


public function MoveRight()
{
	setMovementDirection(MovementDirection.Right);
}

public function Jump()
{
	_jump.Jump();
}


public function Attack()
{
	if (_isAttacking) return;
	attack();
}


/* Updates =========================================================================== */

private function updateDirection() {
	if (_direction == MovementDirection.Left) {
		if (sprite.scale.x > 0) sprite.FlipX();
	}
	else if (_direction == MovementDirection.Right) {
		if (sprite.scale.x < 0) sprite.FlipX();
	}
}


private function updateMovement() 
{	
	// apply the braking speed if the character is not moving in a particular direction
	if (_direction == MovementDirection.None && Mathf.Abs(this.rigidbody.velocity.x) > 0.1) {
		this.rigidbody.velocity.x *= brakeFactor;
	}
	else {
	
		var direction :int = _direction == MovementDirection.Left ? -1 : 1;
		var force :float = direction * runForce;
		var currentSpeed :float = this.rigidbody.velocity.x;
		var targetSpeed :float = maxRunSpeed * direction;
		
		if (!_isTouchingFloor) force *= inAirVelocityReduction;
		
		if (Mathf.Abs(currentSpeed) < Mathf.Abs(targetSpeed)) {
			this.rigidbody.AddForce( Vector3(force, 0, 0), ForceMode.VelocityChange);
		}
	}
}


private function updateAnimation() 
{
	var anim :String;
	
	if (_isAttacking) {
		anim = "Attack";
	}
	else if (!_isTouchingFloor) {
		anim = "Jump";
	}
	else if (Mathf.Abs(this.rigidbody.velocity.x) >= 100) {
		anim = "Run";
	}
	else {
		anim = "Idle";
	}
	
	var clip:tk2dSpriteAnimationClip = sprite.GetClipByName(anim);
	if (sprite.CurrentClip != clip && clip != null) {
		//Debug.Log("playing clip: " + anim);
		sprite.Play(clip, 0.0);
	}
	
	// adjust the speed of the animation based on how much input we're getting
	// this gives the character a more natural looking animation
	var animationSpeed :float = Mathf.Abs(this.rigidbody.velocity.x) / maxRunSpeed;
	sprite.ClipFps = sprite.CurrentClip.fps * animationSpeed;
}



/* Actions =========================================================================== */


// begins automatic movement in a direction
public function startMovement() 
{
	setMovementDirection(MovementDirection.Right);
}


public function setMovementDirection( direction : MovementDirection )
{
	_direction = direction;
}

private function attack() 
{
	if (_isAttacking) return;
	
	_isAttacking = true;
	
	var direction :Vector3 = _direction == MovementDirection.Left ? Vector3.left : Vector3.right;
	this.rigidbody.AddForce( direction * 100, ForceMode.VelocityChange);
	
	sprite.Play("Attack");
	
	yield WaitForSeconds(.5);
	_isAttacking = false;
}


/* Collision Detection =========================================================================== */

function OnCollisionEnter( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_isTouchingFloor = true;
	}
}

function OnCollisionStay( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_isTouchingFloor = true;
	}
}

function OnCollisionExit( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_isTouchingFloor = false;
	}
}