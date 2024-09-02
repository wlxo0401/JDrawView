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
    
    public var delegate: JDrawViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
    }
    
    // Line Width
    public func setLineWidth(width: Float){
        self.strokeWidth = width
    }
    
    // Line Color
    public func setLineColor(color: UIColor) {
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

extension JDrawView {
    private func addDashedLine(from start: CGPoint, to end: CGPoint) {
        let lineLayer = CAShapeLayer()
        let linePath = UIBezierPath()

        linePath.move(to: start)
        linePath.addLine(to: end)

        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 2
        lineLayer.lineDashPattern = [6, 3] // 대시 패턴: 6pt 선, 3pt 공백

        self.layer.addSublayer(lineLayer)
    }
}

// MARK: - Util
extension JDrawView {
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    public func setXAxisDashLine() {
         // X축 대시 라인 추가
        self.addDashedLine(from: CGPoint(x: 0, y: self.frame.size.height / 2),
                       to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2))
     }

    public func setYAxisDashLine() {
         // Y축 대시 라인 추가
        self.addDashedLine(from: CGPoint(x: self.frame.size.width / 2, y: 0),
                       to: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height))
     }
}

