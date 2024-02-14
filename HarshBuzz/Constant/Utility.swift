//
//  Utility.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//
 
import UIKit

class Utility {
    static let shared = Utility()
    
    private var activityView: UIActivityIndicatorView?
    
    private init() {}
    
    func showLoader(on view: UIView) {
        if activityView == nil {
            activityView = UIActivityIndicatorView(style: .large)
            activityView?.center = view.center
            view.addSubview(activityView!)
        }
        activityView?.startAnimating()
    }

    func hideLoader() {
        activityView?.stopAnimating()
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    public func showAlert(title:String, message: String, view:UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    func heavyHapticFeedBack(){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavyImpact)
        feedbackGenerator.impact()
    }
    
}
