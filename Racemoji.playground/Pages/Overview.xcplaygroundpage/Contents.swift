import SpriteKit
import PlaygroundSupport
/*:
 # Overview
 
 This is an example level to show you quickly how the game works.
 
 ### You'll be programming a self-driving car!
 
 The goal is to drive the whole road without hitting any ghosts
 (and to try and collect the most money 😉).
 
 There are 3 lanes. The car can use any of them, and move to another at any time.
 
 You can control the car **only via code**.
 */
let r = level1()
//: Here is the method you should use to control the car:
r.game.handler = { obstacles, lane in
    // Change the `lane` variable when you want move the car to another lane
    lane = 2
}
/*:
 For this partucular example, it's perfectly fine to drive on the 3rd lane all the way.
 
 Please try to do that!
 */
PlaygroundPage.current.liveView = r.view
//: [Next](@next)
