//
//  FYAclertController.swift
//  PartnerApp
//
//  Created by Yan on 2018/7/2.
//  Copyright © 2018年 Yan. All rights reserved.
//

import UIKit

@objcMembers
class FYAlertController: UIViewController {
    
    @IBOutlet private weak var titleLab: UILabel!
    
    @IBOutlet private weak var textLab: UILabel!
    
    @IBOutlet weak var msgTop: NSLayoutConstraint!
    @IBOutlet private weak var commitLeading: NSLayoutConstraint!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var commitBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    private var tit = ""
    
    private var message = ""
    
    private var commitTitle = ""
    
    private var cancelTitle = ""
    
    private var isClose = false
    
    private var cancelAction: (()->())!
    
    private var commitAction: (()->())!
    
    private var closeAction:(()->())!
    
    
    init(title: String = "", msg: String, commit: String = "", cancel: String = "", close: Bool = false) {
        super.init(nibName: "FYAlertController", bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        tit = title
        message = msg
        commitTitle = commit
        cancelTitle = cancel
        isClose = close
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action(commit: @escaping ()->(), cancel: @escaping ()->() = {}, close: @escaping ()->() = {}) {
        commitAction = commit
        cancelAction = cancel
        closeAction = close
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.setTitle(cancelTitle, for: .normal)
        commitBtn.setTitle(commitTitle, for: .normal)
        textLab.text = message
        closeBtn.isHidden = !isClose
        if cancelTitle.count == 0 {
            commitLeading.constant = 0
        }
        if commitTitle.count == 0 {
            
        }
        if tit.count == 0 {
            msgTop.constant = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.closeAction()
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.cancelAction()
        }
        
    }
    
    @IBAction func commitAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.commitAction()
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if view == touches.first?.view {
//            dismiss(animated: true, completion: nil)
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
