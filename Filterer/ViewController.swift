//
//  ViewController.swift
//  Filterer
//
//  Created by Suresh Koppisetti on 4/3/16.
//  Copyright © 2016 tybr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    let image = UIImage(named: "IMG_0974")
    var filterState = FilterStates.None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        print("This code has executed")
    
    }

    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu(){
        view.addSubview(secondaryMenu)
        let bottomConstraint  = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint  = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        NSLayoutConstraint.activateConstraints([bottomConstraint,leftConstraint,rightConstraint,heightConstraint])
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4){
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    func hideSecondaryMenu() {
        //secondaryMenu.removeFromSuperview()
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
        }){ completed in
            if completed == true {
                self.secondaryMenu.removeFromSuperview()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

enum FilterStates {
    case None
    case Smurf
    case Hulk
    case Red
}