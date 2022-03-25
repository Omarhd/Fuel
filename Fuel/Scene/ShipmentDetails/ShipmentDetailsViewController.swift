//
//  ShipmentQRCodeViewController.swift
//  Fuel Admin
//
//  Created by Omar Abdulrahman on 3/1/22.
//

import UIKit
import ProgressHUD

class ShipmentQrDetailsViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var shipmentQuantity: UILabel!
    @IBOutlet weak var shipmentBatchNumber: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var ShipmentStatus: UILabel!
    @IBOutlet weak var retailBtn: UIButton!
    @IBOutlet weak var infoBtn: UIButton!
    
    var shipmentDetails: ShipmentResponse!
    var retailedShipmentDetails: RetailsShipmentResponse!
    
    var returent: Bool = false
    var timer: Timer?
    
    // MARK:- View presenter
    fileprivate let shipmentQrDetailsPresnter = ShipmentQrDetailsPresenter(shipmentQrDetailsClient: APiServicesClient())

    fileprivate func setupFullShipment() {
        shipmentQuantity.text = String(describing: shipmentDetails.quantity)
        shipmentBatchNumber.text = String(describing: shipmentDetails.shipmentNumber)
        ShipmentStatus.text = shipmentDetails.status
        createdAt.text = shipmentDetails.createdAt
        
        let shipmentID = shipmentDetails.id
        
        let data = shipmentID.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let image = UIImage(ciImage: (filter?.outputImage)!)
        qrCodeImageView.image = image
    }
    
    fileprivate func setupRetailedShipment() {
        retailBtn.isHidden = true
        
        shipmentQuantity.text = String(describing: retailedShipmentDetails.quantity)
        shipmentBatchNumber.text = String(describing: retailedShipmentDetails.retailShipmentNumber)
        ShipmentStatus.text = retailedShipmentDetails.status
        createdAt.text = retailedShipmentDetails.createdAt
        
        let shipmentID = retailedShipmentDetails.id
        
        let data = shipmentID.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let image = UIImage(ciImage: (filter?.outputImage)!)
        qrCodeImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shipmentQrDetailsPresnter.attachView(self)
        
        if returent {
            setupRetailedShipment()
        } else {
            setupFullShipment()
        }
        
//        if shipmentDetails.status == "sold" {
//            infoBtn.isHidden = false
//        } else {
//            infoBtn.isHidden = true
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

//        schedule(sec: 5)

    }
    
    @IBAction func infoClicked(_ sender: Any) {
    
        if shipmentDetails.currentHolder != UserDefaults.standard.hasID {
            self.shipmentQrDetailsPresnter.getAgent(agentID: shipmentDetails.currentHolder!)
        } else {
            showMessage(title: "Shipment may be new or somthing", body: "", type: .info, icon: .default)
        }
    }
    
    
    
    //MARK:- Schedule func to call timerDidFire
    private func schedule(sec: Double) {
        DispatchQueue.main.async { [self] in
            timer = Timer.scheduledTimer(timeInterval: sec, target: self,
                                         selector: #selector(self.timerDidFire(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerDidFire(timer: Timer) {
        self.shipmentQrDetailsPresnter.getShipment(shipmentID: shipmentDetails.id)
    }
    
    @IBAction func toRetailShipmentAction(_ sender: Any) {
        let retailShipmentDetails = RetailShipmentViewController.instantiate()
        retailShipmentDetails.shipmentDetails = shipmentDetails

        self.navigationController?.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(retailShipmentDetails, animated: true)
        
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        
        if returent {
            let shareItems: Array = [qrCodeImageView.image as Any, retailedShipmentDetails.createdAt] as [Any]
            doShare(shareItems: shareItems)

        } else {
            let shareItems: Array = [qrCodeImageView.image as Any, shipmentDetails.createdAt] as [Any]
            doShare(shareItems: shareItems)
            
        }
    }
    
    func doShare(shareItems: [Any]) {
        let viewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(viewController, animated: true, completion: nil)
    }
    
    func SetUPShipmentUI(with shipmentData: ShipmentResponse) {
      
        shipmentQuantity.text = String(describing: shipmentData.quantity)
        shipmentBatchNumber.text = String(describing: shipmentData.adminID)
        ShipmentStatus.text = shipmentData.status
        createdAt.text = shipmentData.createdAt
        
        let shipmentID = shipmentData.id
        
        let data = shipmentID.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let image = UIImage(ciImage: (filter?.outputImage)!)
        qrCodeImageView.image = image
    }
}

extension ShipmentQrDetailsViewController: ShipmentQrDetailsDelegate {
   
    func didRecivedAgentData(_ agentData: GetUserResponse) {
        let shipmentMoreDetails = MoreShipmentDetailsViewController.instantiate()
        shipmentMoreDetails.userData = agentData
        shipmentMoreDetails.shipmentDetails = shipmentDetails
        
        navigationController?.pushViewController(shipmentMoreDetails, animated: true)
    }
    
    func startLoading() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
    }

    func stopLoading() {
        ProgressHUD.dismiss()
    }

    func didRecevidShimentResponse(_ shipmentRespons: ShipmentResponse) {
        let shipmentStatus = shipmentRespons.status
        if shipmentStatus != "new" && shipmentRespons.currentHolder != nil {
            showMessage(title: "Sorry", body: "This Shipment has been Recived by an agent \n \(shipmentRespons.currentHolder) jst now", type: .warning, icon: .default)
            
            timer?.invalidate()
            
            navigationController?.popToRootViewController(animated: true)
        }
        print(shipmentDetails)

    }

    func didReceivedError(_ message: String) {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show(message, icon: .failed, interaction: false)
        showMessage(title: "Error", body: message, type: .error, icon: .none)
    }
}


extension ShipmentQrDetailsViewController: UIActivityItemSource {
   
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return URL.init(string: "https://itunes.apple.com/app/id1170886809")!
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "ScreenSort for iOS: https://itunes.apple.com/app/id1170886809"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return nil
    }
}

