//
//  LYSwiftBaseController.swift
//  PipixiaService
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 liuyang. All rights reserved.
//

import UIKit
import SwiftEventBus

let kLYSwiftBaseTag = 1019355

class BaseController:
UIViewController,
UITableViewDelegate,
UITableViewDataSource
{
    private var titleString = ""
    private var English = ""
    
    public var dataArray: Array<Any>!           = []                                //数据源
    public var nextPageFlag: Int                = 1                                 //分页
    public var cellHeightDic                    = [String:String]()                 //存放cell高度字典
    public var tableView: UITableView           = UITableView.init()                //tableView
    public var cellArray: [String] {                                                //注册xib cell
        get {
            return []
        }
        
        set {
            for item: String in newValue {
                let nib = UINib.init(nibName: item,
                                     bundle: nil)
                self.tableView.register(nib,
                                        forCellReuseIdentifier: item)
            }
        }
    }
    
    deinit {
        SwiftEventBus.unregister(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitle(title: titleString , English: English)
    }
    
    //    MARK: --- viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    //    MARK: ---- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BackColor
        edgesForExtendedLayout = .all
        automaticallyAdjustsScrollViewInsets = false
        extendedLayoutIncludesOpaqueBars = true
        modalPresentationCapturesStatusBarAppearance = false
        initTableView()
        addLeftBtn()
    }
    
    func initTableView() {
        let frame:CGRect = CGRect(
            x: 0,
            y: StatusBarAndNavHeight,
            width: kScreenWidth,
            height: view.mj_h - StatusBarAndNavHeight
        )
        tableView = UITableView (frame: frame, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.backgroundColor = BackColor
        self.view.addSubview(tableView)
        //        MARK: ios 11上边距
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
    }
    
    @objc func controllerWillPopHandler() {
    }
    
    //    MARK: 弹出功能待开发
    func toastStay() {
        toast(toast: "此功能暂未开放")
    }
    
    //    MARK: 显示错误提示
    func toastError(error: Error) {
        toast(toast: (error as NSError).domain)
        self.tableView.mj_header?.endRefreshing()
        self.tableView.mj_footer?.endRefreshing()
    }
    
    func toast(toast: String) {
        if toast.count == 0 {
            return
        }
        
        CBToast.showToastAction(message: toast as NSString)
    }
    
    /// push controller
    func pushController(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    /// pop controlelr
    func popController() {
        popController(animated: true)
    }
    
    func popController(animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
    
    func setTitle(title: String, English: String) {
        if navigationController == nil {
            return
        }
        
        if !(navigationController is LYNavigationController) {
            self.title = title
            return
        }
        
        self.titleString = title
        self.English = English
        (navigationController as! LYNavigationController).setTitle(title: title, English: English)
    }
    
    /// 创建一个alert
    func getAlert(
        title: String?,
        actions: [UIAlertAction]) -> UIAlertController {
        return getAlert(title: title, message: nil, actions: actions)
    }
    
    func getAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction.init(
            title: "取消",
            style: .cancel,
            handler: nil
        )
        alert.addAction(cancel)
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
    
    /// 弹出一个alert
    func alert(
        title: String?,
        actions: [UIAlertAction]) {
        alert(title: title, message: nil, actions: actions)
    }
    
    func alert(
        title: String?,
        message: String?,
        actions: [UIAlertAction]) {
        
        let alert = getAlert(
            title: title,
            message: message,
            actions: actions
        )
        present(alert, animated: true, completion: nil)
    }
    
    func showNavBarBottomLine() {
        if navigationController is LYNavigationController {
            let navi = navigationController as! LYNavigationController
            navi.showNavBarBottomLine()
        }
    }
    
    func hideNavBarBottomLine() {
        if navigationController is LYNavigationController {
            let navi = navigationController as! LYNavigationController
            navi.hideNavBarBottomLine()
        }
    }
    
    /// 添加画右按钮 默认黑色
    ///
    /// - Parameters:
    ///   - title: title
    ///   - action: action
    func addRightBtn(title: String,
                     action: Selector) {
        addRightBtn(title: title, color: UIColor.black, action: action)
    }
    
    /// 添加画右按钮
    ///
    /// - Parameters:
    ///   - title: title
    ///   - color: textColor
    ///   - action: action
    func addRightBtn(title: String,
                     color: UIColor,
                     action: Selector) {
        let rightBtn = UIButton.init(type: .system)
        rightBtn.setTitleColor(color, for: .normal)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.addTarget(self, action: action, for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem.init(customView: rightBtn)
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    //    MARK: 返回按钮时是否显示alert
    func isShowLeftAlert() -> Bool {
        return false
    }
    
    //    MARK: 添加返回按钮
    func addLeftBtn() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            image: UIImage.init(named: "back_white"),
            style: .done,
            target: self,
            action: #selector(leftBtnClicked)
        )
    }
    
    //    MARk:返回
    @objc func leftBtnClicked() {
        if !isShowLeftAlert() {
            popController()
            return
        }
        
        leftAlert()
    }
    /// 放弃改动alert
    func leftAlert() {
        leftAlert(title: "确认放弃当前改动吗？")
    }
    
    func leftAlert(title: String) {
        let confirm = UIAlertAction.init(
            title: "确定",
            style: .default) { (action) in
                self.popController()
        }
        
        alert(title: title, actions: [confirm])
    }
}


extension BaseController {
    
    //    MARK get tag
    public func getTag(tag: Int, indexPath: IndexPath) -> String{
        let newTag = tag + indexPath.section*100 + indexPath.row;
        return "\(newTag)";
    }
    
    //    MARK get tag
    public func getTag(indexPath: IndexPath) -> String{
        return self.getTag(tag: kLYSwiftBaseTag, indexPath: indexPath)
    }
    
    
    //    MARK: 更新cellHeightDic
    @objc public func updateCellHeightDic(cellHeight: CGFloat, indexPath: IndexPath) {
        self.updateCellHeightDic(cellHeight: cellHeight, indexPath: indexPath, tag: kLYSwiftBaseTag)
    }
    
    @objc public func updateCellHeightDic(cellHeight: CGFloat, indexPath: IndexPath, tag: Int) {
        self.cellHeightDic.updateValue("\(cellHeight)",forKey:self.getTag(
            tag: tag,
            indexPath: indexPath
        ))
    }
    
    //    MARK: 根据tag取得高度
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, tag: Int) -> CGFloat {
        let heightStr: String = self.cellHeightDic[self.getTag(
            tag: tag,
            indexPath: indexPath
        )] ?? "0"
        var height: CGFloat = heightStr.toFloat()
        if height == 0 {
            height = 0.1
        }
        return height
    }
    
    //  MARK tableView delegate
    @objc dynamic func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath, tag: kLYSwiftBaseTag)
    }
    
    @objc dynamic func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init();
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @objc dynamic func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}

