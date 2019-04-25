//
//  AddregistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Давид on 22/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

//
import UIKit

class AddregistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var chekInDateLabel: UILabel!
    @IBOutlet weak var chekInDatePicker: UIDatePicker!
    @IBOutlet weak var chekOutDateLabel: UILabel!
    @IBOutlet weak var chekOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdults: UILabel!
    @IBOutlet weak var numberOfChildren: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var priceRoomLabel: UILabel!
    
    
    let chekInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let chekInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    
    let chekOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    let chekOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isChekInDatePickerShown: Bool = false {
        didSet {
            chekInDatePicker.isHidden = !isChekInDatePickerShown
        }
    }
    var isChekOutDatePickerShown: Bool = false {
        didSet {
            chekOutDatePicker.isHidden = !isChekOutDatePickerShown
        }
    }
    
    let roomTypeIndexPath = IndexPath(row: 0, section: 4)
    let priceIndexPath = IndexPath(row: 1, section: 4)
    
    var isPriceIndexPathShown = false
    
    var roomsType = [RoomType]()
    var roomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomsType = RoomType.all
        
        // consider the current day from the beginning, due to the time difference in different countries
        let midnightToday = Calendar.current.startOfDay(for: Date())
        chekInDatePicker.minimumDate = midnightToday
        chekOutDatePicker.date = midnightToday
        
        updateRoomType()
        updateDateViews()
    }
    
    func updateDateViews() {
        
        // check-out date can be 1 day after check-in
        chekOutDatePicker.minimumDate = chekInDatePicker.date.addingTimeInterval(24 * 3600)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        chekInDateLabel.text = dateFormatter.string(from: chekInDatePicker.date)
        chekOutDateLabel.text = dateFormatter.string(from: chekOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        
        numberOfAdults.text = String(Int(numberOfAdultsStepper.value))
        numberOfChildren.text = String(Int(numberOfChildrenStepper.value))
        
    }
    
    @IBAction func buttonPressed() {
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let chekInDate = chekInDatePicker.date
        let chekOutDate = chekOutDatePicker.date
        let numberOfAdult = Int(numberOfAdults.text!)!
        let numberOfChilds = Int(numberOfChildren.text!)!
        let wifi = wifiSwitch.isOn
        let roomTypeChosen = roomType
        
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAddres: email,
            checkInDate: chekInDate,
            checkOutDate: chekOutDate,
            namberOfAdults: numberOfAdult,
            namberOfChildren: numberOfChilds,
            roomType: RoomType(
                id: roomTypeChosen?.id ?? 0,
                name: roomTypeChosen?.name ?? "",
                shortName: roomTypeChosen?.shortName ?? "",
                price: roomTypeChosen?.price ?? 0
            ),
            wifi: wifi
        )
        print(#function, registration)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        updateNumberOfGuests()
    }
    
}

extension AddregistrationTableViewController /*: UITableViewDelegate */ {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case chekInDatePickerIndexPath:
            // if DatePicker is not selected, it disappears(0)
            return isChekInDatePickerShown ? 216 : 0
        case chekOutDatePickerIndexPath:
            // if DatePicker is not selected, it disappears(0)
            return isChekOutDatePickerShown ? 216 : 0
        case priceIndexPath:
            // if roomTypeIndexPath is not selected, it price disappears(0)
            return isPriceIndexPathShown ? 44 : 0
        default:
            return 44
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case chekInDateLabelIndexPath:
            
            // if isChekInDatePickerShown is visible, then hide
            if isChekInDatePickerShown {
                isChekInDatePickerShown = false
                
                // if isChekOutDatePickerShow is visible, then hide isChekOutDatePickerShow and show isChekInDatePickerShown
            } else if isChekOutDatePickerShown {
                isChekOutDatePickerShown = false
                isChekInDatePickerShown = true
                
                // if isChekInDatePickerShown and isChekOutDatePickerSho not visible, then show isChekInDatePickerShown
            } else {
                isChekInDatePickerShown = true
            }
        case chekOutDateLabelIndexPath:
            
            // if isChekOutDatePickerShown is visible, then hide
            if isChekOutDatePickerShown {
                isChekOutDatePickerShown = false
                
                // if isChekInDatePickerShow is visible, then hide isChekInDatePickerShow and show isChekoutDatePickerShown
            } else if isChekInDatePickerShown {
                isChekInDatePickerShown = false
                isChekOutDatePickerShown = true
                
                // if isChekOutDatePickerShown and isChekInDatePickerSho not visible, then show isChekOutDatePickerShown
            } else {
                isChekOutDatePickerShown = true
            }
        case roomTypeIndexPath:
            // if room type was choosen price are appeared
            isPriceIndexPathShown = true
        default:
            break
        }
        
        // this updates the parts that have changed rather than tableView.reloadData()
        tableView.beginUpdates()
        tableView.endUpdates()
        
        print(#function, indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        
        if segue.identifier == "RoomType" {
            // переходим на новый тейблвью и передаем массив с данными рум
            let controller = segue.destination as?  TypeRoomTableViewController
            controller?.rooms = roomsType
            controller?.delegate = self
        }
    }
    
}


extension AddregistrationTableViewController: SelectTypeRoomTableViewControllerDelegate {
    
    func updateRoomType() {
        roomTypeLabel.text = roomType?.name ?? "none"
        guard (roomType?.price) != nil else { return }
        priceRoomLabel.text = String(roomType!.price) + "₽"
        print(#function)
    }
    
    func didSelect(didRoomSelect: RoomType) {
        self.roomType = didRoomSelect
        print(#function, roomType as Any)
        updateRoomType()
    }
    
}
