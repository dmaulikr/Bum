#pragma strict

// velocity applied to character to jump
var jumpForce : float = 10.0;

// velocity applied to character when moving
var runForce : float = 50.0;

// max speed allowed
var maxRunSpeed : float = 20.0; // points per frame

// factor applied to the x velocity when the character is not moving in any direction.
var brakeFactor : float = 0.95;

// factor applied to how much run force is applied to the character while in the air
var inAirVelocityReduction : float = .5;

var idleAnimation :OTAnimation;
var runAnimation :OTAnimation;
var jumpAnimation :OTAnimation;
var attackAnimation :OTAnimation;

var firePosition :Transform;

var projectile :GameObject;

enum MovementDirection { Left, Right, None }
private var _direction : MovementDirection;
private var _sprite :OTAnimatingSprite;

private var _isTouchingFloor :boolean = true;
private var _isAttacking :boolean = false;

// this tracks when a jump has been triggered, but has not yet left the floor.
// it is then used to prevent other jumps from occuring and "double jumping"
private var _jumpStarted :boolean = false;


/* GameObject =========================================================================== */

function Start() {
	_sprite = this.GetComponentInChildren(OTAnimatingSprite);
}


// use standard update to handle non-rigidbody work
function Update () {

	// character direction
	updateDirection();
	
	// character animation
	updateAnimation();
}

// used fixed update when working with rigid bodies
function FixedUpdate () {	
	
	// character movement
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
	var inputValue :float = Input.GetAxis("Horizontal");
	if (inputValue < 0) {
		_direction = MovementDirection.Left;
		if (transform.localScale.x > 0) transform.localScale.x *= -1;
	}
	else if (inputValue > 0) {
		_direction = MovementDirection.Right;
		if (transform.localScale.x < 0) transform.localScale.x *= -1;
	}
	else {
		_direction = MovementDirection.None;
	}
}

private function updateMovement() 
{
	var moveSpeed :float = Input.GetAxis("Horizontal");
	
	// apply the braking speed if the character is not moving in a particular direction
	if (_direction == MovementDirection.None && Mathf.Abs(this.rigidbody.velocity.x) > 0.1) {
		this.rigidbody.velocity.x *= brakeFactor;
	}
	else {
	
		var force = moveSpeed * runForce * Time.fixedDeltaTime;
		
		// reduce for in air jumping
		if (!_isTouchingFloor) force *= inAirVelocityReduction;
		
		var maxSpeed = moveSpeed < 0 ? -1 * maxRunSpeed : maxRunSpeed;
		var sum = this.rigidbody.velocity.x + force;
		
		if ((_direction == MovementDirection.Left && sum > maxSpeed) 
		|| (_direction == MovementDirection.Right && sum < maxSpeed)){
			this.rigidbody.AddForce(Vector3(force, 0, 0), ForceMode.VelocityChange);
		}
	}
}


private function updateAnimation() 
{
	var anim :OTAnimation;
	
	if (_isAttacking) {
		anim = attackAnimation;
	}
	else if (!_isTouchingFloor) {
		anim = jumpAnimation;
	}
	else if (Mathf.Abs(this.rigidbody.velocity.x) >= 1) {
		anim = runAnimation;
	}
	else {
		anim = idleAnimation;
	}
	
	if (_sprite.animation != anim) {
		_sprite.animation = anim;
		_sprite.PlayLoop();
	}
	// adjust the speed of the animation based on how much input we're getting
	// this gives the character a more natural looking animation
	_sprite.speed = Mathf.Max( .25, Mathf.Abs(Input.GetAxis("Horizontal")));
}



/* Actions =========================================================================== */

private function jump() 
{
	if (_isTouchingFloor && !_jumpStarted) {
		Debug.Log("jump");
		_jumpStarted = true;
		this.rigidbody.AddForce(Vector3(0,jumpForce,0), ForceMode.VelocityChange);
	}
}

private function attack() 
{
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
	
	// here we set our attacking flag, wait for the attack animation time,
	// and then set attacking to false so we can attack again. 
	_isAttacking = true;
	yield WaitForSeconds(attackAnimation.duration);
	_isAttacking = false;
}


function GameObjectDied() 
{
	Debug.Log("Player Died");
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
		_jumpStarted = false;
		Debug.Log("exit floor");
	}
}