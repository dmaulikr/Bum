#pragma strict
// this class keeps track of items collected and points earned throughout the level

var cansText : tk2dTextMesh;
var cashText : tk2dTextMesh;
var healthText : tk2dTextMesh;

// keeps track of cans collected
var cans :int = 0;

// keeps track of money earned
var cash :float = 0.0;

function Start () {
	
	updateCansText();
	updateCashText();
}

function Update () {

}

function addCans( amount : int )
{
	cans += amount;
	
	Debug.Log("cans: " + cans);
	
	// update the ui
	updateCansText();
}

function addCash( amount : float )
{
	cash += amount;
	
	Debug.Log("cash: " + cash);
	
	// update the ui
	updateCashText();
}


private function updateCashText()
{
	cashText.text = "" + cash;
	cashText.Commit();
}

private function updateCansText()
{
	cansText.text = "" + cans;
	cansText.Commit();
}