//
//  JDrawView.swift
//  Bmea
//
//  Created by 김지태 on 9/3/24.
//

import UIKit

// Main drawing view class
public class JDrawView: UIView {
    // Struct to represent a line in the drawing
    struct Line {
        let strokeWidth: CGFloat
        let color: UIColor
        var points: [CGPoint]
    }
    
    // Layer responsible for actual drawing
    private let drawingLayer: DrawingLayer
    
    // Variables for dash lines
    private var horizontalDashLine: CAShapeLayer?
    private var verticalDashLine: CAShapeLayer?
    
    // Drawing color with property observer
    private var drawColor: UIColor {
        didSet {
            self.drawingLayer.setDrawColor(color: self.drawColor)
        }
    }
    
    // Drawing width with property observer
    private var drawWidth: CGFloat {
        didSet {
            self.drawingLayer.setDrawWidth(width: self.drawWidth)
        }
    }
    
    // Initializers
    override init(frame: CGRect) {
        self.drawingLayer = DrawingLayer(frame: frame)
        self.drawColor = .black
        self.drawWidth = 5
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drawingLayer = DrawingLayer(frame: .zero)
        self.drawColor = .black
        self.drawWidth = 1
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // Common initialization method
    private func commonInit() {
        self.backgroundColor = .white
        self.drawingLayer.backgroundColor = .clear
        self.addSubview(self.drawingLayer)
        self.drawingLayer.setDrawColor(color: self.drawColor)
        self.drawingLayer.setDrawWidth(width: self.drawWidth)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.drawingLayer.frame = self.bounds
            
        // Update dash lines if they exist
        self.updateDashLines()
    }
        
    // New method to update dash lines
    private func updateDashLines() {
        if let horizontalLine = self.horizontalDashLine {
            horizontalLine.removeFromSuperlayer()
            self.addDashedLine(from: CGPoint(x: 0, y: self.frame.size.height / 2),
                          to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2),
                          to: horizontalLine)
        }
            
        if let verticalLine = self.verticalDashLine {
            verticalLine.removeFromSuperlayer()
            self.addDashedLine(from: CGPoint(x: self.frame.size.width / 2, y: 0),
                          to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height),
                          to: verticalLine)
        }
    }
}

// MARK: - Internal Methods
extension JDrawView {
    private func addDashedLine(from start: CGPoint, to end: CGPoint, to lineLayer: CAShapeLayer) {
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)

        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.lineWidth = 1
        lineLayer.lineDashPattern = [6, 3]

        self.layer.addSublayer(lineLayer)
    }
}

// MARK: - Public Methods
extension JDrawView {
    // Convert the drawing to an image
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.drawingLayer.bounds)
        return renderer.image { rendererContext in
            self.drawingLayer.layer.render(in: rendererContext.cgContext)
        }
    }
    
    // Copy the drawing as an image to the clipboard
    public func copyImage() {
        let image = self.asImage()
        UIPasteboard.general.image = image
    }
    
    public func setHorizonDashLine(set: Bool) {
        if set {
            if self.horizontalDashLine == nil {
                self.horizontalDashLine = CAShapeLayer()
            }
        } else {
            self.horizontalDashLine?.removeFromSuperlayer()
            self.horizontalDashLine = nil
        }
        self.updateDashLines()
    }
        
    public func setVerticalDashLine(set: Bool) {
        if set {
            if self.verticalDashLine == nil {
                self.verticalDashLine = CAShapeLayer()
            }
        } else {
            self.verticalDashLine?.removeFromSuperlayer()
            self.verticalDashLine = nil
        }
        self.updateDashLines()
    }
    
    // Set the drawing line width
    public func setDrawWidth(width: CGFloat) {
        self.drawWidth = width
    }
    
    // Set the drawing color
    public func setDrawColor(color: UIColor) {
        self.drawColor = color
    }
    
    // Clear the drawing
    public func clearDrawing() {
        self.drawingLayer.clear()
    }
}

// MARK: - Drawing Layer
class DrawingLayer: UIView {
    private var lines = [JDrawView.Line]()
    private var drawColor: UIColor = .black
    private var drawWidth: CGFloat = 1
    
    // Draw the lines
    override func draw(_ rect: CGRect) {
        super.draw(rect)
             
        guard let context = UIGraphicsGetCurrentContext() else { return }
         
        self.lines.forEach { line in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.strokeWidth)
            
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    // Start a new line when touch begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.lines.append(JDrawView.Line(strokeWidth: self.drawWidth, color: self.drawColor, points: []))
    }
    
    // Add points to the current line as touch moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self),
              var lastLine = self.lines.popLast() else { return }
        
        lastLine.points.append(point)
        self.lines.append(lastLine)
        self.setNeedsDisplay()
    }
    
    // Set the drawing width
    func setDrawWidth(width: CGFloat) {
        self.drawWidth = width
    }
    
    // Set the drawing color
    func setDrawColor(color: UIColor) {
        self.drawColor = color
    }
    
    // Clear all lines
    func clear() {
        self.lines.removeAll()
        self.setNeedsDisplay()
    }
}
