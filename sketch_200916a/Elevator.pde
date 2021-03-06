class Elevator { 
  
  //arraylist for the 
  ArrayList<Job> serviceQueue = new ArrayList<Job>();
  
  ArrayList<Person> cabPassengers = new ArrayList<Person>();
 
  //elevator cab capacity and how many passengers are currently in the cab
  int capacity; 
  int currentLoad;
  
  Job currentTask = new Job();
  
  
  ElevatorStat elevatorStat = new ElevatorStat(); 
  
  //which direction is the cab currently headed
  Direction direction = Direction.STATIONARY; 
  
  //how long the elevator door takes to open
  int doorTime; //in seconds
  
  //variables for the elevator shaft housing the cab
  int elevatorShaftHeight = 0; 
  int elevatorShaftWidth = 0; 
  
  int floorFrames = 0; 
  
  //speed of elevator
  float floorsPerSecond = 0.0;
  
  //location of the elevator shaft
  int posX; 
  int posY;
  
  //represents the last floor the elevator has fully passed, or is currently stopped at. 
  //ie. this value would be 4 if it was halfway inbetween floor 4 and 5, and would switch to 5 when it fully reaches floor 5
  int floor = 1; 
  
  //status of the elevator
  boolean busy = false; 
  
  int currentDestination = 0; 
 
 
  float sidewaysDoorSpeed = 0.5;
  
  int doorAnimationTime; 
  
  //variables for the cab dimensions and location
  float cabPosX; 
  float cabPosY;
  
  float cabPos2X; 
  float originalCabPosX; 
  
  int cabWidth = 20; 
  int cabHeight = 10;
  
  
  int jobsCompleted = 0; 
  int framesSpentDoingNothing = 0; 
  
  boolean doorOpening = false; 
  boolean doorClosing = false; 
  boolean doorClosed  = true;
  boolean extraPassengerOpen = false; 
  boolean extraPassengersStop = false; 
  boolean extraPickupAble = false; 
  boolean bottomDoorOpen = false;
  boolean justDropped = false; 
  boolean extraStop = false; 
  boolean multiDoorIssue = false; 
  boolean doneOnFloor = false;
  
  boolean justExpelled = false; 
  boolean waitingInPlace = false; 
  
  boolean specialDoorStop = false;
  boolean specialStopFloor = false;
  
  boolean checkedForExtraStop = false; 
  boolean openedDoorFloor = false; 
  
  boolean needInstruction = false; 
  
  //where the elevator is in the animation process of opening the doors
  int animationFrame = 0; 
  //how many frames the entire animation should take
  int maxAnimationFrame = 0; 
  
  
  //door opening stopwatch
  StopWatch doorOpeningTimer = new StopWatch(); 
  
  //door closing stopwatch
  StopWatch doorClosingTimer = new StopWatch();
  
  Elevator(int cap, int load, int door, int sh, int sw, float floorsPerSec, int positionX, int positionY, int cabPositionX, int cabPositionY) { 
    capacity = cap; 
    currentLoad = load;
    doorTime = door; 
    elevatorShaftWidth = sw; 
    elevatorShaftHeight = sh; 
    floorsPerSecond = floorsPerSec; 
    posX = positionX; 
    posY = positionY;
    cabPosX = cabPositionX; 
    cabPosY = cabPositionY;
    cabPos2X = cabPositionX; 
    originalCabPosX = cabPositionX; 
    direction = Direction.STATIONARY;
  }
  
  //getters and setters start
  void setShaftHeight(int h) {
    elevatorShaftHeight = h; 
  }
  
  void setShaftWidth(int w) {
    elevatorShaftWidth = w; 
  }
  
  void setCabPosX(int cpX) {
    cabPosX = cpX; 
  }
  
  void setCabPosY(int cpY) {
    cabPosY = cpY; 
  }
  
  void setExtraPickupAble(boolean b) {
    extraPickupAble = b; 
  }
  
  
  //tickers
  void tickMaxPass() { if(!(capacity>=20)) { capacity++; } }
  void tickMaxPassDown() { if(!(capacity==1)) { capacity--; } }
  
  
  void tickCabSpeed() { if(!(floorsPerSecond == 2.000)) { floorsPerSecond = floorsPerSecond + 0.001; } }
  void tickCabSpeedDown() { if(!(floorsPerSecond == 0.1)) { floorsPerSecond = floorsPerSecond - 0.001; } }
  
  
  void tickDoorSpeed() { if(!(doorTime>=20.000)) { doorTime = doorTime + 1; } }
  void tickDoorSpeedDown() { if(!(doorTime<=1.000)) { doorTime = doorTime - 1; } }
  
  ArrayList<Job> getServiceQueue() { return serviceQueue; }
  ArrayList<Person> getCabPassengers() { return cabPassengers; }
  int getFloor() { return floor; }
  int getPassengerNum() { return currentLoad; }
  int getCapacity() { return capacity; }
  float getCabSpeed() { return floorsPerSecond; }
  int getDoorSpeed() { return doorTime; }
  boolean getStatus() { return busy; }
  Job getCurrentTask() { return currentTask; }
  int getDestination() { return currentDestination; }
  Direction getDirection() { return direction; }
  boolean getExtraPickupAble() { return extraPickupAble; }
  ElevatorStat getElevatorStat() { return elevatorStat; }
  
  boolean getNeedInstruction() { return needInstruction; }
  void setJustDropped(boolean b) {
    justDropped = b; 
  }
  void setNeedInstruction(boolean b) {
    needInstruction = b; 
  }
  void setDestination(int floor) {
    currentDestination = floor; 
  }
  
  void setExtraPassengerStop(boolean e) {
    extraPassengersStop = e; 
  }
  void setDirection(Direction d) {
    direction = d; 
  }
  //getters and setters end
  
  
  //draws the elevator and the shaft that this elevator exists in 
  void drawMe() {
    
   
    rectMode(CENTER); 
    
    
    //first draw the shaft the the elevator exists in 
    drawShaft(); 
    
    //second draw the cab that represents the elevator
    drawCab();
    
    
    
    
  }
  
  void addPassenger(Person p) {
    cabPassengers.add(p);
    
  }
  
  void acceptRequest (Job task, int whichElevator) {
    task.setWhichElevatorComing(whichElevator); 
    serviceQueue.add(task);
    
  }
  
  //long thin rectangle to house the elevator
  void drawShaft() {
    
    rectMode(CENTER); 
    fill(#B7B7AE); 
    
    rect(posX,posY,elevatorShaftWidth,elevatorShaftHeight); 
    
    
  }
  
  
  //draw the cab representing the elevator
  void drawCab() {
    
    System.out.println("Drawing cab: " + doorOpening + " " + doorClosing); 
    
    if(doorOpening) { //door is in the process of opening
      
       rectMode(CENTER); 
       fill(#58584B); 
       
       cabPos2X = cabPos2X - sidewaysDoorSpeed;
       cabPosX = cabPosX + sidewaysDoorSpeed;
       
       rect(cabPosX, cabPosY, cabWidth/2, cabHeight);
       rect(cabPos2X, cabPosY, cabWidth/2, cabHeight);
       
      
    }  else if (doorClosing) {  //door is in the process of closing
       
       rectMode(CENTER); 
       fill(#58584B); 
       
       cabPos2X = cabPos2X + sidewaysDoorSpeed; 
       cabPosX = cabPosX - sidewaysDoorSpeed; 
       
       rect(cabPosX, cabPosY, cabWidth/2, cabHeight);
       rect(cabPos2X, cabPosY, cabWidth/2, cabHeight);
      
      
    }  else { //elevator is in transit, door is closed shut
    
      rectMode(CENTER); 
      fill(#58584B); 
    
      rect(cabPosX, cabPosY, cabWidth, cabHeight);
    
    }
    
  }
  
 
  
  void animateDoorOpening() {
    
    
  }
  
  
  void checkFloor() {
    int initialFloor = floor; 
    
    
    //slightly larger on purpose
    if ( (cabPosY <= 960) & (cabPosY > 945)) { floor = 1; }
    //purposeful gap -> makes sure elevators go all the way to the bottom of the floor as would a normal elevator 
    //(had an issue where elevators were stopping when the bottom of the cab hit the top of the first floor, 
    //essentially meaning they were still on the second floor while opening the cab for the end of the trip)
    
    
   
    if ( (cabPosY <= 935) & (cabPosY > 920)) { floor = 2; }
    if ( (cabPosY <= 920) & (cabPosY > 905)) { floor = 3; }
    if ( (cabPosY <= 905) & (cabPosY > 890)) { floor = 4; }
    if ( (cabPosY <= 890) & (cabPosY > 875)) { floor = 5; }
    if ( (cabPosY <= 875) & (cabPosY > 860)) { floor = 6; }
    if ( (cabPosY <= 860) & (cabPosY > 845)) { floor = 7; }
    if ( (cabPosY <= 845) & (cabPosY > 830)) { floor = 8; }
    if ( (cabPosY <= 830) & (cabPosY > 815)) { floor = 9; }
    if ( (cabPosY <= 815) & (cabPosY > 800)) { floor = 10; }
    if ( (cabPosY <= 800) & (cabPosY > 785)) { floor = 11; }
    if ( (cabPosY <= 785) & (cabPosY > 770)) { floor = 12; }
    if ( (cabPosY <= 770) & (cabPosY > 755)) { floor = 13; }
    if ( (cabPosY <= 755) & (cabPosY > 740)) { floor = 14; }
    if ( (cabPosY <= 740) & (cabPosY > 725)) { floor = 15; }
    if ( (cabPosY <= 725) & (cabPosY > 710)) { floor = 16; }
    if ( (cabPosY <= 710) & (cabPosY > 695)) { floor = 17; }
    if ( (cabPosY <= 695) & (cabPosY > 680)) { floor = 18; }
    if ( (cabPosY <= 680) & (cabPosY > 665)) { floor = 19; }
    if ( (cabPosY <= 665) & (cabPosY > 650)) { floor = 20; }
    if ( (cabPosY <= 650) & (cabPosY > 635)) { floor = 21; }
    if ( (cabPosY <= 635) & (cabPosY > 620)) { floor = 22; }
    if ( (cabPosY <= 620) & (cabPosY > 605)) { floor = 23; }
    if ( (cabPosY <= 605) & (cabPosY > 590)) { floor = 24; }
    if ( (cabPosY <= 590) & (cabPosY > 575)) { floor = 25; }
    if ( (cabPosY <= 575) & (cabPosY > 560)) { floor = 26; }
    if ( (cabPosY <= 560) & (cabPosY > 545)) { floor = 27; }
    if ( (cabPosY <= 545) & (cabPosY > 530)) { floor = 28; }
    if ( (cabPosY <= 530) & (cabPosY > 515)) { floor = 29; }
    if ( (cabPosY <= 515) & (cabPosY > 500)) { floor = 30; }
    if ( (cabPosY <= 500) & (cabPosY > 485)) { floor = 31; }
    //if ( (cabPosY <= 495) & (cabPosY > 480)) { floor = 31; }
   // if ( (cabPosY <= 480) & (cabPosY > 465)) { floor = 32; }
    //if ( (cabPosY <= 465) & (cabPosY > 450)) { floor = 33; }
   // if ( (cabPosY <= 450) & (cabPosY > 435)) { floor = 34; }
    //if ( (cabPosY <= 420) & (cabPosY > 405)) { floor = 36; }
   // if ( (cabPosY <= 405) & (cabPosY > 390)) { floor = 37; }
   // if ( (cabPosY <= 390) & (cabPosY > 375)) { floor = 38; }
   // if ( (cabPosY <= 375) & (cabPosY > 360)) { floor = 39; }
   // if ( (cabPosY <= 360) & (cabPosY > 345)) { floor = 40; }
    
    if(initialFloor == floor) {
      
    } else {
      openedDoorFloor = false;  
      //specialDoorStop = false;
      specialStopFloor = false;
      
      doneOnFloor = false;
      checkedForExtraStop = false;
    }
    
    
  }
  
  //moves the cab based on its speed for one frame
  void moveUp() {
    waitingInPlace = false;
    direction = Direction.UP;
    
   // System.out.println(cabPosY);
    
   // System.out.println("Moving an elevator"); 
    
    if(!(floor == 40) & (!bottomDoorOpen) & (!doorOpening) & (!doorClosing)) {   
      cabPosY = cabPosY - floorsPerSecond;
    
      checkFloor();
    }
    
    
  }
  
  //moves the cab based on its speed for one frame
  void moveDown() {
    waitingInPlace = false;
    direction = Direction.DOWN; 
    
    if(!(floor == 1) & (!bottomDoorOpen) & (!doorOpening) & (!doorClosing)) {
      cabPosY = cabPosY + floorsPerSecond; 
      
      checkFloor();
    }
    
    
    //openedDoorFloor = false;
  }
  
  
  //determines the orientation of the elevator and decides whether to call moveUP() or moveDown()
  void move(int frameRate, int elevatorAlgorithm) { 
    
   if(elevatorAlgorithm == 0) {
     //System.out.println("Current framerate: " + frameRate); 
     //if this elevator has a Job to do
      if(serviceQueue.size() >= 1 & (!extraPassengersStop)) {
      
        //if the job in the service queue at 0 has not been accepted yet
        if(serviceQueue.get(0).getPickedUp() == false) {
          //the person that has this job has not been picked up yet, so set the current destination to the persons pickup location
          currentDestination = serviceQueue.get(0).getPickup();
       // System.out.println(currentDestination);
        } else if (serviceQueue.get(0).getPickedUp() == true) {
          //the person that had that job has just been picked up, set the current destination to the destination of the job
          currentDestination = serviceQueue.get(0).getDestination();
        
        }
        //there are some extra passengers to pick up (not this value will only ever be true when a non covid-19 algorithm has been chosen)
      } else if (serviceQueue.size() >= 1 & (extraPassengersStop)) {
      
         currentDestination = floor; 
       
      
      
        //no job to do right now
      } else {
        direction = Direction.STATIONARY; 
      
      
      }
    
    
  
    
      //if the current floor is less than the destination floor
      if(floor < currentDestination & serviceQueue.size() >=1) {
      
        //if we are in the case where we are at the bottom of the shaft opening the door
         if(bottomDoorOpen) {
          bottomDoorOpen = false;
          System.out.println("Calling open door at the bottom of the shaft"); 
          openDoor(frameRate);
        }
      
        //if the door is currently opening
        if(doorOpening) {
          //then the door is currently opening, need to tick the stopwatch keeping track of this elevators door opening animation
          boolean openAnimationDone;
          openAnimationDone = doorOpeningTimer.tickTime();
        
          //the door has opened all the way
          if(openAnimationDone) {
            // System.out.println("Closing door");       
            closeDoor();
          
          } else {
            //System.out.println("Animating door opening a bit more");
          
          
          }
        
        }
      
        if(doorClosing) { 
           boolean closingAnimationDone; 
           closingAnimationDone = doorClosingTimer.tickTime();
      
          //the door has closed all the way
          if(closingAnimationDone) {
          
            doorClosing = false;
            bottomDoorOpen = false;
            doorOpening = false;
            extraPassengersStop = false; 
            
            //??? then check to see if there are more jobs in the service queue, if so update the destination of this elevator?
            //if(serviceQueue.size() >= 1) { 
              //currentDestination = serviceQueue.get(0).getPickup(); 
           // }
          
            if (elevatorAlgorithm == 1) { needInstruction = true; }
            //needInstruction = true;
            //System.out.println("Done closing the door");
          } else {
            //System.out.println("Animating the door closing a bit more");
        
          }
        
        
        
        }
      
        moveUp();
      
      
      
        //if the current floor is larger then the destination floor
      } else if (floor > currentDestination & serviceQueue.size() >=1) {
        moveDown();
    
      //the elevator has reached its destination -> open the door and wait for it to close again before continuing
      } else if (((floor == currentDestination)&(!doorClosing) & serviceQueue.size() >=1)) {
      
    
        //if the door isn't already currently opening
        if(!(doorOpening)) {
        
          //if the door is currently closing
          if(doorClosing) {
            
          
            } else { 
        
              System.out.println("Calling openDoor(int frameRate);");
             
              openDoor(frameRate);
          
            }
        
        
        
        } else if (doorOpening) {
          //then the door is currently opening, need to tick the stopwatch keeping track of this elevators door opening animation
          boolean openAnimationDone;
          openAnimationDone = doorOpeningTimer.tickTime();
        
          //the door has opened all the way
          if(openAnimationDone) {
            //System.out.println("Closing door");       
            closeDoor();
          
          } else {
         // System.out.println("Animating door opening a bit more");
          
          
          }
        
        }
    
      } else if ((floor == currentDestination)&(doorClosing)) {
      
        //System.out.println("Passenger should get in the cab, and remove their job, passenger should be added to elevator cab, elevator cab should move onto its next destination");
        doorOpening = false; 
      
        boolean closingAnimationDone; 
        closingAnimationDone = doorClosingTimer.tickTime();
      
        //the door has closed all the way
        if(closingAnimationDone) {
          needInstruction = true;
          doorClosing = false;
          bottomDoorOpen = false;
          doorOpening = false;
          extraPassengersStop = false; 
         // System.out.println("Done closing the door");
        } else {
          //System.out.println("Animating the door closing a bit more");
        
        }
        
      }
      
      
    } else if (elevatorAlgorithm == 1) {
      
      //set the current destination
      //----------------------------
      
      //if the elevator has a job
      if(serviceQueue.size() >= 1) {
        waitingInPlace = false; 
        //if the job has been picked up
        if(serviceQueue.get(0).pickedUp) {
          
          currentDestination = serviceQueue.get(0).getDestination(); 
          
        } else { //job has not been picked up
        
          currentDestination = serviceQueue.get(0).getPickup();
          
        }
        
        
      }
      
      //finish setting the current destination 
      //------------------------------



      //determine the correct movement function to call
      //-----------------------------
      if(serviceQueue.size() >= 1) {
      if(currentDestination > floor & !specialStopFloor) {
        moveUp(); 
        
      } else if (currentDestination < floor & !specialStopFloor) {
        moveDown();
        
      } else if (currentDestination == floor || specialStopFloor) {
        
       
        if( (!doorOpening & !doorClosing & !openedDoorFloor & !waitingInPlace)) {
          System.out.println("calling open door");
          openDoor(frameRate);  
          
          if(specialStopFloor) { currentDestination = floor; }
          
          
          //specialStopFloor = false;
          
        }
        
        //System.out.println(doorOpening);
        
        if(doorOpening) {
          boolean status = doorOpeningTimer.tickTime(); 
          
          if(status) { //the door is done opening
            
            closeDoor(); 
            
          }
          
        }
        
        
        if(doorClosing) {
          boolean status = doorClosingTimer.tickTime();
          
          
          if(serviceQueue.size() >= 1) {
            if(status) { //the door is done closing
            
            
            
              if(serviceQueue.get(0).pickedUp & floor == currentDestination) {
                serviceQueue.get(0).droppedOff = true; 
                justDropped = true;
                needInstruction = true; 
                doorClosing = false;
              
              } else {
            
            
                currentDestination = serviceQueue.get(0).getDestination(); 
                serviceQueue.get(0).pickedUp = true; 
                needInstruction = true; 
                doorClosing = false; 
              
              
              }
            }
          
          
          }
        }
        
        
        
        
        
      }
      }
      //finish correct movement function call
      //----------------------------
      



      
     
    } else if (elevatorAlgorithm == 2) {
      
     
      //
      
      
      
      //set the current destination
      //----------------------------
      
      //if the elevator has a job
      if(serviceQueue.size() >= 1) {
        waitingInPlace = false; 
        //if the job has been picked up
        if(serviceQueue.get(0).pickedUp) {
          System.out.println("Job has already been picked up");
          currentDestination = serviceQueue.get(0).getDestination(); 
          
        } else { //job has not been picked up
          System.out.println("Job has not been picked up"); 
          currentDestination = serviceQueue.get(0).getPickup();
          
        }
        
        
      }
      
      //finish setting the current destination 
      //------------------------------



      //determine the correct movement function to call
      //-----------------------------
      if(serviceQueue.size() >= 1) {
      if(currentDestination > floor & !specialStopFloor) {
        moveUp(); 
        
      } else if (currentDestination < floor & !specialStopFloor) {
        moveDown();
        
      } else if (currentDestination == floor || specialStopFloor) {
        
       
        if( (!doorOpening & !doorClosing & !openedDoorFloor & !waitingInPlace)) {
          System.out.println("calling open door");
          openDoor(frameRate);  
          
          if(specialStopFloor) { currentDestination = floor; }
          
          
          //specialStopFloor = false;
          
        }
        
        //System.out.println(doorOpening);
        
        if(doorOpening) {
          boolean status = doorOpeningTimer.tickTime(); 
          
          if(status) { //the door is done opening
            
            closeDoor(); 
            
          }
          
        }
        
        
        if(doorClosing) {
          boolean status = doorClosingTimer.tickTime();
          
          
          if(serviceQueue.size() >= 1) {
            if(status) { //the door is done closing
            
            
            
              if(serviceQueue.get(0).pickedUp & floor == currentDestination) {
                serviceQueue.get(0).droppedOff = true; 
                justDropped = true;
                needInstruction = true; 
                doorClosing = false;
              
              } else {
            
            
                currentDestination = serviceQueue.get(0).getDestination(); 
                serviceQueue.get(0).pickedUp = true; 
                needInstruction = true; 
                doorClosing = false; 
              
              
              }
            }
          
          
          }
        }
        
        
        
        
        
      }
      }
      //finish correct movement function call
      //----------------------------
      


      
      
      
      
    }  //until here
    
  
  }
  
  void setAtBottom() {
    bottomDoorOpen = true; 
  }
  
 
  
  //this will only be called once per opening of the door
  void openDoor(int frameRate) {
    //specialDoorStop = false;
    elevatorStat.tickDoorOpen();
    
    System.out.println("Inside openDoor(int frameRate)");
    
    openedDoorFloor = true; 
    
    direction = Direction.STATIONARY; 
    
    if(elevatorAlgorithm == 2) {
      //direction = Direction.OPEN; 
    }
    
    //calculate how many frames the timer should go on for 
    int totalDoorTime = doorTime*frameRate; 
    doorAnimationTime = totalDoorTime; 
    
    if(elevatorAlgorithm == 2) { justDropped = false; }
    doorOpening = true;
    doorClosing = false;
    doorOpeningTimer = new StopWatch(0,0,totalDoorTime,"doorOpening");
    
    //cabPosX = cabPosX - 7; 
    justExpelled = false;
    //cabPos2X = cabPos2X + 7;
    
  }
  
  
  //this will only be called once per closing of the door
  void closeDoor() {
  //  System.out.println("Inside closeDoor()");
    
    elevatorStat.tickClosedDoor(); 
    
    doorOpening = false; 
    doorClosing = true; 
    //if(elevatorAlgorithm == 2) { justDropped = false; }
    
    doorClosingTimer = new StopWatch(0,0,doorAnimationTime,"doorClosing");
    
    //openedDoorFloor = false;
    
    justExpelled = false; 
    
    
    
    
    
  }
  
  
  
  
  
}
