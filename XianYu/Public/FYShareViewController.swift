//
//  FYShareViewController.swift
//  joint-operation
//
//  Created by Yan on 2019/1/14.
//  Copyright © 2019 Yan. All rights reserved.
//

import UIKit

@objcMembers
class FYShareViewController: UIViewController {
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    private var shareUrl = ""
    
    private var shareTitle = ""
    
    private var shareDes = ""
    
    private var shareImg: UIImage = UIImage()
    
    init(_ url: String, title: String, des: String, img: UIImage) {
        super.init(nibName: "FYShareViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        shareUrl = url; shareTitle = title; shareDes = des; shareImg = img
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UMSocialManager.default()?.isInstall(.wechatSession) == true {
            show()
        } else {
            ToastView.show("该设备未安装微信")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func wxShareSessionAction(_ sender: UIButton) {
        wxShare(.wechatSession)
        
    }
    
    @IBAction func wxShareTimelineAction(_ sender: UIButton) {
        wxShare(.wechatTimeLine)
    }
    
    @objc public func wxSigleShare(_ type: UMSocialPlatformType) {
        let msg = UMSocialMessageObject()
        let webPage = UMShareWebpageObject.shareObject(withTitle: shareTitle, descr: shareDes, thumImage: shareImg)
        webPage?.webpageUrl = shareUrl
        msg.shareObject = webPage
        UMSocialManager.default()?.share(to: type, messageObject: msg, currentViewController: self, completion: { (data, error) in
            if error == nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("\(String(describing: data))")
            }
        })
    }
    
    func wxShare(_ type: UMSocialPlatformType) {
        wxSigleShare(type)
        hidden()
    }
    
    
    func show() {
        bottom.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hidden() {
        bottom.constant = -100
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            hidden()
        }
    }

}
