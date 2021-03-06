//
//  ControlCenter.swift
//  Pirate Fleet
//
//  Modified by Scott Baumbich on 9/2/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

struct GridLocation {
    let x: Int
    let y: Int
}

struct Ship {
    let length: Int
    let location: GridLocation
    let isVertical: Bool
    let isWooden: Bool
    

// TODO: Add the computed property, cells.
    var cells: [GridLocation] {
        get {
            // Hint: These two constants will come in handy
            let start = self.location
            let end: GridLocation = ShipEndLocation(self)
            
            // Hint: The cells getter should return an array of GridLocations.
            var occupiedCells = [GridLocation]()
            
            
            if isVertical {
                var yValue = start.y
                let xValue = start.x
                while yValue <= end.y {
                    let gridLoc = GridLocation(x: xValue, y: yValue)
                    occupiedCells.append(gridLoc)
                    yValue += 1
                }
            } else {
                let yValue = start.y
                var xValue = start.x
                while xValue <= end.x {
                    let gridLoc = GridLocation(x: xValue, y: yValue)
                    occupiedCells.append(gridLoc)
                    xValue += 1
                }
            }
            return occupiedCells
        }
    }
    
    var hitTracker: HitTracker
// TODO: Add a getter for sunk. Calculate the value returned using hitTracker.cellsHit.
    var sunk: Bool {
        get {
            
            var isSunk = false
            for shipCell in cells {
                if hitTracker.cellsHit[shipCell] == true {
                    isSunk = true
                } else {
                    isSunk = false
                    break
                }
            }
            return isSunk
        }
    }

// TODO: Add custom initializers
    init(length: Int, location: GridLocation, isVertical: Bool) {
        self.length = length
        self.hitTracker = HitTracker()
        self.location = location
        self.isVertical = isVertical
        self.isWooden = false
    }
    
    init(length: Int, location: GridLocation, isVertical: Bool, isWooden: Bool) {
        self.length = length
        self.hitTracker = HitTracker()
        self.location = location
        self.isVertical = isVertical
        self.isWooden = isWooden
    }
}

// TODO: Change Cell protocol to PenaltyCell and add the desired properties
protocol PenaltyCell {
    var location: GridLocation { get }
    var guaranteesHit: Bool { get }
    var penaltyText: String { get set }
}

// TODO: Adopt and implement the PenaltyCell protocol
struct Mine: PenaltyCell {
    let location: GridLocation
    var guaranteesHit: Bool
    var penaltyText: String
    
    init(location: GridLocation, penaltyText: String) {
        self.location = location
        self.penaltyText = penaltyText
        guaranteesHit = false
    }
    
    init(location: GridLocation, penaltyText: String, guaranteesHit: Bool) {
        self.location = location
        self.penaltyText = penaltyText
        self.guaranteesHit = guaranteesHit
    }
}

// TODO: Adopt and implement the PenaltyCell protocol
struct SeaMonster: PenaltyCell {
    let location: GridLocation
    let guaranteesHit: Bool = true
    var penaltyText: String
}

class ControlCenter {
    
    func placeItemsOnGrid(_ human: Human) {
        
        
        
        // * Correction Made * //
        
        let smallShip = Ship(length: 2, location: GridLocation(x: 3, y: 4), isVertical: false)
        human.addShipToGrid(smallShip)
        print("SS : \(smallShip.cells)")
        
        
        
        
        let mediumShip1 = Ship(length: 3, location: GridLocation(x: 0, y: 0), isVertical: false, isWooden: false)
        human.addShipToGrid(mediumShip1)
        print("MS1: \(mediumShip1.cells)")
        
        let mediumShip2 = Ship(length: 3, location: GridLocation(x: 3, y: 1), isVertical: false, isWooden: false)
        human.addShipToGrid(mediumShip2)
        print("MS2: \(mediumShip2.cells)")
        
        let largeShip = Ship(length: 4, location: GridLocation(x: 6, y: 3), isVertical: true, isWooden: false)
        human.addShipToGrid(largeShip)
        print("LS2: \(largeShip.cells)")
        
        let xLargeShip = Ship(length: 5, location: GridLocation(x: 7, y: 2), isVertical: true, isWooden: true)
        human.addShipToGrid(xLargeShip)
        print("XLS: \(xLargeShip.cells)")
        
        let mine1 = Mine(location: GridLocation(x: 6, y: 0), penaltyText: "BOOM!")
        human.addMineToGrid(mine1)
        
        let mine2 = Mine(location: GridLocation(x: 3, y: 3), penaltyText: "BANG", guaranteesHit: true)
        human.addMineToGrid(mine2)
        
        let seamonster1 = SeaMonster(location: GridLocation(x: 5, y: 6), penaltyText: "Oh Nooo...")
        human.addSeamonsterToGrid(seamonster1)
        
        let seamonster2 = SeaMonster(location: GridLocation(x: 2, y: 2), penaltyText: "Uh-Ohh")
        human.addSeamonsterToGrid(seamonster2)
    }
    
    func calculateFinalScore(_ gameStats: GameStats) -> Int {
        
        var finalScore: Int
        
        let sinkBonus = (5 - gameStats.enemyShipsRemaining) * gameStats.sinkBonus
        let shipBonus = (5 - gameStats.humanShipsSunk) * gameStats.shipBonus
        let guessPenalty = (gameStats.numberOfHitsOnEnemy + gameStats.numberOfMissesByHuman) * gameStats.guessPenalty
        
        finalScore = sinkBonus + shipBonus - guessPenalty
        
        return finalScore
    }
}
