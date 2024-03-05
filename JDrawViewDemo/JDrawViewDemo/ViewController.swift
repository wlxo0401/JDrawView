//
//  ViewController.swift
//  JDrawViewDemo
//
//  Created by KimJitae on 3/4/24.
//

import UIKit
import JDrawView

class ViewController: UIViewController {

    let jdraw: JDrawView = JDrawView()
    
    @IBOutlet weak var storyboardJDrawView: JDrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        storyboardJDrawView.backgroundColor = .red
        
    }
    
    // 움직임
    public override func touchesMoved(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {
            return
        }
                
        print("sdfdfpoint \(point)")
        return
    }
}

