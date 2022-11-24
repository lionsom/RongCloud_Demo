//
//  RCDConversationListViewController.swift
//  RongCloudDemo
//
//  Created by 启业云03 on 2022/11/24.
//

import Foundation

import RongIMKit
import UIKit

class RCDConversationListViewController: RCConversationListViewController {
    // Cell Click - 自定义
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        print(#function)

        if let vc = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId) {
            vc.title = "title: " + model.targetId
            vc.navigationController?.navigationBar.barTintColor = UIColor.green
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
