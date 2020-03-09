//
//  InsertPartyTableViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/4.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class InsertPartyTableViewController: UITableViewController, UITextFieldDelegate {
    var changePhoto = false
    var imageUpload: UIImage?
    var partyImage: Data?
    let url_server = URL(string: common_url + "PartyServlet")
    
    let startDatePicker = UIDatePicker()
    // Start Date的DatePicker
    let endDatePicker = UIDatePicker()   // End Date的DatePicker
    let deadlineDatePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()   // Time的DatePicker
    let deadlineTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let showDateFormatter = DateFormatter()    // 要顯示出來看的日期格式
    let showTimeFormatter = DateFormatter()    // 要顯示出來看的時間格式
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var lowerSlider: UISlider!
    @IBOutlet weak var upperSlider: UISlider!
    @IBOutlet weak var partyAddressTextField: UITextField!
    @IBOutlet weak var partyLocationTextField: UITextField!
    @IBOutlet weak var partyNameTextField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var deadlineTimeTextField: UITextField!
    @IBOutlet weak var deadlineDateTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        createTapGesture()
        setTextView()
        setDatePicker()
        partyNameTextField.delegate = self
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "新增活動"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createTapGesture() {
        let tapHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapHideKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapHideKeyboard)
    }
    
    @objc func hideKeyboard() {
        navigationController?.view.endEditing(true)
    }
    
    @IBAction func changeUpperSlider(_ sender: UISlider) {
        sender.value.round()
        //        value 型別為 Float,要用 Int(sender.value)變成整數
        upperLabel.text = Int(sender.value).description
    }
    
    @IBAction func changeLowerSlider(_ sender: UISlider) {
        sender.value.round()
        lowerLabel.text = Int(sender.value).description
    }
    
    @IBAction func changeDistanceSlider(_ sender: UISlider) {
        sender.value.round()
        distanceLabel.text = Int(sender.value).description
        
    }
    
    
    @IBAction func showPartyImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func setTextView() {
        contentTextView.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        contentTextView.layer.borderWidth = 1.0;
        contentTextView.layer.cornerRadius = 5.0;
    }
    
    func setDatePicker() {
        showDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        showTimeFormatter.dateFormat = "HH:mm"
        
        startDatePicker.backgroundColor = .white
        startDatePicker.datePickerMode = .dateAndTime
        startDatePicker.locale = Locale(identifier: "zh_TW")
        startDatePicker.addTarget(self, action: #selector(startDatePickerChanged), for: .valueChanged)
        startDateTextField.inputView = startDatePicker
        
        startTimePicker.backgroundColor = .white
        startTimePicker.datePickerMode = .time
        startTimePicker.locale = Locale(identifier: "zh_TW")
        startTimePicker.addTarget(self, action: #selector(startTimePickerChanged), for: .valueChanged)
        startTimeTextField.inputView = startTimePicker
        
        endDatePicker.backgroundColor = .white
        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.locale = Locale(identifier: "zh_TW")
        endDatePicker.addTarget(self, action: #selector(endDatePickerChanged), for: .valueChanged)
        endDateTextField.inputView = endDatePicker
        
        endTimePicker.backgroundColor = .white
        endTimePicker.datePickerMode = .time
        endTimePicker.locale = Locale(identifier: "zh_TW")
        endTimePicker.addTarget(self, action: #selector(endTimePickerChanged), for: .valueChanged)
        endTimeTextField.inputView = endTimePicker
        
        deadlineDatePicker.backgroundColor = .white
        deadlineDatePicker.datePickerMode = .dateAndTime
        deadlineDatePicker.locale = Locale(identifier: "zh_TW")
        deadlineDatePicker.addTarget(self, action: #selector(deadlineDatePickerChanged), for: .valueChanged)
        deadlineDateTextField.inputView = deadlineDatePicker
        
        deadlineTimePicker.backgroundColor = .white
        deadlineTimePicker.datePickerMode = .time
        deadlineTimePicker.locale = Locale(identifier: "zh_TW")
        deadlineTimePicker.addTarget(self, action: #selector(deadlineTimePickerChanged), for: .valueChanged)
        deadlineTimeTextField.inputView = deadlineTimePicker
        
    }
    
    @objc func startDatePickerChanged() {
        
        startDateTextField.text =
            showDateFormatter.string(from: startDatePicker.date)
        
    }
    
    @objc func startTimePickerChanged() {
        startTimeTextField.text =
            showTimeFormatter.string(from: startTimePicker.date)
        
    }
    
    @objc func endDatePickerChanged() {
        endDateTextField.text =
            showDateFormatter.string(from: endDatePicker.date)
        
    }
    
    @objc func endTimePickerChanged() {
        endTimeTextField.text =
            showTimeFormatter.string(from: endTimePicker.date)
        
    }
    
    @objc func deadlineDatePickerChanged() {
        deadlineDateTextField.text =
            showDateFormatter.string(from: deadlineDatePicker.date)
        
    }
    
    @objc func deadlineTimePickerChanged() {
        deadlineTimeTextField.text =
            showTimeFormatter.string(from: deadlineTimePicker.date)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
}

extension InsertPartyTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        changePhoto = true
        
        let image = info[.originalImage] as? UIImage
        imageUpload = image
        imageButton.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
