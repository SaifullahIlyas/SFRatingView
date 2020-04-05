//
//  RatingView.swift
//  Feture1
//
//  Created by Saifullah on 05/04/2020.
//  Copyright © 2020 Saifullah. All rights reserved.
//

import UIKit

@IBDesignable public class RatingView: UIStackView {

@IBOutlet var containerView: UIView!
    
    @IBInspectable public var selectedColor :UIColor = UIColor.blue
    
    @IBInspectable public var rating:Int=5 {
        didSet{
            if self.rating > 5 {
                self.rating = 5
            }
            else if self.rating < 1 {
                self.rating = 1
            }
            
            self.setupStarview()
            //self.layoutIfNeeded()
        }
    }
    
    @IBInspectable public var startSpacing:Double=0.0
    
    @IBInspectable public var selectedImage:UIImage!
    @IBInspectable public var unslectedimage:UIImage!
    
    @IBInspectable public var UnSelectedColor:UIColor=UIColor.black
    @IBOutlet weak var StartView: UIStackView!
    required init(coder: NSCoder) {
        super.init(coder: coder)
      self.loadXib(classOwner: self)
       containerView.fixInView(self)
       
       
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

   self.loadXib(classOwner: self)
   containerView.fixInView(self)
       
    }
    override public func layoutSubviews() {
     self.setupStarview()
    }

    
    func setImages(star:UIImageView) {
      star.isUserInteractionEnabled = true
      //  let tap = UITapGestureRecognizer(target: self, action: #selector(self.ratingAction(_:)))
            //   tap.numberOfTouchesRequired = 1
         //   star.addGestureRecognizer(tap)
    }
    
    
    
    @objc func ratingAction(tap:UITapGestureRecognizer) {
    
        let range = tap.view?.tag ?? 0
        
        self.rating = range
        DispatchQueue.main.async {
            for n in 1...range {
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    (self.StartView.subviews[n-1] as! UIImageView).image = self.selectedImage
                    (self.StartView.subviews[n-1] as! UIImageView).setImageColor(color: self.selectedColor)
                })
                
           /* let button = self.StartView.subviews[n-1] as! UIImageView
                UIView.animate(withDuration: 0.3, animations: {
                    button.setImageColor(color: self.selectedColor)
                                   self.StartView.insertSubview(button, at: n-1)
                })*/
               
            }
        }
      DispatchQueue.main.async {
        guard range<5 else {return}
         for n in range+1...5 {
           
            UIView.animate(withDuration:0, animations: {
                
                (self.StartView.subviews[n-1] as! UIImageView).image = self.unslectedimage
                (self.StartView.subviews[n-1] as! UIImageView).setImageColor(color: self.UnSelectedColor)
            })
            
                /*let button = self.StartView.subviews[n-1] as! UIImageView
            
            UIView.animate(withDuration: 1, animations: {
             button.setImageColor(color: .black)
                self.StartView.insertSubview(button, at: n-1)
            })*/
            
            
            }
        }
        
    }
    
    public func setupStarview () {
      
        self.StartView.spacing = CGFloat(self.startSpacing)
        for n in  1...StartView.subviews.count {
           // print("view are in stack ")
            let view = StartView.subviews[n-1] as! UIImageView
            if n <= self.rating{
               
                view.image = selectedImage
               // view.image = self.selectedImage
                view.setImageColor(color:self.selectedColor)
            }
            else{
                view.image=self.unslectedimage
                view.setImageColor(color: self.UnSelectedColor)
            }
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(ratingAction(tap:)))
            tap.numberOfTapsRequired = 1
            view.addGestureRecognizer(tap)
        }
    }
    

    /*    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIView {
    
    func loadXib(classOwner:UIView) {
        let name = NSStringFromClass(classOwner.classForCoder).split(separator: ".")
        let bundle = Bundle.init(for: classOwner.classForCoder)
    
        bundle.loadNibNamed(name.count > 1 ? String(name[name.count-1]):String(name[0]), owner: classOwner, options: nil)
        //self.fixInView(self)
    }
    
    func fixInView(_ container: UIView!) -> Void{
           self.translatesAutoresizingMaskIntoConstraints = false;
           self.frame = container.frame;
           container.addSubview(self);
           NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
       }
}
