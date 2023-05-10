//
//  RegistrationTableViewController.swift
//  HotelManzanaStoryBoard
//
//  Created by H.Namikawa on 2023/05/08.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
  
  var registrations: [Registration] = []
  var selectedRegistration: Registration?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return registrations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
    let registration = registrations[indexPath.row]
    
    var content = cell.defaultContentConfiguration()
    content.text = registration.firstName + " " + registration.lastName
    content.secondaryText =
    (registration.checkInDate..<registration.checkOutDate).formatted(date:.numeric, time:.omitted)
    + " : " + registration.roomType.name
    cell.contentConfiguration = content
                                                    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedRegistration = registrations[indexPath.row]
    //tableView.deselectRow(at: indexPath, animated: true)
    
    performSegue(withIdentifier: "selectRegistration", sender: nil)
    
//    let addRegistrationTVC = AddRegistrationTableViewController()
//    addRegistrationTVC.selectedRegistration = self.selectedRegistration
//    let nvc = UINavigationController(rootViewController: addRegistrationTVC)
//    present(nvc, animated: true)
  }
  
  @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue){
    guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
          let registration = addRegistrationTableViewController.registration else {return}
    
    if let selectedRegistration = addRegistrationTableViewController.selectedRegistration {
      let indexPath = tableView.indexPathForSelectedRow!
      registrations[indexPath.row] = registration
    } else {
      registrations.append(registration)
    }
    
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "selectRegistration" {
      let nvc = segue.destination as! UINavigationController
      let addRegistrationTVC = nvc.topViewController as! AddRegistrationTableViewController
      addRegistrationTVC.selectedRegistration = self.selectedRegistration
    }
  }
  
}

