//
//  Ext.swift
//  Milan
//
//  Created by mac on 14/10/21.
//

import Foundation
import UIKit
import MobileCoreServices


public enum AppStoryboard: String {
    //Add Storyboard name in enum for use navigation
    case Main
    
    public var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    public func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    public func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class public var storyboardID: String {
        return "\(self)"
    }

    static public func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

//How to Use:
//let homeVC = HomeVC.instantiate(fromAppStoryboard: .Main)
//self.navigationController?.pushViewController(homeVC, animated: true)

extension UITableViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

//How to USE
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: LikeListCell.identifier) as? LikeListCell else{return UITableViewCell()}
//    return cell
//}

extension URL {
    func mimeType() -> String {
         let pathExtension = self.pathExtension
         if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
             if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
             }
         }
         return "application/octet-stream"
    }

    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
             return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }

    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
               return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }
 }
