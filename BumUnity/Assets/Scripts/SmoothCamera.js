#pragma strict

protected var dampTime : float = 0.3; //offset from the viewport center to fix damping
private var velocity = Vector3.zero;
var target : Transform;

function Awake () {
	tk2dSystem.CurrentPlatform = "1x";
}

function Update() {
    if(target) {
        
        var delta :Vector3 = target.position - this.transform.position;
        
        // add offset to center character in the screen
        var offset :Vector3 = Vector3(-camera.pixelWidth * .5, -camera.pixelHeight * .25, 0);
        delta += offset;
        
        // don't move camera z
        
        delta.z = 0; 
        this.transform.position += delta * .2;
		
		Debug.Log("position: " + this.transform.position);
    }
}