#pragma strict

var target : Transform;

function Update() {
    if(target) {
       
        transform.position.x = target.position.x - 1024;
        //transform.position.y = target.position.y - 768;
    }
}