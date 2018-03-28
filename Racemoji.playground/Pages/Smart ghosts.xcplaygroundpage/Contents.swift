import SpriteKit
import PlaygroundSupport
/*:
 # Smart ghosts
 
 This is the trickiest level ever! Here ghosts will try to trick you into hitting them.
 
 Can you avoid them?
 */
let r = level4()

r.game.handler = { obstacles, lane in
    // ... yeah, and no hints this time 😈
    
    // Okay, only one: you can copy the code from previous level
    // but it won't get you much money. Try improving it!
    
    // Split all the ghosts by lanes:
    let nearest = (1...3).map { lane in (lane, obstacles.filter({ $0.lane == lane && $0.type == .ghost }).first) }
    
    // Figure out the safest lane – with the biggest distance to nearest ghost:
    lane = nearest.max { ($0.1?.distance ?? .infinity) < ($1.1?.distance ?? .infinity) }!.0

}
/*:
 That's it!
 I hope I'll be selected for WWDC18 Scholarship!
 
 Anyway, thanks for playing 😊
 */
PlaygroundPage.current.liveView = r.view
