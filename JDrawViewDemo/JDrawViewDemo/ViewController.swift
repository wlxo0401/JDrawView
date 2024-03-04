//
//  ViewController.swift
//  JDrawViewDemo
//
//  Created by KimJitae on 3/4/24.
//

import UIKit
import JDrawView

class ViewController: UIViewController {

    let jdraw: JDrawView = JDrawView(background: .blue)
    
    @IBOutlet weak var storyboardJDrawView: JDrawView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        storyboardJDrawView.backgroundColor = .red
        
        self.view.addSubview(jdraw)
        
        jdraw.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Set the height constraint to 300
        jdraw.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // Set leading constraint to 10
        jdraw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        
        // Set trailing constraint to -10 (to ensure 10pt spacing from the trailing edge)
        jdraw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        // Set bottom constraint to -10 (to ensure 10pt spacing from the bottom edge)
        jdraw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
    }
}

