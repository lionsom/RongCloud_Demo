//
//  ViewController.swift
//  RongCloudDemo
//
//  Created by 启业云03 on 2022/11/24.
//

import UIKit

import RongIMKit

import SnapKit

class ViewController: UIViewController {
    // 融云 App Key
    let RCAppKey = "0vnjpoad0mdqz"

    // 融云 App Secret
    let RCAppSecret = "Qha9tnJPT0pKkh"

    lazy var connectBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("初始化SDK", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(connectBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("token登录", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var disconnectBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("断开连接（允许推送）", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(disconnectBtnClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.p_createView()
    }

    func p_createView() {
        view.backgroundColor = UIColor.white

        self.view.addSubview(self.connectBtn)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.disconnectBtn)

        self.connectBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }

        self.loginBtn.snp.makeConstraints { make in
            make.width.height.centerX.equalTo(self.connectBtn)
            make.top.equalTo(self.connectBtn.snp.bottom).offset(30)
        }

        self.disconnectBtn.snp.makeConstraints { make in
            make.width.height.centerX.equalTo(self.connectBtn)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(30)
        }
    }

    @objc func connectBtnClick() {
        print(#function)
        // 初始化RC SDK
        RCIM.shared().initWithAppKey(self.RCAppKey)
    }

    @objc func loginBtnClick() {
        print(#function)
        // 初始化RC SDK
        let token = "34kV1kWSyFK5L8/3lg4r9kXZJSsYVUkl@he97.cn.rongnav.com;he97.cn.rongcfg.com"
        RCIM.shared().connect(withToken: token) { errorCode in
            print(errorCode)
            // 消息数据库打开，可以进入到主页面
        } success: { userId in
            if let userId = userId {
                print("当前登录UserId = " + userId)
                DispatchQueue.main.async {
                    // 连接成功,可跳转至会话列表页
                    let listVC = RCDConversationListViewController(displayConversationTypes: [1, 2], collectionConversationType: nil)
                    // 是否显示网络连接提示，默认为 YES。
                    listVC?.isShowNetworkIndicatorView = true
                    self.navigationController?.pushViewController(listVC!, animated: true)
                }
            }
        } error: { status in
            print(status)
            if status == .RC_CONN_TOKEN_INCORRECT {
                // 从 APP 服务获取新 token，并重连
            } else {
                // 无法连接到 IM 服务器，请根据相应的错误码作出对应处理
            }
        }
    }

    @objc func disconnectBtnClick() {
        // 1.断开连接 允许推送
        RCIM.shared().disconnect()
        // isReceivePush    BOOL    断开连接后，是否允许融云服务端进行远程推送。 YES 表示接收远程推送。NO 表示不接收远程推送。
        // or RCIM.shared().disconnect(true)

        // 2.断开连接 不允许推送
        RCIM.shared().logout()
        // or RCIM.shared().disconnect(false)
    }
}
