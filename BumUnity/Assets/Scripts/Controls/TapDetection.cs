using UnityEngine;
using System;
using System.Collections;


// goals:
// send messages to any game object that wants to hear them.
// this should include touchesBegan, touchesMoved, and touchesEnded.
// additionally, it should determine the difference between taps,
// double taps, and drags. it is then up to the game object to respond
// to these messages. 
public class TapDetection : MonoBehaviour {
	
	private static String TOUCH_BEGAN = "TouchBegan";
	private static String TOUCH_MOVED = "TouchMoved";
	private static String TOUCH_ENDED = "TouchEnded";
	private static String TOUCH_CANCELED = "TouchCanceled";
	private static String TOUCH_STATIONARY = "TouchStationary";
	
	private Vector3 _lastMousePosition;
	
	void Update () {
		
		// send messages using Touches on touch devices
		if (Application.platform == RuntimePlatform.IPhonePlayer || Application.platform == RuntimePlatform.Android) {
			foreach (Touch touch in Input.touches) {
				Ray ray = Camera.main.ScreenPointToRay(touch.position);
				RaycastHit hit = new RaycastHit();
				
				if (Physics.Raycast(ray, out hit)) {
					GameObject hitObject = hit.transform.gameObject;
					
					if(touch.phase == TouchPhase.Began) {
	            		hitObject.SendMessage(TOUCH_BEGAN, SendMessageOptions.DontRequireReceiver);
		            }
		            else if (touch.phase == TouchPhase.Moved) {
		            	hitObject.SendMessage(TOUCH_MOVED, SendMessageOptions.DontRequireReceiver);
		            }
		            else if (touch.phase == TouchPhase.Ended) {
		            	hitObject.SendMessage(TOUCH_ENDED, SendMessageOptions.DontRequireReceiver);
		            }
		            else if (touch.phase == TouchPhase.Canceled) {
		            	hitObject.SendMessage(TOUCH_CANCELED, SendMessageOptions.DontRequireReceiver);
		            }
		            else if (touch.phase == TouchPhase.Stationary) {
		            	hitObject.SendMessage(TOUCH_STATIONARY, SendMessageOptions.DontRequireReceiver);
		            }
					
					Debug.Log("touch on " + hitObject.name);
				}
			}
		}
		// send messages using the mouse position
		else {
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			Array hits = Physics.RaycastAll(ray);
			foreach(RaycastHit hit in hits) {
				
				GameObject hitObject = hit.transform.gameObject;
				
				if (Input.GetMouseButtonDown(0)) {
					hitObject.SendMessage(TOUCH_BEGAN, SendMessageOptions.DontRequireReceiver);
				}
				else if (Input.GetMouseButtonUp(0)) {
					hitObject.SendMessage(TOUCH_ENDED, SendMessageOptions.DontRequireReceiver);
				}
				else if (Input.GetMouseButton(0)) {
					if (Input.mousePosition != _lastMousePosition) {
						hitObject.SendMessage(TOUCH_MOVED, SendMessageOptions.DontRequireReceiver);
					}
					else {
						hitObject.SendMessage("TouchStationary", SendMessageOptions.DontRequireReceiver);
					}
				}
			}
			_lastMousePosition = Input.mousePosition;
		}
	}
}
