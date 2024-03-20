import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    var ball = SKShapeNode(circleOfRadius: 25)
    let gravity = CGFloat(-9.8)
    var isBouncing = false
    var numBounces = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        // Set up ball properties
        ball.fillColor = .blue
        ball.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(ball)
        
        // Add physics properties to ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.restitution = 0.7 // Bounce effect
        ball.physicsBody?.friction = 0.7
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.contactTestBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        
        // Add edge loop physics body to scene
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 1
        physicsBody?.restitution = 1
    }
    
    func start() {
        // Apply initial impulse to ball
        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
        isBouncing = true
        numBounces = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isBouncing {
            // Apply gravity to ball
            ball.physicsBody?.applyForce(CGVector(dx: 0, dy: gravity))
            
            // Check if ball has hit bottom of screen
            let minY = ball.frame.size.height / 2
            let maxY = size.height - ball.frame.size.height / 2
            let velY = ball.physicsBody?.velocity.dy ?? 0
            
            if ball.position.y <= minY {
                numBounces += 1
                
                // Reduce velocity by 70% on bounce
                ball.physicsBody?.velocity.dy *= -0.7
                
                // Stop bouncing when ball's velocity is below a certain threshold
                if abs(velY) < 50 {
                    isBouncing = false
                    ball.physicsBody?.velocity.dy = 0 // Stop ball completely
                }
            }
            
        }
    }

}

struct ContentView7: View {
    
    @State private var scene = GameScene(size: CGSize(width: 300, height: 300))
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 300, height: 300)
            Button("Start") {
                self.scene.start()
            }
            .padding()

        }
        
    }
}


struct Contentview7_Pre: PreviewProvider {
    static var previews: some View {
        ContentView7()
    }
}
