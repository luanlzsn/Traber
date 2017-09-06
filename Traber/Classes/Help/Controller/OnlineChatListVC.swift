//
//  OnlineChatListVC.swift
//  Traber
//
//  Created by luan on 2017/9/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class OnlineChatListVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var ticketID = 0
    var chatArray = [ChatModel]()
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Chat History", comment: ""), style: .plain, target: self, action: #selector(checkChat))
        checkChat()
    }
    
    func checkChat() {
        weak var weakSelf = self
        var path = ""
        var params = [String : Any]()
        if ticketID == 0 {
            path = "chat/user"
            params = ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "chatID":0, "count":count]
        } else {
            path = "chat/ticket"
            params = ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "chatID":0, "ticketID":ticketID, "countNumber":count]
        }
        
        AntManage.postRequest(path: path, params: params, successResult: { (response) in
            let array = ChatModel.mj_objectArray(withKeyValuesArray: response["chats"]) as! [ChatModel]
            if array.count >= weakSelf!.count {
                weakSelf?.count += 5
            }
            weakSelf?.chatArray = array.sorted(by: { (chat1, chat2) -> Bool in
                chat1.chatID < chat2.chatID
            })
            weakSelf?.tableView.reloadData()
            weakSelf?.perform(#selector(weakSelf?.checkTableView), afterDelay: 0.02)
        }, failureResult: {
            
        })
    }
    
    func checkTableView() {
        if chatArray.count > 1 {
            tableView.scrollToRow(at: IndexPath(row: chatArray.count - 1, section: 0), at: .none, animated: false)
        }
    }

    @IBAction func submitMessageClick(_ sender: UIButton) {
        kWindow?.endEditing(true)
        if textField.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("Message is required", comment: ""))
            return
        }
        weak var weakSelf = self
        if ticketID == 0 {
            let agentID = (chatArray.count > 0) ? chatArray.last!.agentID : 0
            AntManage.postRequest(path: "chat/add/user", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "agentID":agentID, "message":textField.text!], successResult: { (response) in
                weakSelf?.textField.text = ""
                weakSelf?.checkChat()
            }, failureResult: {})
        } else {
            AntManage.postRequest(path: "chat/add/ticket", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "ticketID":ticketID, "message":textField.text!], successResult: { (response) in
                weakSelf?.textField.text = ""
                weakSelf?.checkChat()
            }, failureResult: {})
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = chatArray[indexPath.row]
        if model.isUser {
            let cell: OnlineUserCell = tableView.dequeueReusableCell(withIdentifier: "OnlineUserCell", for: indexPath) as! OnlineUserCell
            cell.userImage.sd_setImage(with: URL(string: AntManage.userModel!.image), placeholderImage: UIImage(named: "default_image"), options: .refreshCached)
            cell.nickName.text = AntManage.userModel!.firstname + AntManage.userModel!.lastname
            cell.time.text = model.tm
            cell.message.text = model.message
            return cell
        } else {
            let cell: OnlineStaffCell = tableView.dequeueReusableCell(withIdentifier: "OnlineStaffCell", for: indexPath) as! OnlineStaffCell
            cell.nickName.text = NSLocalizedString("AgentID:", comment: "") + "\(model.agentID)"
            cell.time.text = model.tm
            cell.message.text = model.message
            return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
