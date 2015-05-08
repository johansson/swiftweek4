//
//  CanvasViewController.swift
//  week4
//
//  Created by Will Johansson on 2015-05-07.
//  Copyright (c) 2015 Will Johansson and Jayme Woogerd. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    var trayOriginalCenter: CGPoint! // open position
    var trayClosedCenter: CGPoint = CGPoint(x: Double(187.5), y: Double(820))
    var newFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayOriginalCenter = trayView.center
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    160 284
    */
    @IBAction func smileyPanGesture(sender: UIPanGestureRecognizer) {
        var imageView = sender.view as! UIImageView

        if sender.state == .Began {
            newFace = UIImageView(image: imageView.image)
            trayView.addSubview(newFace)
            newFace.center = imageView.center
        }

        if sender.state == .Changed {
            let translation = sender.translationInView(newFace)
            newFace.center = CGPoint(x: newFace.center.x + translation.x, y: translation.y)
        }
    }

    @IBOutlet weak var trayView: UIView!
    
    @IBAction func onTrayPanWhatever(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(trayView)
        
        let duration : NSTimeInterval = Double(1);
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            let velocity = sender.velocityInView(self.trayView)
            
            if (velocity.y < 0) {
                // moving up
                self.trayView.center = self.trayOriginalCenter
            } else if (velocity.y > 0) {
                // moving down
                self.trayView.center = self.trayClosedCenter //CGPoint(x: trayOriginalCenter.x, y: 640)
            }
        })
    }
}
