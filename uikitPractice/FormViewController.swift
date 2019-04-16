//
//  AddViewController.swift
//  uikitPractice
//
//  Created by 松岡裕介 on 2019/04/14.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var navBar: UINavigationBar = UINavigationBar()
    var labelTitle = UILabel()
    var labelDesc = UILabel()
    var labelStatus = UILabel()
//
    var textTitle = UITextField()
    var textDesc = UITextView()
    var statusPicker = UIPickerView()
    var removeBtn = UIButton()
    
    var toDo:ToDo = ToDo()
    var parentController: ToDoListViewController? = nil
    
    
    let statusList = ["Open","Close"]
    
    func passController(toDo: ToDo, parentController: ToDoListViewController) {
        self.toDo = toDo
        self.parentController = parentController
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        labelTitle.text = "Title"
        labelTitle.font = UIFont.systemFont(ofSize: 20)
        labelDesc.text = "Description"
        labelDesc.font = UIFont.systemFont(ofSize: 20)
        labelDesc.numberOfLines = 0
        labelStatus.text = "Status"
        
        // 枠線のスタイルを設定
        textTitle.borderStyle = .roundedRect
    
        textDesc.layer.borderColor = UIColor.gray.cgColor
        textDesc.layer.borderWidth = 0.25
        textDesc.layer.cornerRadius = 10.0
        textDesc.layer.masksToBounds = true
        
        //全消去ボタンの設定
        textTitle.clearButtonMode = .always
//        textDesc.clearButtonMode = .always
        
        let navItem: UINavigationItem = UINavigationItem(title: "Add")
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(self.updateList))
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: #selector(self.returnView))
        
        navBar.pushItem(navItem, animated: false)
        
        // プロトコルの設定
        statusPicker.delegate = self
        statusPicker.dataSource = self
        // はじめに表示する項目を指定
        statusPicker.selectRow(1, inComponent: 0, animated: true)

        
        removeBtn.backgroundColor = .red
        removeBtn.setTitle("REMOVE", for: .normal)
        removeBtn.setTitleColor(.white, for: .normal)
        
        //constraints
        loadConstraints()
        
        view.addSubview(navBar)
        view.addSubview(labelTitle)
        view.addSubview(labelDesc)
        view.addSubview(labelStatus)
        view.addSubview(textTitle)
        view.addSubview(textDesc)
        view.addSubview(statusPicker)
        view.addSubview(removeBtn)
        
    }
    
    func loadConstraints() {
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            labelTitle.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20.0),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
            ])
        
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            textTitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10.0),
            textTitle.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            textTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            textTitle.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        labelDesc.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            labelDesc.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 20.0),
            labelDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
            ])
        
        textDesc.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            textDesc.topAnchor.constraint(equalTo: labelDesc.bottomAnchor, constant: 10.0),
            textDesc.leadingAnchor.constraint(equalTo: labelDesc.leadingAnchor),
            textDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            textDesc.heightAnchor.constraint(equalToConstant: 120)
            ])
        
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            labelStatus.topAnchor.constraint(equalTo: textDesc.bottomAnchor, constant: 20.0),
            labelStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
            ])
        
        statusPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            statusPicker.topAnchor.constraint(equalTo: labelStatus.bottomAnchor, constant: 10.0),
            statusPicker.leadingAnchor.constraint(equalTo: labelStatus.leadingAnchor),
            statusPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            statusPicker.heightAnchor.constraint(equalToConstant: 80)
            ])
        
        removeBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            removeBtn.topAnchor.constraint(equalTo: statusPicker.bottomAnchor, constant: 20.0),
            removeBtn.leadingAnchor.constraint(equalTo: statusPicker.leadingAnchor),
            removeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            removeBtn.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func updateList() {
        let rowIndex = statusPicker.selectedRow(inComponent: 0)
        let rowValue = statusList[rowIndex]
        
        self.toDo.id = UUID().uuidString
        self.toDo.title = textTitle.text!
        self.toDo.description = textDesc.text
        self.toDo.status = rowValue == "Open" ?.open:.close
        self.parentController?.items.append(self.toDo)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func returnView() {
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // アイテム表示個数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusList.count
    }
    // 表示する文字列を返す
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return statusList[row]
    }
    // 選択時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(statusList[row])
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
