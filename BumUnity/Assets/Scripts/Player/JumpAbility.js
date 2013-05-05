#pragma strict

public var jumpForce :float = 200.0;

// this tracks when a jump has been triggered, but has not yet left the floor.
// it is then used to prevent other jumps from occuring and "double jumping"
private var _jumpStarted :boolean = false;

private var _framesElapsedSinceFloorTouch :int = 0;

private var _floorTouchFramePadding:int = 3;

public function Jump()
{
	if (_framesElapsedSinceFloorTouch < _floorTouchFramePadding && !_jumpStarted) {
		_jumpStarted = true;
		this.rigidbody.AddForce(Vector3(0,jumpForce,0), ForceMode.VelocityChange);
	}
}


function FixedUpdate()
{
	_framesElapsedSinceFloorTouch++;
}


/* Collision Detection =========================================================================== */

function OnCollisionEnter( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_framesElapsedSinceFloorTouch = 0;
	}
}

function OnCollisionStay( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_framesElapsedSinceFloorTouch = 0;
	}
}

function OnCollisionExit( collision:Collision )
{
	if (collision.gameObject.tag == "Floor") {
		_jumpStarted = false;
		_framesElapsedSinceFloorTouch = 0;
	}
}