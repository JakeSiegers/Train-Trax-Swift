//
//  DetailsViewController.swift
//  TrainTrax
//
//  Created by Jake on 4/23/16.
//  Copyright © 2016 JakeSiegers. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
    var album: Album?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album!.largeImageURL)!)!)
    
        navigationController?.navigationBar.barStyle = UIBarStyle.Black // White Clock text
        //navigationController!.navigationBar.barStyle = UIBarStyle.Default // Black Clock Text
        //navigationController!.navigationBar.barTintColor = UIColor(red: 29/255.0, green: 144/255.0, blue: 153/255.0, alpha: 1)
        navigationController!.navigationBar.barTintColor = UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
    }
}