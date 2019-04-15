//
//  EmptyStateViewController.swift
//  uikitPractice
//
//  Created by 松岡裕介 on 2019/04/13.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit

class EmptyStateViewController: UIViewController {

    var navBar: UINavigationBar = UINavigationBar();
    let label = UILabel()
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(navBar)
        
        let navItem: UINavigationItem = UINavigationItem(title: "TO DO")

        navItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.add))
        
        navBar.pushItem(navItem, animated: false)

        label.text = """
        Please
        add
        new
        TO DO
        """
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36)
        view.addSubview(label)
    
}
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    @objc func add() {
        let nextvc = AddViewController()
        //nextvc.view.backgroundColor = UIColor.blue
        self.present(nextvc, animated: true, completion: nil)
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
