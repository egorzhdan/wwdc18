import SpriteKit
import PlaygroundSupport
/*:
 # Avoiding ghosts
 
 This is a more interesting level – you cannot just drive straight all the way!
 
 You'll need to look for obstacles and avoid the ghosts. But there won't be many of them (yet 👻).
 */
let r = level2()

r.game.handler = { obstacles, lane in
    // Let's write a trivial code which completes the task
    // We'll improve it later!
    
    let ghosts1 = obstacles.filter { $0.type == .ghost && $0.lane == 1 }
    let ghosts2 = obstacles.filter { $0.type == .ghost && $0.lane == 2 }
    let ghosts3 = obstacles.filter { $0.type == .ghost && $0.lane == 3 }
    
    if ghosts1.isEmpty { lane = 1; return }
    if ghosts2.isEmpty { lane = 2; return }
    if ghosts3.isEmpty { lane = 3; return }
    
    let nearest1 = ghosts1.sorted { $0.distance < $1.distance }.first!
    let nearest2 = ghosts2.sorted { $0.distance < $1.distance }.first!
    let nearest3 = ghosts3.sorted { $0.distance < $1.distance }.first!
    
    let maxDistance = max(nearest1.distance, nearest2.distance, nearest3.distance)
    
    switch maxDistance {
    case nearest1.distance:
        lane = 1
        break
    case nearest2.distance:
        lane = 2
        break
    case nearest3.distance:
        lane = 3
        break
    default: fatalError()
    }
    
    // There is a lot of copy-pasted code here, and it isn't good,
    // because it is easy to make a mistake and difficult to fix it.
    // It's time to rewrite it!
}

PlaygroundPage.current.liveView = r.view
//: [Next](@next)
