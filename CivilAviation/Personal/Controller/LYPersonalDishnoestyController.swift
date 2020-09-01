//
//  LYPersonalDishnoestyController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalDishnoestyController: BaseController {

    private let kLYPersonalDishonestyTitleCell = "LYPersonalDishonestyTitleCell"
    private let kLYPersonalDishonestyInfoCell = "LYPersonalDishonestyInfoCell"
    private let kLYPersonalDishonestyQRCell = "LYPersonalDishonestyQRCell"
    
    private var model: LYDishonestysModel?
    var personInfo: LYPersonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "失信行为记录", English: "Record of Dishonesty")
        cellArray = [
            kLYPersonalDishonestyTitleCell,
            kLYPersonalDishonestyInfoCell,
            kLYPersonalDishonestyQRCell
        ]
        
        getData()
    }
    
    override func getData() {
        LYPersonViewModel.getDishonestys { (model, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.model = model
            self.tableView.reloadData()
        }
    }

}

extension LYPersonalDishnoestyController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalDishonestyTitleCell)
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalDishonestyInfoCell) as! LYPersonalDishonestyInfoCell
            cell.setValue(model: personInfo)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalDishonestyQRCell) as! LYPersonalDishonestyQRCell
            cell.setValue(model: model)
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 80
        case 3:
            return 340
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
