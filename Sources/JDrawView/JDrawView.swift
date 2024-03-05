// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

@objc
public protocol JDrawViewDelegate: AnyObject {
    @objc optional func touchesBeganJD()
    @objc optional func touchesMovedJD()
    @objc optional func getDrawPosition(position: CGPoint)
}

public class JDrawView: UIView {
    // Line Struct
    struct Line {
        let storkeWidth: Float
        let color: UIColor
        var points: [CGPoint]
    }
    
    // Line
    var lines = [Line]()
    
    private var strokeColor = UIColor.black
    private var strokeWidth: Float = 1
    
    var delegate: JDrawViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Line Width
    func setLineWidth(width: Float){
        self.strokeWidth = width
    }
    
    // Line Color
    func setLineColor(color: UIColor) {
        self.strokeColor = color
    }
}

// MARK: - Draw
extension JDrawView {
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
             
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        self.lines.forEach { (line) in
            for (i,p) in line.points.enumerated() {
                if i == 0 { // first index
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        return
    }

    // Began
    public override func touchesBegan(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        self.delegate?.touchesBeganJD?()
        self.lines.append(Line.init(storkeWidth: 2,
                               color: .red,
                               points: []))
        
        return
    }

    // Move
    public override func touchesMoved(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        self.delegate?.touchesMovedJD?()
        self.delegate?.getDrawPosition?(position: point)
        
        guard var lastLine = self.lines.popLast() else {
            return
        }
        
        lastLine.points.append(point)
        
        self.lines.append(lastLine)
        
        setNeedsDisplay()
        return
    }
}

// MARK: - Util
extension JDrawView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
