#pragma strict

protected var dampTime : float = 0.3; //offset from the viewport center to fix damping
private var velocity = Vector3.zero;
private var target : Transform;

function Awake()
{
	Debug.Log("camera w: " + camera.pixelWidth + ", h: + " + camera.pixelHeight);
}

function Start() 
{
	target = GameObject.Find("Player").transform;
}


function FixedUpdate() {
    if(target) {
        
        var delta :Vector3 = target.position - this.transform.position;
        
        // add offset to center character in the screen
        var offset :Vector3 = Vector3(480/4,320/3);
        delta -= offset;
        
        // don't move camera z
        
        delta.z = 0; 
        this.transform.position += delta * .2;
        
//        var r : Rect = camera.pixelRect;
//		print("Camera displays from " + r.xMin + " to " + r.xMax + " pixel");
		//Debug.Log("position: " + this.transform.position);
    }
}