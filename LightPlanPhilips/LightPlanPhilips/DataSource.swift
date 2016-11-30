//
//  DataSource.swift
//  LightPlanPhilips
//
//  Created by Mark Aptroot on 10-11-16.
//  Copyright © 2016 The App Academy. All rights reserved.
//

import Foundation

class DataSource: NSObject {
  static let sharedInstance = DataSource()
  private override init() {}
  var myHome: Home = Home()
  
  func createData() {
    myHome.rooms.append(Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2a", name: "Living Room", file: "living.png"))
    myHome.rooms.append(Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2b", name: "Kitchen", file: "kitchen.png"))
    myHome.rooms.append(Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2c", name: "Bedroom", file: "bedroom.png"))
    myHome.rooms.append(Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2d", name: "Open space", description: "Definable areas", file: "Open space.png"))
    myHome.rooms[0].assignedBulbs.append(Bulb(coordinateX: 0, coordinateY: 0))
    myHome.rooms[0].assignedBulbs.append(Bulb(coordinateX: 100, coordinateY: 100))
    myHome.rooms[0].assignedBulbs.append(Bulb(coordinateX: -100, coordinateY: -100))

    // create 2 bulbs and add to home (unassigned bulbs)
    myHome.unassignedBulbs.append(Bulb())
    myHome.unassignedBulbs.append(Bulb())
  }
  
  
  
  // get room
  func getRoom(roomId: String) -> Room? {
//    return myHome.rooms.filter{ $0.id == roomId}
    var foundRoom: Room?
    
    for room in myHome.rooms {
      if room.id == roomId {
        foundRoom = room
      }
    }
    return foundRoom
  }
  
  // get group
  func getGroup(groupId: String) -> Group? {
    var foundgroup: Group?
    
    for room in myHome.rooms {
      for group in room.groups {
        if group.id == groupId {
          foundgroup = group
        }
      }
    }
    return foundgroup
  }
  
  
  func getBulb(bulbId: String) -> Bulb? {
   
    for bulb in getBulbsInHome() {
      if bulb.id == bulbId {
        return bulb
      }
    }
    
    for room in myHome.rooms {
      for assignedBulb in room.assignedBulbs {
        if assignedBulb.id == bulbId {
          return assignedBulb
        }
        for group in room.groups {
          for assignedBulb in group.assignedBulbs {
            if assignedBulb.id == bulbId {
              return assignedBulb
            }
          }
        }
      }
    }
    return nil
  }
  
  
  
  // add bulb to room
  func addBulbToRoom(bulb: Bulb, roomId: String) {
    // find room in home
    for room in myHome.rooms {
      if room.id == roomId {
        // add bulb to room
        room.assignedBulbs.append(bulb)
      }
    }
  }
  
  
  //  // add bulb to group
  //  func addBulbToGroup(bulb: Bulb, groupId: String) {
  //
  //  }
  //
  
  // move bulb from room and move to house
  func moveBulbFromRoomToHome(bulbId: String, roomId: String) {
    var bulbcounter:Int = 0
    // find room in home
    for room in myHome.rooms {
      if room.id == roomId {
        // find bulb in room
        for assignedBulb in room.assignedBulbs {
          if assignedBulb.id == bulbId {
            // remove bulb from room
            room.assignedBulbs.remove(at: bulbcounter)
            // add bulb to home
            myHome.unassignedBulbs.append(assignedBulb)
          }
        }
        bulbcounter += 1
      }
    }
  }
  
  // move bulb from group and move to room
  func moveBulbFromGoupToRoom(bulbId: String, groupId: String) {
    var bulbCounter: Int = 0
    // find group in home
    for room in myHome.rooms {
      for group in room.groups {
        if group.id == groupId {
          // find bulb in group
          for assignedBulb in group.assignedBulbs {
            if assignedBulb.id == bulbId {
              // remove bulb from group
              group.assignedBulbs.remove(at: bulbCounter)
              // add bulb to room
              room.assignedBulbs.append(assignedBulb)
            }
            bulbCounter += 1
          }
        }
      }
    }
  }
  
  func moveBulbFromRoomToGroup(bulbId: String, groupId: String) {
    
    var bulbCounter: Int
    
    // find group in home
    for room in myHome.rooms {
      for group in room.groups {
        if group.id == groupId {
          bulbCounter = 0
          for assignedBulb in room.assignedBulbs {
            if assignedBulb.id == bulbId {
              // remove bulb from room
              room.assignedBulbs.remove(at: bulbCounter )
              // add bulb to group
              group.assignedBulbs.append(assignedBulb)
            }
            bulbCounter += 1
          }
        }
      }
    }
  }
  
  
  // create group and add to room
  func addGroupToRoom(roomId: String, group: Group) {
    // find room in home
    for room in myHome.rooms {
      if room.id == roomId {
        room.groups.append(group)
      }
    }
  }
  
  // remove group,if bulbs are still in group, they will be moved to room
  func removeGroup(groupId: String){
    var groupCounter: Int
    
    for room in myHome.rooms {
      // reset groupcounter
      groupCounter = 0
      for group in room.groups {
        if group.id == groupId {
          // check if bulbs are in group and move to room
          for assignedBulb in group.assignedBulbs {
            room.assignedBulbs.append(assignedBulb)
          }
          // remove room
          room.groups.remove(at: groupCounter)
        }
        groupCounter += 1
      }
    }
  }
  
  // get rooms in home
  func getRooms() -> [Room] {
    var rooms: [Room] = []
    
    // find all rooms in home
    for room in myHome.rooms {
      rooms.append(room)
    }
    
    return rooms
  }
  
  // get groups in room
  func getGroupsInRoom(roomId: String) -> [Group] {
    var groups: [Group] = []
    
    // find room in house
    for room in myHome.rooms {
      if room.id == roomId {
        for group in room.groups {
          groups.append(group)
        }
      }
    }
    return groups
  }
  
  
  // get bulbs in room
  func getBulbsInRoom(roomId: String) -> [Bulb] {
    // find room in house
    for room in myHome.rooms {
      if room.id == roomId {
        return room.assignedBulbs
      }
    }
    return []
  }
  
  // get bulbs in group
  func getBulbsInGroup(groupId: String) -> [Bulb] {
    var bulbs: [Bulb] = []
    
    // check all rooms in house for group
    for room in myHome.rooms{
      for group in room.groups {
        if group.id == groupId {
          for assignedBulb in group.assignedBulbs {
            bulbs.append(assignedBulb)
          }
        }
      }
    }
    return bulbs
  }
  
  
  // get unassigned bulbs in home
  func getBulbsInHome() -> [Bulb] {
    return myHome.unassignedBulbs
  }
}

