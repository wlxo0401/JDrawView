// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class JDrawView: UIView {
    
    public init(background: UIColor) {
        super.init(frame: .zero)
        
            self.backgroundColor = background
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        print("draw")
        return
    }

    public override func touchesBegan(_ touches: Set<UITouch>, 
                               with event: UIEvent?) {
        print("touchesBegan")
        return
    }

    public override func touchesMoved(_ touches: Set<UITouch>, 
                               with event: UIEvent?) {
        print("touchesMoved")
        return
    }
    
}
