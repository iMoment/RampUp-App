//
//  RampPickerVC.swift
//  RampUp
//
//  Created by Stanley Pan on 06/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {

    //  MARK: Variables
    var sceneView: SCNView!
    var size: CGSize!
    weak var rampPlayerVC: RampPlacerVC!
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(origin: .zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        let scene = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let pipe = Ramp.getPipe()
        Ramp.startRotation(node: pipe)
        scene.rootNode.addChildNode(pipe)
        
        let pyramid = Ramp.getPyramid()
        Ramp.startRotation(node: pyramid)
        scene.rootNode.addChildNode(pyramid)
        
        let quarter = Ramp.getQuarter()
        Ramp.startRotation(node: quarter)
        scene.rootNode.addChildNode(quarter)
        
        preferredContentSize =  size
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let position = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(position, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            rampPlayerVC.onRampSelected(node.name!)
            self.dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}