extension BaseController {
    //    MARK: 添加 MJ Header
    @objc dynamic func addTableViewHeader() {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.reFreshData()
        })
    }
    
    //    MARK: 删除 MJ Header
    @objc dynamic func deleteTableViewHeader() {
        self.tableView.mj_header = nil
    }
    
    //    MARK: 添加 MJ Footer
    @objc dynamic func addTableViewFootview() {
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.nextPageFlag += 1
            self.getData()
        })
    }
    
    //    MARK: 删除 MJ Footer
    @objc dynamic func deleteTableViewFootview() {
        self.tableView.mj_footer = nil
    }
    
    //    MARK: 刷新
    @objc dynamic func reFreshData() {
        self.nextPageFlag = 1;
        self.cellHeightDic.removeAll()
        self.dataArray.removeAll()
        self.tableView.mj_footer?.resetNoMoreData()
        self.tableView.reloadData()
        self.getData()
    }
    
    //    MARK: 加载数据
    //    MARK: 获取数据
    @objc func getData() {
        
    }
    
    //    MARK: 过滤数据 如果加载没有数据就endRefreshingWithNoMoreData
    @objc func processData(datas: [Any], complate: @escaping () -> ()) {
        self.tableView.mj_header?.endRefreshing()
        self.tableView.mj_footer?.endRefreshing()

        if datas.count == 0 && self.nextPageFlag > 1 {
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            complate()
        }
    }
}
