//
//  EventTableViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/22.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let cellId = "reuseIdentifier"
class EventTableViewController: UITableViewController {

    public var vcType : EventType?

    private var arrDate : [String] = []
    
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
    }
    
    private func dataInit() {
        let arr = MainViewModel.fetchEnent(vcType!).compactMap{ dateFor.string(from: $0.eventDate! as Date) }
        arr.forEach { (str) in
            if !arrDate.contains(str) {
                arrDate.append(str)
            }
        }
        tableView.reloadData()
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
}
