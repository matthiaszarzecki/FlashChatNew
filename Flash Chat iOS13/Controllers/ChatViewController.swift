//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Shruti on 21/05/2020.
//  Copyright © 2020 Shruti. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    //var messages: [Message] = [Message(sender: "shruti@gmail.com", body: "hello"), Message(sender: "sid@gmail.com", body: "hello"),Message(sender: "shruti@gmail.com", body: "wassup, hello how are khana khake jana, bye bye")]
    
    var messages: [Message] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier:K.cellIdentifier )
        
        loadMessages()
    }
    
    func loadMessages() {
        //messages = []
        
        //db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []

            if let e = error{
                print("issue in retrieving data from Firestore - \(e)")
            }else{
                //querySnapshot?.documents[0].data()[K.FStore.senderField]
                
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        print("whole data is - \(doc.data())")
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                // code to go to the last cell in table view
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                            
                            
                        }
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("error issue saving data to firestore - \(e)")
                }else{
                    print("successfully saved data")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
            //let firebaseAuth = Auth.auth()
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return messages .count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //message from current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        // message from another sender
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        

        //cell.textLabel?.text = messages[indexPath.row].body
        //"\(indexPath.row)"
        
        return cell
      }
}

