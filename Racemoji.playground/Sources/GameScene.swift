import Cocoa
import SpriteKit

public class GameScene : SKScene {
    private let pointsLabel = SKLabelNode(fontNamed: "Helvetica Neue Light")
    private let engineSound = SKAudioNode(fileNamed: "engine.wav")
    private let player: SKLabelNode
    private let queue: SpawnQueue
    private let totalTime: TimeInterval
    private var initialTime: TimeInterval?
    
    private let trackHeights: [CGFloat] = [150, 250, 350]
    private let sepHeights: [CGFloat] = [210, 310]
    
    private var playerShown = false
    private var currentRow = 2 {
        didSet {
            assert((1...3).contains(currentRow), "row must be in range 1...3")
            if !playerShown {
                player.run(.move(to: CGPoint(x: 50, y: trackHeights[currentRow - 1]), duration: 0.5))
                playerShown = true
            } else if currentRow != oldValue {
                player.run(.move(to: CGPoint(x: 50, y: trackHeights[currentRow - 1]), duration: 0.15))
            }
        }
    }
    private var points = 0 {
        didSet {
            pointsLabel.text = "\(points) pts"
        }
    }
    
    public init(size: CGSize, totalTime: TimeInterval, queue: SpawnQueue) {
        self.queue = queue
        self.totalTime = totalTime
        self.player = SKLabelNode(text: "🏎")
        self.player.xScale = -1
        self.player.fontSize = 48
        self.player.position = CGPoint(x: -40, y: trackHeights[1])
        super.init(size: size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawTrack(height: CGFloat) {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: view!.frame.width, y: height))
        
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = .white
        shape.lineWidth = 3
        addChild(shape)
    }
    
    public override func didMove(to view: SKView) {
        backgroundColor = .black
        
        pointsLabel.position = CGPoint(x: view.frame.width - 20, y: view.frame.height - 40)
        pointsLabel.fontColor = .white
        pointsLabel.horizontalAlignmentMode = .right
        
        addChild(player)
        addChild(pointsLabel)
        
        addChild(engineSound)
        engineSound.run(.play())
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addBackgroundNode),
                SKAction.wait(forDuration: 0.8)
            ])
        ))
    }
    
    private var lastBackgroundTime: TimeInterval = 0
    private let buildings = ["🏢", "🏬", "🏛", "⛪️", "🕌", "⛩", "🎡"]
    private var buildingIndex = 0
    private func makeBackgroundNode(type: Int) -> SKNode {
        let node = SKLabelNode(text: buildings[buildingIndex])
        buildingIndex += 1
        if buildingIndex >= buildings.count { buildingIndex -= buildings.count }
        node.alpha = 0.5
        return node
    }
    
    private func makeLaneSplitter() -> SKNode {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 75, y: 0))
        
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = .lightGray
        shape.lineWidth = 4
        return shape
    }
    
    private func addBackgroundNode() {
        if isFinished { return }
        
        let node1 = makeBackgroundNode(type: 1)
        node1.position = CGPoint(x: view!.frame.width + 20, y: view!.frame.height - 40)
        addChild(node1)
        node1.run(.sequence([.moveTo(x: -20, duration: 5), .removeFromParent()]))
        
        let node2 = makeBackgroundNode(type: 0)
        node2.position = CGPoint(x: view!.frame.width + 20, y: 40)
        addChild(node2)
        node2.run(.sequence([.moveTo(x: -20, duration: 5), .removeFromParent()]))
        
        // TODO: add line drawing with SKShapeNode
        sepHeights.forEach { height in
            let lane = makeLaneSplitter()
            lane.position = CGPoint(x: view!.frame.width, y: height)
            addChild(lane)
            lane.run(.sequence([.moveBy(x: -view!.frame.width - 100, y: 0, duration: 3.25), .removeFromParent()]))
        }
    }
    
    private var isFinished = false
    public var lastLevel = false
    private func makeFinishedLabels(success: Bool = true) -> [SKNode] {
        let finish = SKLabelNode(text: success ? "Great 👍" : "Dead 💀")
        finish.fontSize = 72
        finish.horizontalAlignmentMode = .center
        finish.verticalAlignmentMode = .center
        finish.position = CGPoint(x: view!.frame.midX, y: view!.frame.midY + 20)
        
        let info = SKLabelNode(text: success ? (lastLevel ? "That's it! I hope you enjoyed 😉" : "You nailed it! Now try the next level") : "Let's try again!")
        finish.horizontalAlignmentMode = .center
        finish.verticalAlignmentMode = .center
        info.position = CGPoint(x: view!.frame.midX, y: view!.frame.midY - 100)
        
        if success {
            return [finish, info]
        } else {
            let crash = SKLabelNode(text: "🔥")
            crash.fontSize = 48
            crash.horizontalAlignmentMode = .center
            crash.verticalAlignmentMode = .center
            crash.position = player.position
            return [finish, info, crash]
        }
    }
    
    private var currentObstacles: [ObstacleEvent] = []
    
    /// Method for controlling the car.
    /// Gets called for lane updates
    public var handler: Handler = { _, _  in }
    
    public override func update(_ currentTime: TimeInterval) {
        func finish(success: Bool = true) {
            if isFinished { return }
            isFinished = true
            
            engineSound.run(.stop())
            run(.playSoundFileNamed(success ? "win.wav" : "crash.wav", waitForCompletion: false))
            makeFinishedLabels(success: success).forEach({ addChild($0) })
        }
        
        guard let initialTime = initialTime else {
            self.points = 0
            self.initialTime = currentTime
            return
        }
        let time = currentTime - initialTime
        
        let dangers = currentObstacles.filter { time - $0.appearTime < 3 }
            .map { Obstacle(type: $0.type, lane: $0.lane, distance: 3 - (time - $0.appearTime)) }
        
        dangers.filter { $0.distance <= 0.3 && $0.lane == currentRow }.forEach { passedDanger in
            switch passedDanger.type {
                
            case .money:
                points += 1
                run(.playSoundFileNamed("money.wav", waitForCompletion: false))
                break
                
            case .ghost:
                player.isHidden = true
                points = 0
                finish(success: false)
                break
            }
        }
        
        if !isFinished {
            handler(dangers, &currentRow)
        }
        
        if time >= totalTime || isFinished {
            if !isFinished {
                finish()
            }
            return
        }
        
        queue.next(by: time).forEach { it in
            currentObstacles.append(it)
            
            let node = it.makeNode()
            node.position = CGPoint(x: view!.frame.width + 20, y: trackHeights[it.lane - 1])
            addChild(node)
            node.run(.sequence([.moveTo(x: -20, duration: 3), .removeFromParent()]))
        }
    }
}

public let frame = CGRect(x: 0, y: 0, width: 640, height: 480)
