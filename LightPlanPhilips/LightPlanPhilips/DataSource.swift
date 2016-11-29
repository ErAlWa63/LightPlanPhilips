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
  var myHome: Home = Home()
  
  
  private override init() {}
  
  
  func createData() {
    // create room and add to house
    var room = Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2a", name: "WoonkamerA")
    myHome.rooms.append(room)
     room = Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2b", name: "WoonkamerB")
    myHome.rooms.append(room)
     room = Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2c", name: "WoonkamerC")
    myHome.rooms.append(room)
     room = Room(id: "b5e23af6-f955-4802-9c89-990e71a48f2d", name: "WoonkamerD")
    myHome.rooms.append(room)
    
    // create 3 bulbs and add to room
    var  bulb: Bulb
    bulb = Bulb()
    bulb.positionX = 0
    bulb.positionY = 0
    room.bulbs.append(bulb)
    bulb = Bulb()
    bulb.positionX = 100
    bulb.positionY = 100
    room.bulbs.append(bulb)
    bulb = Bulb()
    bulb.positionX = -100
    bulb.positionY = -100
    room.bulbs.append(bulb)
    
    // create 2 bulbs and add to home (unassigned bulbs)
    bulb = Bulb()
    myHome.bulbs.append(bulb)
    bulb = Bulb()
    myHome.bulbs.append(bulb)
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
      for bulb in room.bulbs {
        if bulb.id == bulbId {
          return bulb
        }
        for group in room.groups {
          for bulb in group.bulbs {
            if bulb.id == bulbId {
              return bulb
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
        room.bulbs.append(bulb)
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
        for bulb in room.bulbs {
          if bulb.id == bulbId {
            // remove bulb from room
            room.bulbs.remove(at: bulbcounter)
            // add bulb to home
            myHome.bulbs.append(bulb)
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
          for bulb in group.bulbs {
            if bulb.id == bulbId {
              // remove bulb from group
              group.bulbs.remove(at: bulbCounter)
              // add bulb to room
              room.bulbs.append(bulb)
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
          for bulb in room.bulbs {
            if bulb.id == bulbId {
              // remove bulb from room
              room.bulbs.remove(at: bulbCounter )
              // add bulb to group
              group.bulbs.append(bulb)
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
          for bulb in group.bulbs {
            room.bulbs.append(bulb)
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
    var bulbs: [Bulb] = []
    
    // find room in house
    for room in myHome.rooms {
      if room.id == roomId {
        for bulb in room.bulbs {
          bulbs.append(bulb)
        }
      }
    }
    return bulbs
  }
  
  // get bulbs in group
  func getBulbsInGroup(groupId: String) -> [Bulb] {
    var bulbs: [Bulb] = []
    
    // check all rooms in house for group
    for room in myHome.rooms{
      for group in room.groups {
        if group.id == groupId {
          for bulb in group.bulbs {
            bulbs.append(bulb)
          }
        }
      }
    }
    return bulbs
  }
  
  
  // get unassigned bulbs in home
  func getBulbsInHome() -> [Bulb] {
    var bulbs: [Bulb] = []
    
    for bulb in myHome.bulbs{
      bulbs.append(bulb)
    }
    return bulbs
  }
}

