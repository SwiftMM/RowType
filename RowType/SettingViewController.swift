//
//  SettingViewController.swift
//  RowType
//
//  Created by Kaola on 2019/3/18.
//  Copyright © 2019 Kaola. All rights reserved.
//

import UIKit

final class SettingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "设置"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
    }
    
}

/// UITableViewDataSource && UITableViewDelegate

extension SettingViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        guard let rowType = RowType(rawValue: indexPath.row) else {
            return cell
        }
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = rowType.presentable.title
        cell.textLabel?.font = UIFont(name: "Lato-Regular", size: 17.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let rowType = RowType(rawValue: indexPath.row) else {
            return
        }
        
        guard let vc = rowType.presentable.rowViewController else {
            return
        }
        vc.title = rowType.presentable.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

typealias RowAction = () -> ()

protocol RowPresentable {
    var title: String { get }
    /// rowViewController, rowAction should not has value at same time
    var rowViewController: UIViewController? { get }
    var rowAction: RowAction? { get }
}

private extension SettingViewController {
    
    enum RowType: Int, CaseIterable {
        case phone
        case payPassword
        case userProtocol
        case clearCache
        
        var presentable: RowPresentable {
            switch self {
            case .phone:
                return Phone()
            case .payPassword:
                return PayPassword()
            case .userProtocol:
                return UserProtocol()
            case .clearCache:
                return ClearCache()
            }
        }
        
        struct Phone: RowPresentable {
            var title: String { return "手机号" }
            var rowViewController: UIViewController? { return nil }
            var rowAction: RowAction? { return nil }
        }
        
        struct PayPassword: RowPresentable {
            var title: String { return "手机号" }
            var rowViewController: UIViewController? { return ViewController() }
            var rowAction: RowAction? { return nil }
        }
        
        struct UserProtocol: RowPresentable {
            var title: String { return "用户协议" }
            var rowViewController: UIViewController? { return ViewController() }
            var rowAction: RowAction? { return nil }
        }
        
        struct ClearCache: RowPresentable {
            var title: String { return "清除缓存" }
            var rowViewController: UIViewController? { return nil }
            var rowAction: RowAction? { return nil }
        }
    }
}
