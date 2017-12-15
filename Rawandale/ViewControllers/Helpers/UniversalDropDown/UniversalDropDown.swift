//
//  UniversalDropDown.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 12/12/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit

protocol DropDownListDelegate {
    
    func dropDownDidSelectItemWithCityDict(cityInfoDict : NSDictionary)
    func onServiceFailed()
}

class UniversalDropDown: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dropDownTblView: UITableView!
    var listArray = NSArray()
    var delegate : DropDownListDelegate?
    
    func reloadDropDownListWith(array:NSMutableArray) {
        self.listArray = array;
        self.dropDownTblView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = dropDownTblView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.textLabel.text = _listMArray[indexPath.row][@"cityName"];
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate?.dropDownDidSelectItemWithCityDict(cityInfoDict:) != nil) {
            delegate?.dropDownDidSelectItemWithCityDict(cityInfoDict: self.listArray .object(at: indexPath.row) as! NSDictionary)
        } else {
            // do something else
        }
        
    }

}
