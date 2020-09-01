//
//  LYExperienceController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYExperienceController: BaseController {

    private let kLYExperienceMaintenanceCell = "LYExperienceMaintenanceCell"
    private let kLYExperienceTrainCell = "LYExperienceTrainCell"
    private let kLYExperienceSelectView = "LYExperienceSelectView"
    
    private var typeSelected: ExperienceType = .maintenance
    private var experienceSelected: ExperienceSelect = .first
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "我的经历", English: "My Experience")
        cellArray = [
            kLYExperienceMaintenanceCell,
            kLYExperienceTrainCell
        ]
        
        addTableViewHeader()
        addTableViewFootview()
        reFreshData()
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.mj_h -= TabBarHeight
        tableView.register(
            UINib.init(nibName: kLYExperienceSelectView, bundle: nil),
            forHeaderFooterViewReuseIdentifier: kLYExperienceSelectView
        )
    }
    
    override func addLeftBtn() {}
    
    override func getData() {
        if typeSelected == .maintenance {
            getMaintenance()
        } else {
            getTrain()
        }
    }
    
    private func getMaintenance() {
        LYExperienceViewModel.getMaintenance(type: experienceSelected.rawValue, pageNum: nextPageFlag) { (datas, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.processData(datas: datas!, complate: {
                self.dataArray += datas!
                self.tableView.reloadData()
            })
        }
    }
    
    private func getTrain() {
        LYExperienceViewModel.getTrain(type: experienceSelected.rawValue, pageNum: nextPageFlag) { (datas, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.processData(datas: datas!, complate: {
                self.dataArray += datas!
                self.tableView.reloadData()
            })
        }
    }
}

extension LYExperienceController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if typeSelected == .maintenance {
            return getMaintenanceCell(indexPath: indexPath)
        } else {
            return getTrainCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeSelected == .maintenance {
            return 200
        }
        
        return 180
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: kLYExperienceSelectView) as! LYExperienceSelectView
        view.delegate = self
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    private func getMaintenanceCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYExperienceMaintenanceCell) as! LYExperienceMaintenanceCell
        if dataArray.count > indexPath.row && dataArray is [LYMaintenanceModel] {
            cell.setValue(model: dataArray[indexPath.row] as! LYMaintenanceModel)
        }
        return cell
    }
    
    private func getTrainCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYExperienceTrainCell) as! LYExperienceTrainCell
        if dataArray.count > indexPath.row && dataArray is [LYTrainModel] {
            cell.setValue(model: dataArray[indexPath.row] as! LYTrainModel)
        }
        return cell
    }
}

extension LYExperienceController: LYExperienceSelectViewDelegate {
    /// LYExperienceSelectViewDelegate
    func btnClicked(typeSelected: ExperienceType, experienceSelected: ExperienceSelect) {
        self.typeSelected = typeSelected
        self.experienceSelected = experienceSelected
        reFreshData()
    }
    
    
}
