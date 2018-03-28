import SpriteKit
import PlaygroundSupport
/*:
 # Many ghosts
 
 More ghosts! Now there will be more than one on a lane 👻.
 */
let r = level3()

r.game.handler = { obstacles, lane in
    // Split all the ghosts by lanes:
    let nearest = (1...3).map { lane in (lane, obstacles.filter({ $0.lane == lane && $0.type == .ghost }).first) }
    
    // Figure out the safest lane – with the biggest distance to nearest ghost:
    lane = nearest.max { ($0.1?.distance ?? .infinity) < ($1.1?.distance ?? .infinity) }!.0
}

PlaygroundPage.current.liveView = r.view
//: [Next](@next)
