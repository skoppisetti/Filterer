//
//  ViewController.swift
//  Filterer
//
//  Created by Suresh Koppisetti on 4/3/16.
//  Copyright © 2016 tybr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    
    
    var image = UIImage(named: "IMG_0974")
    var filteredImage = UIImage()
    
    var filterState = FilterStates.None
    
    required init?(coder aDecoder: NSCoder) {
        //self.filteredImage = image!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        print("This code has executed")
    
    }

    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Checkout our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController,animated: true, completion: nil)
    }
    
    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: {
            action in self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: {
            action in self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Calcel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = image
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
    
    @IBAction func filterRed(sender: AnyObject) {
        filteredImage = ImageProcessor.applyFilter(image!, filterName: Filter.Redify, v: 15)
        imageView.image = filteredImage
    }
    
    @IBAction func filterGreen(sender: AnyObject) {
        filteredImage = ImageProcessor.applyFilter(image!, filterName: Filter.Hulkify, v: 15)
        imageView.image = filteredImage
    }

    @IBAction func filterBlue(sender: AnyObject) {
        filteredImage = ImageProcessor.applyFilter(image!, filterName: Filter.Smurfify, v: 15)
        imageView.image = filteredImage
    }

    @IBAction func filterYellow(sender: AnyObject) {
        filteredImage = ImageProcessor.applyFilter(image!, filterName: Filter.DoubleBright, v:10)
        imageView.image = filteredImage
    }
    
    @IBAction func compareImage(sender: UIButton) {
        if sender.selected {
            imageView.image = filteredImage
            sender.selected = false
        } else {
            imageView.image = image
            sender.selected = true
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