//
//  JOBigImgViewController.swift
//  joint-operation
//
//  Created by Yan on 2018/12/26.
//  Copyright © 2018 Yan. All rights reserved.
//

import UIKit

@objcMembers
class FYBigImgViewController: UIViewController {
    let IPHONE_WIDTH = UIScreen.main.bounds.size.width
    let IPHONE_HEIGHT = UIScreen.main.bounds.size.height
    var complete:((UIImage?)->Void)?
    
    var img: UIImage!
    
    lazy var imgV: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = .black
        imgV.contentMode = .scaleAspectFit
        imgV.isUserInteractionEnabled = true
        return imgV
    }()
    
    private var isScale = false
    private var beginTransform = CGAffineTransform.identity

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "查看图片"
        view.addSubview(imgV)
        imgV.frame = view.bounds
        imgV.image = img
        addGesture()
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tap.numberOfTapsRequired = 2
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress.minimumPressDuration = 0.5
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        pan.maximumNumberOfTouches = 1
        imgV.addGestureRecognizer(tap)
        imgV.addGestureRecognizer(pinch)
        imgV.addGestureRecognizer(longPress)
        imgV.addGestureRecognizer(pan)
        
    }
    
    @objc func tapAction(_ tap: UITapGestureRecognizer) {
        isScale = !isScale
        let scale: CGFloat = isScale ? 2 : 1
        if let tapView = tap.view {
            tapView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    @objc func pinchAction(_ pinch: UIPinchGestureRecognizer) {
        if let pinchView = pinch.view {
            switch pinch.state {
            case .began:
                beginTransform = pinchView.transform
            case .changed:
                var scale = max(pinch.scale * beginTransform.a, 1)
                scale = min(scale, 2)
                var x = max(-(scale * pinchView.bounds.width - IPHONE_WIDTH) / 2, beginTransform.tx)
                x = min((scale * pinchView.bounds.width - IPHONE_WIDTH) / 2, x)
                var y = max(-(scale * pinchView.bounds.height - IPHONE_HEIGHT) / 2, beginTransform.ty)
                y = min((scale * pinchView.bounds.height - IPHONE_HEIGHT) / 2, y)
                pinchView.transform = CGAffineTransform(a: scale, b: beginTransform.b, c: beginTransform.c, d: scale, tx: x, ty: y)
            default: break
            }
        }
    }
    
    @objc func longPressAction(_ longPress: UILongPressGestureRecognizer) {
        if let imgV = longPress.view as? UIImageView,
            let img = imgV.image,
            longPress.state == .began {
            UIImageWriteToSavedPhotosAlbum(img, self, #selector(self.saveImgComplete(image:error:context:)), nil)
        }
    }
    
    @objc func panAction(_ pan: UIPanGestureRecognizer) {
        if let panView = pan.view {
            
            let point = pan.translation(in: panView)
            switch pan.state {
            case .began:
                beginTransform = panView.transform
            case .changed:
                var x = max(-(beginTransform.a * panView.bounds.width - IPHONE_WIDTH) / 2, point.x * beginTransform.a + beginTransform.tx)
                x = min((beginTransform.a * panView.bounds.width - IPHONE_WIDTH) / 2, x)
                var y = max(-(beginTransform.d * panView.bounds.height - IPHONE_HEIGHT) / 2, point.y * beginTransform.d + beginTransform.ty)
                y = min((beginTransform.d * panView.bounds.height - IPHONE_HEIGHT) / 2, y)
                panView.transform = CGAffineTransform(a: beginTransform.a, b: beginTransform.b, c: beginTransform.c, d: beginTransform.d, tx: x, ty: y)
            default: break
            }
            
        }
    }

    @objc func saveImgComplete(image: UIImage, error: Error?, context: UnsafeRawPointer) {

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

