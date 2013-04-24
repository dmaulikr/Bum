#pragma strict

protected var dampTime : float = 0.05; //offset from the viewport center to fix damping
private var velocity = Vector3.zero;
var target : Transform;

function Update() {
    if(target) {
    	var origin : Vector3 = target.position;
        var point : Vector3 = this.transform.position;
        var delta : Vector3 = origin - camera.ViewportToWorldPoint(Vector3(1, 1, point.z));
                    
        var destination : Vector3 = origin + delta;
        destination.z = point.z; // don't move camera z
        
        this.transform.position = Vector3.SmoothDamp(this.transform.position, destination, 
                                                		velocity, dampTime);
		
		Debug.Log("position: " + this.transform.position);
    }
}