//
//  ViewController.swift
//  Dos-Xmas
//
//  Created by Do Nguyen on 12/20/15.
//  Copyright © 2015 Zincer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var snowflakes = [UIImageView]()
    var texts = ["Normal form", "Type", "Denotation", "Int", "Float", "BASIC", "FORTRANS", "LISP", "Syntax", "Semantics", "Formal Definition", "Context-Free Grammars", "Pascal", "Ada" , "Prolog", "sentential form", "Ambiguity in Grammars", "Unambiguous Grammar", "const", "(+|-)", "BNF", "EBNF", "<expr>", "Variations", "Static Semantics", "(CFGs)", " G = (S, N, T, P) ", "Operational Semantics", "Natural operational", "Structural operational ", "Denotational Semantics", "VARMAP", "Expressions", "Logical", "Pretest", "Loop", "Java", "C++", "C#"]
    var cur:Int = 0
    var timeInterval: Float = 20
    var numberOfSnowflakes = 5
    
    func GenerateSnowflakes() {
        
        for var i in 0..<numberOfSnowflakes {
            var x:Int = Int(arc4random()) % 1024
            var y:Int = Int(arc4random()) % 400
            var snowFlake: UIImageView = UIImageView(frame: CGRectMake(CGFloat(x), CGFloat(y), 16, 16))
            snowFlake.image = UIImage(named: "snowflake.png")
            snowflakes.append(snowFlake)
            self.view.addSubview(snowFlake)
        }
        MoveSnowflakes(cur,high: snowflakes.count)
    }
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
    }
    
    func GenerateNew(count: Int, max:Int) {
        cur += numberOfSnowflakes
        if (count < max) {
            delay(0.6){
                self.GenerateSnowflakes()
                self.GenerateNew(count+1, max: max)}
        }
    }
    
    func MoveSnowflakes (low:Int, high:Int) {
        
        var theAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        theAnimation.repeatCount = Float.infinity
        theAnimation.autoreverses = false
        
        for i in low ..< high {
            var p: CGPoint = snowflakes[i].center
            let startypos = p.y
            let endypos = p.y + CGFloat(16)
            p.y = endypos
            snowflakes[i].center = p
            theAnimation.duration = CFTimeInterval(timeInterval)
            theAnimation.fromValue = -startypos
            theAnimation.toValue = 738
            snowflakes[i].layer.addAnimation(theAnimation, forKey: "transform.translation.y")
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GenerateSnowflakes()
        GenerateNew(0, max: 30)
        
        let tap = UITapGestureRecognizer(target: self, action: "onTap")
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    func onTap() {
       GenerateText()
    }
    
    func GenerateText() {
        var theAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        theAnimation.repeatCount = Float.infinity
        theAnimation.autoreverses = false
        
        
        for text in texts {
            var x:Int = Int(arc4random()) % 1000
            var y:Int = Int(arc4random()) % 800
            
            var label = UILabel()
            label.text = text
            var p: CGPoint = CGPoint(x:CGFloat(x), y: CGFloat(y))
            label.font = UIFont.systemFontOfSize(19)
            label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            label.sizeToFit()
            label.center = p
            view.addSubview(label)
            
            let startypos = p.y
            let endypos = p.y + CGFloat(16)
            p.y = endypos
            
            theAnimation.duration = CFTimeInterval(timeInterval)
            theAnimation.fromValue = -startypos
            theAnimation.toValue = 738
            label.layer.addAnimation(theAnimation, forKey: "transform.translation.y")
            
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
    }
    
    func stopSnow() {
        for v: UIImageView in snowflakes {
            v.layer.removeAllAnimations()
        }
    }
}

