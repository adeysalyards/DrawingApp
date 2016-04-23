//
//  ViewController.swift
//  DrawingTutorial
//
//  Created by Salyards, Adey on 4/23/16.
//  Copyright © 2016 Salyards, Adey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    var sampleArray: [UIColor] = []
    var start: CGPoint?
    @IBOutlet weak var drawImageView: UIImageView!
    var count = Int()
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (255, 127, 127), //red
        (171, 107, 226), //purple
        (12, 159, 210), //blue
        (130, 211, 138), //green
        (116, 116, 116) //gray
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        count += 1
        let touch = touches.first as UITouch!
        start = touch.locationInView(self.drawImageView)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let end = touch.locationInView(self.drawImageView)
        if let s = self.start{
            draw(s, end: end)
        }
        self.start = end
    }
    
    @IBAction func didTapScreen(sender: UITapGestureRecognizer) {
        count += 1
        determineColor()
   }
    
    func determineColor() {
        if count > 4 {
            count = 0
            determineColor()
        } else {
            (red, green, blue) = colors[count]
            colorView.backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
            print(colorView.backgroundColor)
        }
    }
    
    func draw(start: CGPoint, end: CGPoint){
        UIGraphicsBeginImageContext(self.drawImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawImageView?.image?.drawInRect(CGRect(x: 0, y: 0, width: drawImageView.frame.width, height: drawImageView.frame.height))
        
        CGContextSetLineWidth(context, 6)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        CGContextStrokePath(context)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        drawImageView.image = newImage
    }

}

