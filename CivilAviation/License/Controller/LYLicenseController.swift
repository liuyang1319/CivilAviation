//
//  LYLicenseController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYLicenseController: BaseController {

    private let kLYLicenseTitleCell = "LYLicenseTitleCell"
    private let kLYLicensePersonCardCell = "LYLicensePersonCardCell"
    private let kLYLicenseTypeCell = "LYLicenseTypeCell"
    private let kLYLicenseAircraftTypeCell = "LYLicenseAircraftTypeCell"
    private let headerTitleArray = [
        "",
        "",
        "执照类型",
        "有效机型"
    ]
    
    private let headerSubTitleArray = [
        "",
        "",
        "英语等级",
        ""
    ]
    
    private var model: LYLicenseModel?
//    private var QR = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(title: "执照信息", English: "License")
        cellArray = [
            kLYLicenseTitleCell,
            kLYLicensePersonCardCell,
            kLYLicenseTypeCell,
            kLYLicenseAircraftTypeCell
        ]
        
        getData()
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.mj_h -= TabBarHeight
    }
    
    override func addLeftBtn() {}
    
    override func getData() {
        LYLicenseViewModel.getLicense { (model, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.model = model
            self.tableView.reloadData()
        }
    }
}

extension LYLicenseController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return model?.licenseTypes.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYLicenseTitleCell) as! LYLicenseTitleCell
            cell.setValue(noText: model?.licenseNo ?? "")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYLicensePersonCardCell) as! LYLicensePersonCardCell
            cell.setValue(model: model)
//            cell.setValue(QR: QR)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYLicenseTypeCell) as! LYLicenseTypeCell
            if (model?.licenseTypes.count ?? 0) > indexPath.row {
                cell.setValue(model: model!.licenseTypes[indexPath.row])
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYLicenseAircraftTypeCell)
            return cell!
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 280
        case 1:
            return 205
        case 2, 3:
            return 50
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 3 {
            return
        }
        
        let controller = LYAircraftTypeController()
        pushController(controller: controller)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2, 3:
            let view = LYLicenseHeaderView.instanceView(type: "LYLicenseHeaderView") 
            (view as! LYLicenseHeaderView).title.text = headerTitleArray[section]
            (view as! LYLicenseHeaderView).subTitle.text = headerSubTitleArray[section]
            return view
        default:
            return super.tableView(tableView, viewForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2, 3:
            return 30
        default:
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
}
