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
    }
    
    func hideSecondaryMenu() {
        secondaryMenu.removeFromSuperview()
    }
    
    /*@IBAction func applyFilter(sender: AnyObject) {
        var filterName = Filter.None
        
        switch filterState {
        case .Hulk:
            filterName = Filter.Hulkify
            filterState = FilterStates.Smurf
            //applyFilterBtn.titleLabel?.text = "SMURFify"
            applyFilterBtn.setTitle("SMURFify", forState: UIControlState.Normal)
        case .Smurf:
            filterName = Filter.Smurfify
            filterState = FilterStates.Red
            //applyFilterBtn.titleLabel?.text = "REDify"
            applyFilterBtn.setTitle("REDify", forState: UIControlState.Normal)
        case .Red:
            filterName = Filter.Redify
            filterState = FilterStates.None
            //applyFilterBtn.titleLabel?.text = "NONEify"
            applyFilterBtn.setTitle("NONEify", forState: UIControlState.Normal)
        case .None:
            filterName = Filter.None
            filterState = FilterStates.Hulk
            //applyFilterBtn.titleLabel?.text = "HULKify"
            applyFilterBtn.setTitle("HULKify", forState: UIControlState.Normal)
            
        }
        
        let newImage = ImageProcessor.applyFilter(image!, filterName: filterName, v: 0)
        imageView.image = newImage
        
    }*/
    
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