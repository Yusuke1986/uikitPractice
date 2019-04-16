//
//  ToDoListViewController.swift
//  uikitPractice
//
//  Created by 松岡裕介 on 2019/04/14.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit

enum ToDoStatus {
    case open
    case close
}

class ToDo {
    var title: String
    var description: String
    var status: ToDoStatus
    var id: String
    
    init() {
        self.title = ""
        self.description = ""
        self.status = .open
        self.id = ""
    }
    
    init(title: String) {
        self.title = title
        self.description = ""
        self.status = .open
        self.id = ""
    }
}

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var navBar: UINavigationBar = UINavigationBar();
    var tableView: UITableView?
    var items:[ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        let navItem: UINavigationItem = UINavigationItem(title: "TO DO")
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.add))
        
        navBar.pushItem(navItem, animated: false)
        

        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
            tableView.autoresizingMask = [
                .flexibleWidth,
                .flexibleHeight
            ]
            
            tableView.delegate = self
            tableView.dataSource = self
            
            self.view.addSubview(tableView)
            
            return tableView            
        }()
        
        loadConstraints()
        
        view.addSubview(navBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
    }
    
    func loadConstraints() {
        
        let tableView = self.tableView!
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 80)
            ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.count > 0 {
            emptyMessage(message: "", tableView: self.tableView!)
            return 1
        } else {
            emptyMessage(message: """
        Please
        add
        new
        TO DO
        """, tableView: self.tableView!)
            return 0

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = self.items[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(self.items[indexPath.row])")
    }
    
    
    @objc func add() {
        let nextvc = FormViewController()
        
        nextvc.passController(toDo: ToDo(), parentController: self)
        
        self.present(nextvc, animated: true, completion: nil)
    }
    
    func emptyMessage(message:String, tableView: UITableView) {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = message
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 48)
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
