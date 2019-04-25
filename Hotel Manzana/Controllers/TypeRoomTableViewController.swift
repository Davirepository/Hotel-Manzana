//
//  TypeRoomTableViewController.swift
//  Hotel Manzana
//
//  Created by Давид on 24/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class TypeRoomTableViewController: UITableViewController {
    
    var rooms: [RoomType]!
    var didRoomSelect: RoomType?
    var delegate: SelectTypeRoomTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RoomTypeTableViewCell
        
        let row = indexPath.row
        let room = rooms[row]
        
        //  когда выбираем ячеку она записывается в didRoomSelect, и если значение room совпадает с didRoomSelect то она помечается
        
        cell.accessoryType = room == didRoomSelect ? .checkmark : .none
        
        cell.typeRoomLabel.text = room.name
        cell.priceRoomLabel.text = String(room.price)
        print(#function)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        didRoomSelect = RoomType.all[indexPath.row]
        delegate?.didSelect(didRoomSelect: didRoomSelect!)
        tableView.reloadData()
        print(#function)
        
//          этот способ позволяет помечать несколько ячеек (без метода didDeselectRowAt)
        
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//            if cell.accessoryType == .checkmark {
//                cell.accessoryType = .none
//            } else {
//                cell.accessoryType = .checkmark
//            }
//        }
//        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}

protocol SelectTypeRoomTableViewControllerDelegate {
    func didSelect(didRoomSelect: RoomType)
}
