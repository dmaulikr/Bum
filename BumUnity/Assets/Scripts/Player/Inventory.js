#pragma strict
// this class keeps track of items collected and points earned throughout the level

private var _cansText : tk2dTextMesh;
private var _cashText : tk2dTextMesh;
private var _healthText : tk2dTextMesh;

// keeps track of cans collected
var cans :int = 0;

// keeps track of money earned
var cash :float = 0.0;

function Start () {
	
	_cansText = GameObject.Find("Cans Text").GetComponent(tk2dTextMesh);
	_cashText = GameObject.Find("Cash Text").GetComponent(tk2dTextMesh);
	_healthText = GameObject.Find("Health Text").GetComponent(tk2dTextMesh);
	
	updateCansText();
	updateCashText();
}

function Update () {

}

function addCans( amount : int )
{
	cans += amount;
	
	Debug.Log("cans: " + cans);
	
	updateCansText();
}

function addCash( amount : float )
{
	cash += amount;
	
	Debug.Log("cash: " + cash);
	
	updateCashText();
}


private function updateCashText()
{
	_cashText.text = "" + cash;
	_cashText.Commit();
}

private function updateCansText()
{
	_cansText.text = "" + cans;
	_cansText.Commit();
}