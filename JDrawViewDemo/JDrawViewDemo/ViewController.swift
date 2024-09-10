//
//  ViewController.swift
//  JDrawViewDemo
//
//  Created by KimJitae on 3/4/24.
//

import UIKit
import JDrawView

class ViewController: UIViewController {
    private let drawView: JDrawView = {
        let view = JDrawView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let lineWidthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = 5
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let dashLineSwitch: UISwitch = {
        let switch_ = UISwitch()
        switch_.translatesAutoresizingMaskIntoConstraints = false
        return switch_
    }()
    
    private let dashLineLabel: UILabel = {
        let label = UILabel()
        label.text = "Dash Line"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eraseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Erase", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let convertedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Convert to Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Copy Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    private func setupUI() {
        self.view.backgroundColor = .white
            
        // Add all subviews to the main view
        [self.drawView, self.colorStackView, self.lineWidthSlider,
         self.dashLineSwitch, self.dashLineLabel, self.eraseButton,
         self.convertedImageView, self.convertButton, self.copyButton].forEach { self.view.addSubview($0)
        }
                  
          
        NSLayoutConstraint.activate([
            self.drawView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.drawView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.drawView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.drawView.heightAnchor.constraint(equalTo: self.drawView.widthAnchor),
            
            self.colorStackView.topAnchor.constraint(equalTo: self.drawView.bottomAnchor, constant: 20),
            self.colorStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.colorStackView.heightAnchor.constraint(equalToConstant: 40),
            
            self.lineWidthSlider.topAnchor.constraint(equalTo: self.colorStackView.bottomAnchor, constant: 20),
            self.lineWidthSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.lineWidthSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.dashLineLabel.topAnchor.constraint(equalTo: self.lineWidthSlider.bottomAnchor, constant: 20),
            self.dashLineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            self.dashLineSwitch.centerYAnchor.constraint(equalTo: self.dashLineLabel.centerYAnchor),
            self.dashLineSwitch.leadingAnchor.constraint(equalTo: self.dashLineLabel.trailingAnchor, constant: 10),
            
            self.eraseButton.centerYAnchor.constraint(equalTo: self.dashLineLabel.centerYAnchor),
            self.eraseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.convertedImageView.topAnchor.constraint(equalTo: self.dashLineLabel.bottomAnchor, constant: 20),
            self.convertedImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.convertedImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.convertedImageView.heightAnchor.constraint(equalToConstant: 100),

            self.convertButton.topAnchor.constraint(equalTo: self.convertedImageView.bottomAnchor, constant: 10),
            self.convertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.copyButton.topAnchor.constraint(equalTo: self.convertedImageView.bottomAnchor, constant: 10),
            self.copyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        self.setupColorButtons()
        self.setupActions()
    }
    
    private func setupColorButtons() {
        let colors: [UIColor] = [.red, .blue, .yellow, .black]
        
        for color in colors {
            let button = UIButton(type: .system)
            button.backgroundColor = color
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(self.colorButtonTapped(_:)),
                             for: .touchUpInside)
            
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            self.colorStackView.addArrangedSubview(button)
        }
    }
        
    private func setupActions() {
        self.lineWidthSlider.addTarget(self,
                                       action: #selector(self.lineWidthChanged(_:)),
                                       for: .valueChanged)
        self.dashLineSwitch.addTarget(self,
                                      action: #selector(self.dashLineSwitchChanged(_:)),
                                      for: .valueChanged)
        self.eraseButton.addTarget(self,
                                   action: #selector(self.clearButtonAction(_:)),
                                   for: .touchUpInside)
        
        self.convertButton.addTarget(self, 
                                     action: #selector(self.convertButtonTapped), 
                                     for: .touchUpInside)
        self.copyButton.addTarget(self,
                                  action: #selector(self.copyButtonTapped),
                                  for: .touchUpInside)
    }
        
    @objc private func colorButtonTapped(_ sender: UIButton) {
        self.drawView.setDrawColor(color: sender.backgroundColor ?? .black)
    }
    
    @objc private func lineWidthChanged(_ sender: UISlider) {
        self.drawView.setDrawWidth(width: CGFloat(sender.value))
    }
    
    @objc private func dashLineSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.drawView.setVerticalDashLine(set: true)
            self.drawView.setHorizonDashLine(set: true)
        } else {
            self.drawView.setVerticalDashLine(set: false)
            self.drawView.setHorizonDashLine(set: false)
        }
    }
    
    @objc private func clearButtonAction(_ sender: UIButton) {
        self.drawView.clearDrawing()
    }
    
    @objc private func convertButtonTapped() {
        let image = self.drawView.asImage()
        self.convertedImageView.image = image
    }

    @objc private func copyButtonTapped() {
        self.drawView.copyImage()
        
        // Optional: Show a brief message to indicate the image was copied
        let alert = UIAlertController(title: "Image Copied", message: "The drawing has been copied to the clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
