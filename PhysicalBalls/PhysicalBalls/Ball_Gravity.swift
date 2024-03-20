import SwiftUI
import CoreMotion
import SpriteKit

class GameSceneCoreMotion: SKScene {
    
    var blueBall = SKShapeNode(path: UIBezierPath(ovalIn: CGRect(x: -25, y: -25, width: 50, height: 50)).cgPath)
    var yellowBall = SKShapeNode(path: UIBezierPath(ovalIn: CGRect(x: -25, y: -25, width: 50, height: 50)).cgPath)
    let gravity = CGFloat(-50)
    var motionManager: CMMotionManager?
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        // Set up blue ball properties
        blueBall.fillColor = .red
        blueBall.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        addChild(blueBall)
        
        // Add physics properties to blue ball
        blueBall.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        blueBall.physicsBody?.restitution = 0 // No bounce effect
        blueBall.physicsBody?.friction = 0.7
        blueBall.physicsBody?.linearDamping = 0.5
        blueBall.physicsBody?.categoryBitMask = 1
        blueBall.physicsBody?.contactTestBitMask = 1
        blueBall.physicsBody?.collisionBitMask = 1
        blueBall.physicsBody?.mass = 10
        
        // Set up yellow ball properties
        yellowBall.fillColor = .yellow
        
        yellowBall.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        addChild(yellowBall)
        
        // Add physics properties to yellow ball
        yellowBall.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        yellowBall.physicsBody?.restitution = 0 // No bounce effect
        yellowBall.physicsBody?.friction = 0.7
        yellowBall.physicsBody?.linearDamping = 0.5
        yellowBall.physicsBody?.categoryBitMask = 1
        yellowBall.physicsBody?.contactTestBitMask = 1
        yellowBall.physicsBody?.collisionBitMask = 1
        yellowBall.physicsBody?.mass = 10
        
        // Add boundary physics body to scene
        let boundary = SKPhysicsBody(edgeLoopFrom: frame)
        boundary.friction = 1
        boundary.restitution = 0
        physicsBody = boundary
        
        // Set up motion manager to detect device orientation
        motionManager = CMMotionManager()
        motionManager?.startDeviceMotionUpdates()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Check device orientation and apply gravity in the appropriate direction
        if let motion = motionManager?.deviceMotion {
            let gravityX = motion.gravity.x
            let gravityY = motion.gravity.y
            physicsWorld.gravity = CGVector(dx: -gravityX * gravity, dy: -gravityY * gravity)
        }
    }

}

struct Ball_Gravity: View {
    
    @State private var scene = GameSceneCoreMotion(size: UIScreen.main.bounds.size)
@State var isBoldDesignViewShowing = false
    var body: some View {
        VStack {
            ZStack {
                SpriteView(scene: scene)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Button("Bold") {
                    isBoldDesignViewShowing.toggle()
                }
            }
        }
        .ignoresSafeArea(.all)
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear {
            self.scene.motionManager?.startDeviceMotionUpdates()
        }
        .onDisappear {
            self.scene.motionManager?.stopDeviceMotionUpdates()
        }
    }
}


struct Contentview_Previews: PreviewProvider {
    static var previews: some View {
        Ball_Gravity()
    }
}
