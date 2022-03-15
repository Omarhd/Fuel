//
//  AllShipmentsViewController.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit
import ProgressHUD

class AllShipmentsViewController: UIViewController {

    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var allShipments: [ShipmentResponse] = []
    var allRetailedShipments: [RetailsShipmentResponse] = []

    
    // MARK:- View presenter
    fileprivate let allShipmentPresnter = AllShipmentPresenter(allShipmentsClient: APiServicesClient())

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControll.addTarget(self, action: #selector(handdelActions), for: .valueChanged)

        self.allShipmentPresnter.attachView(self)
        self.allShipmentPresnter.getAllShipments(myID: UserDefaults.standard.hasID)
        
    }
    
    @objc fileprivate func handdelActions () {
                
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            allShipments = []
            self.allShipmentPresnter.getAllShipments(myID: UserDefaults.standard.hasID)
            tableView.reloadData()

        case 1:
            allShipments = []
            self.allShipmentPresnter.getAllRetailedShipments()
            tableView.reloadData()
        
        case 2:
            allShipments = []
            self.allShipmentPresnter.getAllRetailedShipments()

        default:
            break
        }
    }
}


extension AllShipmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnData: Int?
        
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            returnData = allShipments.count
        case 1:
            returnData = allRetailedShipments.count
        default:
            break
        }
        
        return returnData!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ShipmentTableViewCell") as! ShipmentTableViewCell
        
        let cell2 = (tableView.dequeueReusableCell(withIdentifier: "RetaildShipmentTableViewCell") as? RetaildShipmentTableViewCell)!


        switch segmentedControll.selectedSegmentIndex {
        case 0:
            cell1.setupUI(with: allShipments[indexPath.row])

        case 1:
            cell2.setupUI(with: allRetailedShipments[indexPath.row])

        default:
            break
        }
        
        if segmentedControll.selectedSegmentIndex == 0 {
            return cell1
        } else {
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentedControll.selectedSegmentIndex == 0 {
            let shipmentDetails = ShipmentQrDetailsViewController.instantiate()
            shipmentDetails.shipmentDetails = allShipments[indexPath.row]
            shipmentDetails.returent = false
            
            navigationController?.pushViewController(shipmentDetails, animated: true)
       
        } else {
            let shipmentDetails = ShipmentQrDetailsViewController.instantiate()
            shipmentDetails.retailedShipmentDetails = allRetailedShipments[indexPath.row]
            shipmentDetails.returent = true
            
            navigationController?.pushViewController(shipmentDetails, animated: true)
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension AllShipmentsViewController: AllShipmentsDelegate {
    func startLoading() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
    }
    
    func didRecevidShimentResponse(_ shipmentRespons: [ShipmentResponse]) {
        self.allShipments = shipmentRespons
        tableView.reloadData()
    }
    
    func didReceivedError(_ message: String) {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show(message, icon: .failed, interaction: false)
        showMessage(title: "Error", body: message, type: .error, icon: .none)
    }
    
    func didRecevidRetaiedShimentResponse(_ retailedShipmentRespons: [RetailsShipmentResponse]) {
        
        self.allRetailedShipments = retailedShipmentRespons
    }
}
