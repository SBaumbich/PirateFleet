//
//  Protocols-Extensions.swift
//  Pirate Fleet
//
//  Modified by Scott Baumbich on 8/26/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

// MARK: - GridLocation (+ Hashable, Equatable)

extension GridLocation: Hashable {
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
}

func ==(lhs: GridLocation, rhs: GridLocation) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
