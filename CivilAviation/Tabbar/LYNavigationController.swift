//
//  LYNavigationController
//
//  Created by easyto on 2019/8/9.
//  Copyright © 2019 Netease. All rights reserved.
//

import UIKit

@objc class LYNavigationController: UINavigationController {

    private let titleLabel = UILabel()
    private let EnglishTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = NavigationBackgroundColor
        self.navigationBar.shadowImage = UIImage.init()
        initView()
    }
    
    func setTitle(title: String, English: String) {
        titleLabel.text = title
        EnglishTitleLabel.text = English
    }
    
    private func initView() {
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 2 + StatusBarHeight, width: kScreenWidth, height: 20)
        view.addSubview(titleLabel)
        
        EnglishTitleLabel.textColor = UIColor.white
        EnglishTitleLabel.font = UIFont.systemFont(ofSize: 18)
        EnglishTitleLabel.textAlignment = .center
        EnglishTitleLabel.frame = CGRect(x: 0, y: titleLabel.mj_y + titleLabel.mj_h + 2, width: kScreenWidth, height: 20)
        view.addSubview(EnglishTitleLabel)
    }
    
    //寻找底部横线
    func foundNavigationBarBottomLine(view: UIView) -> UIImageView? {
        if view is UIImageView && view.mj_h <= 1.0 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            let imageView = foundNavigationBarBottomLine(view: subview)
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }
    
    func showNavBarBottomLine() {
        let bottomLine =  foundNavigationBarBottomLine(view: self.navigationBar)
        if bottomLine != nil {
            bottomLine?.isHidden = true
        }
        
        let navLine = self.navigationBar.subviews[0].viewWithTag(5757)
        if navLine != nil {
            navLine?.isHidden = false
            var bottomLineFrame = bottomLine!.frame
            bottomLineFrame.origin.y = self.navigationBar.frame.maxY
            navLine!.frame = bottomLineFrame;
        } else {
            var bottomLineFrame = bottomLine!.frame
            bottomLineFrame.origin.y = self.navigationBar.frame.maxY
            let navLine = UIImageView.init(frame: bottomLineFrame)
            navLine.tag = 5757;
            navLine.backgroundColor = UIColor.init(hex: 0xC8C8C8);
            if self.navigationBar.subviews.count > 0 {
                self.navigationBar.subviews[0].addSubview(navLine)
            } else {
                bottomLine!.isHidden = false
            }
        }
    }
    
    func hideNavBarBottomLine() {
        let bottomLine =  foundNavigationBarBottomLine(view: self.navigationBar)
        if bottomLine != nil {
            bottomLine?.isHidden = true
        }
        let navLine = self.navigationBar.subviews[0].viewWithTag(5757)
        if navLine != nil {
            navLine?.isHidden = true
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let controller = self.topViewController
        if controller!.responds(to: #selector(controllerWillPopHandler)) {
            controller!.perform(#selector(controllerWillPopHandler))
        }
        return super.popViewController(animated: animated)
    }
    
    @objc func controllerWillPopHandler() {
    }
}
