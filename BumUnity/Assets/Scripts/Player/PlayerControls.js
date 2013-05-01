#pragma strict

/* Configurable Variables =========================================================================== */

protected var sprite : tk2dAnimatedSprite;

// velocity applied to character to jump
protected var jumpForce : float = 200.0;

// velocity applied to character when moving
protected var runForce : float = 15.0;

// max speed allowed
protected var maxRunSpeed : float = 250.0; // points per frame

// factor applied to the x velocity when the character is not moving in any direction.
protected var brakeFactor : float = 0.95;

// factor applied to how much run force is applied to the character while in the air
protected var inAirVelocityReduction : float = .5;


/* Variables =========================================================================== */

enum MovementDirection { Left, Right, None }
private var _direction : MovementDirection;

private var _isTouchingFloor :boolean;

// this tracks when a jump has been triggered, but has not yet left the floor.
// it is then used to prevent other jumps from occuring and "double jumping"
private var _jumpStarted :boolean = false;

private var _isAttacking :boolean = false;

private var _framesElapsedSinceFloorTouch :int = 0;
private var _floorTouchFramePadding:int = 3;


/* GameObject =========================================================================== */

function Start () {
	sprite = this.gameObject.GetComponentInChildren(tk2dAnimatedSprite);
	_direction = MovementDirection.None;
}

function Update () {	
	
	if (Input.GetButtonDown("Left")) {
		Debug.Log("Left");
		setMovementDirection(MovementDirection.Left);
	}
	if (Input.GetButtonDown("Right")) {
		Debug.Log("Right");
		setMovementDirection(MovementDirection.Right);
	}
	
	updateDirection();
	updateAnimation();
}

function FixedUpdate() {
	
	_framesElapsedSinceFloorTouch++;

	//Debug.Log("velocity: " + this.rigidbody.velocity.x);
	updateMovement();
	
	// jump action
	if (Input.GetButtonDown("Jump")) {
		jump();
	}
	
	// attack 
	if (Input.GetButtonDown("Fire1") && !_isAttacking) {
		attack();
	}
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


private function jump() 
{
	if (_framesElapsedSinceFloorTouch < _floorTouchFramePadding && !_jumpStarted) {
		Debug.Log("jump");
		_jumpStarted = true;
		this.rigidbody.AddForce(Vector3(0,jumpForce,0), ForceMode.VelocityChange);
	}
}

private function attack() 
{
/*
	var force = 2000;
	
	// create the speed based on the direction of the character and the current velocity
	var speed : float = force * this.transform.localScale.x + Mathf.Abs(this.rigidbody.velocity.x);
	
	// create a bullet at the fire position
	var bullet : GameObject = Instantiate(projectile, firePosition.position, firePosition.rotation);
	
	// determine how much force
	var forceVec :Vector3 = Vector3(speed * Time.deltaTime,0,0);
	
	// here we offset the position by a minor amount to give it some randomness
	var position :Vector3 = firePosition.position + Vector3(Random.value*20,Random.value*20,0);
	
	bullet.rigidbody.AddForceAtPosition(forceVec, position, ForceMode.VelocityChange);
	
	Physics.IgnoreCollision(bullet.collider, collider);
	*/
	
	// here we set our attacking flag, wait for the attack animation time,
	// and then set attacking to false so we can attack again. 
	_isAttacking = true;
	sprite.Play("Attack");
	yield WaitForSeconds(.2);
	_isAttacking = false;
}


/* Collision Detection =========================================================================== */

function OnCollisionEnter( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_framesElapsedSinceFloorTouch = 0;
		_isTouchingFloor = true;
	}
}

function OnCollisionStay( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_framesElapsedSinceFloorTouch = 0;
		_isTouchingFloor = true;
	}
}

function OnCollisionExit( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_isTouchingFloor = false;
		_jumpStarted = false;
		_framesElapsedSinceFloorTouch = 0;
		Debug.Log("exit floor");
	}
}