import Cocoa
import SpriteKit

public struct Level {
    public let game: GameScene
    public let view: SKView
    
    public init(game: GameScene, view: SKView) {
        self.game = game
        self.view = view
    }
}

// Sorry for the mess in this source file.
// I moved all the rounds description here from each of the playground pages sources
// because Xcode was sometimes unable to compile them.

public func level1() -> Level {
    let sceneView = SKView(frame: frame)
    let scene = GameScene(size: sceneView.frame.size, totalTime: 7, queue: SpawnQueue(obstacles: [
        ObstacleEvent(appearTime: 1, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 2, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.5, lane: 3, type: .money),
    ]))
    
    sceneView.presentScene(scene)
    return Level(game: scene, view: sceneView)
}

public func level2() -> Level {
    let sceneView = SKView(frame: frame)
    let scene = GameScene(size: sceneView.frame.size, totalTime: 16, queue: SpawnQueue(obstacles: [
        ObstacleEvent(appearTime: 1, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 1.25, lane: 2, type: .money),
        ObstacleEvent(appearTime: 4, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 7, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 11, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 13, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 10, lane: 3, type: .money),
    ]))
    
    sceneView.presentScene(scene)
    return Level(game: scene, view: sceneView)
}

public func level3() -> Level {
    let sceneView = SKView(frame: frame)
    let scene = GameScene(size: sceneView.frame.size, totalTime: 16, queue: SpawnQueue(obstacles: [
        ObstacleEvent(appearTime: 1, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.1, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 1.2, lane: 3, type: .money),
        
        ObstacleEvent(appearTime: 5, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 5.15, lane: 2, type: .money),
        ObstacleEvent(appearTime: 5.2, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 6, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 8, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 9, lane: 3, type: .money),
        
        ObstacleEvent(appearTime: 11, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 11.5, lane: 3, type: .ghost),
        ObstacleEvent(appearTime: 14, lane: 1, type: .ghost),
    ]))
    
    sceneView.presentScene(scene)
    return Level(game: scene, view: sceneView)
}

public func level4() -> Level {
    let sceneView = SKView(frame: frame)
    let scene = GameScene(size: sceneView.frame.size, totalTime: 13, queue: SpawnQueue(obstacles: [
        ObstacleEvent(appearTime: 1.0, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.2, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.4, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.6, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 1.8, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 2.0, lane: 2, type: .ghost),
        
        ObstacleEvent(appearTime: 1.5, lane: 1, type: .money),
        ObstacleEvent(appearTime: 1.75, lane: 1, type: .money),
        ObstacleEvent(appearTime: 2.0, lane: 1, type: .ghost),
        
        ObstacleEvent(appearTime: 3.0, lane: 3, type: .ghost),
        ObstacleEvent(appearTime: 3.2, lane: 3, type: .ghost),
        ObstacleEvent(appearTime: 3.4, lane: 3, type: .money),
        ObstacleEvent(appearTime: 3.6, lane: 3, type: .ghost),
        ObstacleEvent(appearTime: 3.8, lane: 3, type: .ghost),
        ObstacleEvent(appearTime: 4.0, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 3.3, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 3.3, lane: 1, type: .money),
        
        ObstacleEvent(appearTime: 4.0, lane: 2, type: .money),
        ObstacleEvent(appearTime: 4.0, lane: 1, type: .ghost),
        
        ObstacleEvent(appearTime: 5.0, lane: 2, type: .ghost),
        ObstacleEvent(appearTime: 5.0, lane: 1, type: .ghost),
        
        ObstacleEvent(appearTime: 5.5, lane: 1, type: .money),
        
        ObstacleEvent(appearTime: 6.1, lane: 1, type: .ghost),
        ObstacleEvent(appearTime: 6.0, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 6.8, lane: 3, type: .money),
        ObstacleEvent(appearTime: 7.0, lane: 3, type: .money),
        ObstacleEvent(appearTime: 8.0, lane: 3, type: .ghost),
        
        ObstacleEvent(appearTime: 9.5, lane: 3, type: .money),
        ObstacleEvent(appearTime: 10, lane: 2, type: .money),
    ]))
    scene.lastLevel = true
    
    sceneView.presentScene(scene)
    return Level(game: scene, view: sceneView)
}
