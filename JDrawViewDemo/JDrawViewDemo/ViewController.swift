//
//  ViewController.swift
//  JDrawViewDemo
//
//  Created by KimJitae on 3/4/24.
//

import UIKit
import JDrawView

class ViewController: UIViewController, JDrawViewDelegate {

    let jdraw: JDrawView = JDrawView()
    
    @IBOutlet weak var storyboardJDrawView: JDrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        storyboardJDrawView.backgroundColor = .red
        storyboardJDrawView.delegate = self
    }
    
    func touchesBeganJD() {
        print("touchesBeganJD")
    }
    
    func touchesMovedJD() {
        print("touchesMovedJD")
    }
    
    func getDrawPosition(position: CGPoint) {
        print("position: \(position)")
    }
    @IBAction func asUIImageButton(_ sender: Any) {
        let image = storyboardJDrawView.asImage()
        UIPasteboard.general.image = image
    }
}

