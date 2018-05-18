
import de.voidplus.leapmotion.*;
import java.util.*;

HashSet<PVector> fingerTips, distalBones, interBones, proxBones, metaBones, handPos;

// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================

// ======================================================
// 1. Callbacks

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}


void draw_Leap() {

  //int fps = leap.getFrameRate();
  
  fingerTips = new HashSet<PVector>();
  distalBones = new HashSet<PVector>();
  interBones = new HashSet<PVector>();
  proxBones = new HashSet<PVector>();
  metaBones = new HashSet<PVector>();
  handPos = new HashSet<PVector>();
  
  for (Hand hand : leap.getHands ()) {
   

    // ==================================================
    // 2. Hand

    //int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    //PVector handStabilized     = hand.getStabilizedPosition();
    //PVector handDirection      = hand.getDirection();
    //PVector handDynamics       = hand.getDynamics();
    //float   handRoll           = hand.getRoll();
    //float   handPitch          = hand.getPitch();
    //float   handYaw            = hand.getYaw();
    //boolean handIsLeft         = hand.isLeft();
    //boolean handIsRight        = hand.isRight();
    //float   handGrab           = hand.getGrabStrength();
    //float   handPinch          = hand.getPinchStrength();
    //float   handTime           = hand.getTimeVisible();
    //PVector spherePosition     = hand.getSpherePosition();
    //float   sphereRadius       = hand.getSphereRadius();
    
    handPos.add(handPosition);

    // --------------------------------------------------
    // Drawing
   // hand.draw();

//    println("Z positions: ", handPosition);

    // ==================================================
    // 3. Arm

//    if (hand.hasArm()) {
//      Arm     arm              = hand.getArm();
//      float   armWidth         = arm.getWidth();
//      PVector armWristPos      = arm.getWristPosition();
//      PVector armElbowPos      = arm.getElbowPosition();
//    }
    

//    // ==================================================
//    // 4. Finger

//    Finger  fingerThumb        = hand.getThumb();
//    // or                        hand.getFinger("thumb");
//    // or                        hand.getFinger(0);

//    Finger  fingerIndex        = hand.getIndexFinger();
//    // or                        hand.getFinger("index");
//    // or                        hand.getFinger(1);

//    Finger  fingerMiddle       = hand.getMiddleFinger();
//    // or                        hand.getFinger("middle");
//    // or                        hand.getFinger(2);

//    Finger  fingerRing         = hand.getRingFinger();
//    // or                        hand.getFinger("ring");
//    // or                        hand.getFinger(3);

//    Finger  fingerPink         = hand.getPinkyFinger();
//    // or                        hand.getFinger("pinky");
//    // or                        hand.getFinger(4);

    

    for (Finger finger : hand.getFingers()) {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      //int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      //PVector fingerStabilized = finger.getStabilizedPosition();
      //PVector fingerVelocity   = finger.getVelocity();
      //PVector fingerDirection  = finger.getDirection();
      //float   fingerTime       = finger.getTimeVisible();

      // ------------------------------------------------
      // Drawing

      // Drawing:
      // finger.draw();  // Executes drawBones() and drawJoints()
       //finger.drawBones();
       //ellipse(fingerPosition.x, fingerPosition.y, 5, 5);
       fingerTips.add(fingerPosition);

       
      // finger.drawJoints();

      // ------------------------------------------------
      // Selection

      switch(finger.getType()) {
      case 0:
        // System.out.println("thumb");
        break;
      case 1:
        // System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }



/*

      ditalBones.add(finger.getDistalBone().position);
//      interBones.add();
//      proxBones.add();
//      metaBones.add();
*/
      // ================================================
      // 5. Bones
      // --------
      // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);
      
      distalBones.add(boneDistal.getNextJoint());
      distalBones.add(boneDistal.getPrevJoint());

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);
      
      interBones.add(boneIntermediate.getNextJoint());
      interBones.add(boneIntermediate.getPrevJoint());

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);
      
      proxBones.add(boneProximal.getNextJoint());
      proxBones.add(boneProximal.getPrevJoint());

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      metaBones.add(boneMetacarpal.getNextJoint());
      metaBones.add(boneMetacarpal.getPrevJoint());


      // ------------------------------------------------
      // Touch emulation

      //int     touchZone        = finger.getTouchZone();
      //float   touchDistance    = finger.getTouchDistance();

      //switch(touchZone) {
      //case -1: // None
      //  break;
      //case 0: // Hovering
      //  // println("Hovering (#" + fingerId + "): " + touchDistance);
      //  break;
      //case 1: // Touching
      //  // println("Touching (#" + fingerId + ")");
      //  break;
      //}
    }


    // ==================================================
    // 6. Tools

    //for (Tool tool : hand.getTools()) {
    //  int     toolId           = tool.getId();
    //  PVector toolPosition     = tool.getPosition();
    //  PVector toolStabilized   = tool.getStabilizedPosition();
    //  PVector toolVelocity     = tool.getVelocity();
    //  PVector toolDirection    = tool.getDirection();
    //  float   toolTime         = tool.getTimeVisible();

    //  // ------------------------------------------------
    //  // Drawing:
    //  // tool.draw();

    //  // ------------------------------------------------
    //  // Touch emulation

    //  int     touchZone        = tool.getTouchZone();
    //  float   touchDistance    = tool.getTouchDistance();

    //  switch(touchZone) {
    //  case -1: // None
    //    break;
    //  case 0: // Hovering
    //    // println("Hovering (#" + toolId + "): " + touchDistance);
    //    break;
    //  case 1: // Touching
    //    // println("Touching (#" + toolId + ")");
    //    break;
    //  }
    //}
  }


  // ====================================================
  // 7. Devices

  //for (Device device : leap.getDevices()) {
  //  float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
  //  float deviceVericalViewAngle = device.getVerticalViewAngle();
  //  float deviceRange = device.getRange();
  //}
}