//
//  ViewController.swift
//  DrawingTutorial
//
//  Created by Salyards, Adey on 4/23/16.
//  Copyright © 2016 Salyards, Adey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var outlineCircle = UIView()
    
    var sampleArray: [UIColor] = []
    var start: CGPoint?
    @IBOutlet weak var drawImageView: UIImageView!
    var count: Int = -1
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    var velocity: CGPoint!
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (255/255, 127/255, 127/255), //red
        (171/255, 107/255, 226/255), //purple
        (12/255, 159/255, 210/255), //blue
        (130/255, 211/255, 138/255), //green
        (116/255, 116/255, 116/255) //gray
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()]
        makeCircles()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        count += 1
        determineColor()
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
    
    func makeCircles() {
        let redView = UIView()
        redView.frame.size = CGSize(width: 50, height: 50)
        redView.backgroundColor = UIColor(red: 1, green: 127/255, blue: 127/255, alpha: 1)
        redView.layer.cornerRadius = redView.frame.width/2
        redView.center = CGPoint(x: 48, y: 530)
        view.addSubview(redView)
        
        let purpleView = UIView()
        purpleView.frame.size = CGSize(width: 50, height: 50)
        purpleView.backgroundColor = UIColor(red: 171/255, green: 107/255, blue: 226/255, alpha: 1)
        purpleView.layer.cornerRadius = purpleView.frame.width/2
        purpleView.center = CGPoint(x: 48, y: 480)
        view.addSubview(purpleView)
        
        let blueView = UIView()
        blueView.frame.size = CGSize(width: 50, height: 50)
        blueView.backgroundColor = UIColor(red: 12/255, green: 159/255, blue: 210/255, alpha: 1)
        blueView.layer.cornerRadius = blueView.frame.width/2
        blueView.center = CGPoint(x: 48, y: 430)
        view.addSubview(blueView)
        
        let greenView = UIView()
        greenView.frame.size = CGSize(width: 50, height: 50)
        greenView.backgroundColor = UIColor(red: 130/255, green: 211/255, blue: 138/255, alpha: 1)
        greenView.layer.cornerRadius = greenView.frame.width/2
        greenView.center = CGPoint(x: 48, y: 380)
        view.addSubview(greenView)
        
        let grayView = UIView()
        grayView.frame.size = CGSize(width: 50, height: 50)
        grayView.backgroundColor = UIColor(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        grayView.layer.cornerRadius = grayView.frame.width/2
        grayView.center = CGPoint(x: 48, y: 330)
        view.addSubview(grayView)
        
        outlineCircle.frame.size = CGSize(width: 55, height: 55)
        outlineCircle.layer.borderColor = UIColor.whiteColor().CGColor
        outlineCircle.layer.borderWidth = 5
        outlineCircle.layer.cornerRadius = outlineCircle.frame.width/2
        outlineCircle.center = CGPoint(x: 48, y: 530)
        view.addSubview(outlineCircle)
        
    }
    
    @IBAction func didTapClearButton(sender: AnyObject) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        drawImageView.image = nil
    }
    
    
    func determineColor() {
        if count == 0 {
            //red
            print("Red: count is \(count)")
            (red, green, blue) = colors[count]
            outlineCircle.center = CGPoint(x: 48, y: 530)
        } else if count == 1 {
            //purple
            print("Purple: count is \(count)")
            (red, green, blue) = colors[count]
            outlineCircle.center = CGPoint(x: 48, y: 480)
        } else if count == 2 {
            //blue
            print("Blue: count is \(count)")
            (red, green, blue) = colors[count]
            outlineCircle.center = CGPoint(x: 48, y: 430)
        } else if count == 3 {
            //green
            print("Green: count is \(count)")
            (red, green, blue) = colors[count]
            outlineCircle.center = CGPoint(x: 48, y: 380)
        } else if count == 4 {
            //gray
            (red, green, blue) = colors[count]
            outlineCircle.center = CGPoint(x: 48, y: 330)
        } else if count > 4 {
            count = 0
            determineColor()
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
        CGContextSetRGBStrokeColor(context, red, green, blue, 1)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineJoin(context, CGLineJoin.Round)
        CGContextStrokePath(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawImageView.image = newImage
    }

}

