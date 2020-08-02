//
//  FYAddressPickerView.swift
//  joint-operation
//
//  Created by Yan on 2018/12/11.
//  Copyright © 2018 Yan. All rights reserved.
//

import UIKit

@objcMembers
open class FYAddressPickerView: UIView {

    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var comp = 3 {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var provs = [ProvinceModel]()
    
    var citys = [CityModel]()
    
    var areas = [AreaModel]()
    
    var prov = ProvinceModel()
    
    var city = CityModel()
    
    var area = AreaModel()
    
    var complete: ((_ address: FYAddressModel)-> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        let oneView = UINib(nibName: "FYAddressPickerView", bundle: nil).instantiate(withOwner: self, options: nil).last as! UIView
        oneView.frame = bounds
        addSubview(oneView)
        pickerView.dataSource = self
        pickerView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        oneView.addGestureRecognizer(tap)
        alpha = 0
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        FYAddressPickerView.hiden()
    }
    
    @IBAction func commitBtnAction(_ sender: UIButton) {
        FYAddressPickerView.hiden()
        let address = FYAddressModel()
        address.province = prov.name
        address.proCode = prov.code
        address.city = city.name
        address.cityCode = city.code
        address.area = area.name
        address.areaCode = area.code
        complete(address)
    }
    
//    @discardableResult
    @objc public static func show(complete: @escaping (_ address: FYAddressModel) -> Void) -> FYAddressPickerView {
        hiden()
        let picker = FYAddressPickerView(frame: UIScreen.main.bounds)
        picker.complete = complete
        picker.tag = -1112
        UIApplication.shared.keyWindow?.addSubview(picker)
        CATransaction.setCompletionBlock {
            picker.bottom.constant = 0
            UIView.animate(withDuration: 0.3) {
                picker.alpha = 1
                picker.layoutIfNeeded()
                picker.layoutSubviews()
            }
        }
        picker.provs = UserManager.share().provinceList as! [ProvinceModel]
        if let prov = picker.provs.first {
            picker.prov = prov
            picker.citys = prov.cityList as! [CityModel]
            if let city = picker.citys.first {
                picker.city = city
                picker.areas = city.areaList as! [AreaModel]
                if let area = picker.areas.first {
                    picker.area = area
                }
            }
        }
        picker.pickerView.reloadAllComponents()
        return picker
    }
    
    @objc public static func hiden() {
        guard let picker = UIApplication.shared.keyWindow?.viewWithTag(-1112) as? FYAddressPickerView else {return}
        picker.bottom.constant = -300
        UIView.animate(withDuration: 0.3, animations: {
            picker.alpha = 0
            picker.layoutIfNeeded()
        }) { (success) in
            picker.removeFromSuperview()
        }
    }
    
    @objc func tapAction() {
        FYAddressPickerView.hiden()
    }
    
}

extension FYAddressPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return comp
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provs.count
        } else if component == 1 {
            return citys.count
        } else {
            return areas.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .center
        if component == 0 {
            lab.text = provs[row].name
        } else if component == 1 {
            lab.text = citys[row].name
        } else if component == 2 {
            lab.text = areas[row].name
        }
        return lab
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if provs.count == 0 { return }
            self.prov = provs[row]
            if comp < 2 { return }
            self.citys = provs[row].cityList as! [CityModel]
            self.pickerView.reloadComponent(1)
            if let city = self.citys.first {
                self.city = city
                self.pickerView.selectRow(0, inComponent: 1, animated: true)
                if comp < 3 {return}
                self.areas = city.areaList as! [AreaModel]
                self.pickerView.reloadComponent(2)
                if let area = self.areas.first {
                    self.area = area
                    self.pickerView.selectRow(0, inComponent: 2, animated: true)
                }
            }
        } else if component == 1 {
            if citys.count == 0 { return }
            self.city = citys[row]
            if comp < 3 {return}
            self.areas = citys[row].areaList as! [AreaModel]
            self.pickerView.reloadComponent(2)
            if let area = self.areas.first {
                self.area = area
                self.pickerView.selectRow(0, inComponent: 2, animated: true)
            }
        } else if component == 2 {
            if areas.count == 0 { return }
            self.area = areas[row]
        }
    }
}

@objcMembers
open class FYAddressModel: NSObject {
    var province = ""
    var city = ""
    var area = ""
    var proCode = ""
    var cityCode = ""
    var areaCode = ""
}
