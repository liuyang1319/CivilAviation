//
//  LYLicenseAircraftTypeController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYAircraftTypeController: BaseController {

    private let kLYAircaftTypeCell = "LYAircaftTypeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "机型信息", English: "Aircraft Type")
        cellArray = [
            kLYAircaftTypeCell
        ]
        addTableViewHeader()
        addTableViewFootview()
        getData()
    }
    
    override func getData() {
        LYLicenseViewModel.getPlaneType(pageNum: nextPageFlag) { (datas, error) in
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

extension LYAircraftTypeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYAircaftTypeCell) as! LYAircaftTypeCell
        if dataArray.count > indexPath.row {
            cell.setValue(model: dataArray[indexPath.row] as! LYPlaneTypeModel)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
