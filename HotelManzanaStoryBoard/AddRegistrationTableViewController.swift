//
//  AddRegistrationTableViewController.swift
//  HotelManzanaStoryBoard
//
//  Created by H.Namikawa on 2023/05/08.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  
  
  @IBOutlet var checkInDateLabel: UILabel!
  @IBOutlet var checkOutDeteLabel: UILabel!
  @IBOutlet var checkInDatePicker: UIDatePicker!
  @IBOutlet var checkOutDatePicker: UIDatePicker!
  
  
  @IBOutlet var numberOfAdultsLabel: UILabel!
  @IBOutlet var numberOfChildrenLabel: UILabel!
  @IBOutlet var numberOfAdultsStepper: UIStepper!
  @IBOutlet var numberOfChildrenStepper: UIStepper!
  
  @IBOutlet var wifiSwitch: UISwitch!
  
  @IBOutlet var roomTypeLabel: UILabel!
  var roomType: RoomType?
  
  var selectedRegistration: Registration?
  
  var registration: Registration? {
    guard let roomType = roomType else {return nil}
    
    let firstName = firstNameTextField.text ?? ""
    let lastName = lastNameTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let checkInDate = checkInDatePicker.date
    let checkOutDate = checkOutDatePicker.date
    let numberOfAdults = Int(numberOfAdultsStepper.value)
    let numberOfChildren = Int(numberOfChildrenStepper.value)
    let hasWifi = wifiSwitch.isOn
    
    return Registration(firstName: firstName,
                        lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    
  }
  
  let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
  let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
  let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
  let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
  
  var isCheckInDatePickerVisible: Bool = false {
    didSet{
      checkInDatePicker.isHidden = !isCheckInDatePickerVisible
    }
  }
  var isCheckOutDatePickerVisible: Bool = false {
    didSet{
      checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
    }
  }
  
  func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
    
    self.roomType = roomType
    updateRoomType()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let midNightToday = Calendar.current.startOfDay(for: Date())
    checkInDatePicker.minimumDate = midNightToday
    checkInDatePicker.date = midNightToday
    updateRegistration()
    
    updateDateViews()
    updateNumberOfGuests()
    updateRoomType()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
      return 0
    case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
      return 0
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath{
    case checkInDatePickerCellIndexPath:
      return 200
    case checkOutDatePickerCellIndexPath:
      return 200
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
      isCheckInDatePickerVisible.toggle()
    } else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
      isCheckOutDatePickerVisible.toggle()
    } else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
      isCheckInDatePickerVisible.toggle()
      isCheckOutDatePickerVisible.toggle()
    } else {
      return
    }
    
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
    
  }
  
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
    
    updateDateViews()
  }
  
  @IBAction func stepperValueChanged(_ sender: Any) {
    updateNumberOfGuests()
  }
  
  
  @IBAction func wifiSwitchChanged(_ sender: Any) {
    
  }

  @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
    
    let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
    selectRoomTypeController?.delegate = self
    selectRoomTypeController?.roomType = roomType
    
    return selectRoomTypeController
  }
  
  func updateRegistration() {
    
    if let registration = selectedRegistration {
      firstNameTextField.text = registration.firstName
      lastNameTextField.text = registration.lastName
      emailTextField.text = registration.emailAddress
      checkInDatePicker.date = registration.checkInDate
      checkOutDatePicker.date = registration.checkOutDate
      numberOfAdultsStepper.value = Double(registration.numberOfAdults)
      numberOfChildrenStepper.value = Double(registration.numberOfChildren)
      wifiSwitch.isOn = registration.wifi
      roomType = registration.roomType
    }
  }
  
  func updateDateViews() {
    
    checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
    
    checkInDateLabel.text =
    checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    checkOutDeteLabel.text =
    checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    
    
    //var diffDate = checkOutDatePicker.date.
    
  }
  
  func updateNumberOfGuests() {
    numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
    numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
  }
  
  func updateRoomType() {
    if let roomType = roomType {
      roomTypeLabel.text = roomType.name
    } else {
      roomTypeLabel.text = "Not Set"
    }
  }
}
