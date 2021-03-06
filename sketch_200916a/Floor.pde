class Floor {
  
  int floorID;
  
  ArrayList<Room> rooms = new ArrayList<Room>();
  
  Floor() {
    
    
  }
  
  Floor(int id) {
   floorID = id; 
    
  }
  
  Floor(ArrayList<Room> roomsList, int id) {
    rooms = roomsList; 
    floorID = id;
    
    
  }
  
  void addRoom(Room r) {
   rooms.add(r); 
    
  }
  
  void addRoomsList(ArrayList<Room> roomsList) {
    rooms = roomsList; 
  }
  
  ArrayList<Room> getRoomsList() {
    return rooms; 
  }
  
  void addTenant(Person p, int room) {
   
    //if the requested room has not yet been created, create it and add to the backing arraylist
    //note that this if statement will only be run on each new tenant ONCE per room
    if(rooms.size() <= room) {
      rooms.add(new Room(new Coordinate(room,floorID)));
      
    }
    
    rooms.get(room).addTenant(p,room);
    
  }
  
  
  Room getRoom(int r) {
    
    
    if(r<=rooms.size()) {
      return rooms.get(r);
    }
    return new Room();
    
  }
  
  
  Room getRoomFromIndex(int r) {
    
    return rooms.get(r);
    
    
  }
  
  boolean getFloorStatus() {
    
    boolean returnValue = false; 
    
    for(int i = 0; i < rooms.size(); i++) {
      
      //if any room on the floor has someone waiting, then the whole floor has a waiting status
      if(rooms.get(i).determineStatus()) {
        return true; 
      }
      
    }
    
    return returnValue; 
    
  }
  
  
}
