import SpriteKit

public enum ObstacleType : CustomStringConvertible {
    case money
    case ghost
    
    public var description: String {
        switch self {
        case .money: return "💰"
        case .ghost: return "👻"
        }
    }
}

/// Representation of an obstacle to be spawned
/// at a certain time of the scene
public struct ObstacleEvent : Equatable {
    /// The moment of time since the beginning of the scene
    /// when the obstacle should appear on the screen
    public let appearTime: TimeInterval
    
    /// Number of lane, must be 1 or 2 or 3
    public let lane: Int
    
    /// Type of the obstacle
    public let type: ObstacleType
    
    public init(appearTime: TimeInterval, lane: Int, type: ObstacleType) {
        self.appearTime = appearTime
        self.lane = lane
        self.type = type
    }
    
    /// Makes a SpriteKit node displaying the obstacle
    public func makeNode() -> SKNode {
        return SKLabelNode(text: type.description)
    }
    
    public static func ==(lhs: ObstacleEvent, rhs: ObstacleEvent) -> Bool {
        return lhs.appearTime == rhs.appearTime && lhs.lane == rhs.lane && lhs.type == rhs.type
    }
}

/// Represents an already spawned obstacle,
/// ready to be presented to the user
public struct Obstacle : Equatable {
    public let type: ObstacleType
    public let lane: Int
    public let distance: Double
    
    public static func ==(lhs: Obstacle, rhs: Obstacle) -> Bool {
        return lhs.type == rhs.type && lhs.lane == rhs.lane && lhs.distance == rhs.distance
    }
}

/// Callback type for controlling the car with custom logic
public typealias Handler = (_ dangers: [Obstacle], _ row: inout Int) -> Void

/// Represents the order in which obstacles appear on the screen
public class SpawnQueue {
    private let raw: [ObstacleEvent]
    private var nextIndex = 0
    
    public init(obstacles: [ObstacleEvent]) {
        raw = obstacles.sorted(by: { $0.appearTime < $1.appearTime })
    }
    
    func next(by time: TimeInterval) -> [ObstacleEvent] {
        if nextIndex >= raw.count { return [] }
        let result = [ObstacleEvent](raw.dropFirst(nextIndex).prefix(while: { $0.appearTime <= time }))
        nextIndex += result.count
        return result
    }
}
