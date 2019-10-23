//
//  EventTableViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let cellId = "reuseIdentifier"
class EventTableViewController: UITableViewController,BmobEventDelegate {

    func bmobEventDidConnect(_ event: BmobEvent!) {
        print("bmobEventDidConnect")
    }
    
    func bmobEventCanStartListen(_ event: BmobEvent!) {
        
        self.eventList.listenRowChange(BmobActionTypeDeleteRow, tableName: "eventModel", objectId: "fbc516e670")
//        listenTableChange(BmobActionTypeUpdateTable, tableName: "eventModel")
    }
    
    func bmobEvent(_ event: BmobEvent!, didReceiveMessage message: String!) {
        self.dataInit()
    }
    
    public var vcType : EventType?

    private var arrDate : [String] = []
    private var arrModel : [MainBmobModel]?
    
    let dateFor = {()->DateFormatter in
        let dd = DateFormatter()
        dd.dateFormat = "yyyy年MM月dd日 HH:mm"
        return dd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(popToViewController))
        title = vcType![]
        dataInit()
        listEvent()
    }
    
    private var eventList:BmobEvent = BmobEvent.default()
    private func listEvent() {
        eventList.delegate = self
        eventList.start()
    }
    
    private func dataInit() {
        
        MainBmobViewModel.fetchEnent(vcType!) {[weak self] (arrModel) in
            guard let `self` = self else{return}
            self.arrModel = arrModel
            self.arrDate.removeAll()
            let arr = arrModel.compactMap{ self.dateFor.string(from: $0.eventDate) }
            arr.forEach { (str) in
                if !self.arrDate.contains(str) {
                    self.arrDate.append(str)
                }
            }
            self.tableView.reloadData()
        }
    }

    @objc func popToViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDate.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
           cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = arrDate[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let arr = arrModel,
            let id = arr[indexPath.row].objectId {
            MainBmobViewModel.delete(id) {[weak self] in
                guard let `self` = self else{return}
//                self.dataInit()
            }
        }
    }
}
