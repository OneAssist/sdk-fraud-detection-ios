//
//  ViewController.swift
//  OneAssistSDK-Example
//
//  Created by Anand Kumar on 02/09/2020.
//  Copyright © 2020 Anand Kumar. All rights reserved.
//

import UIKit
import OneAssistSDK

var token: String { return UserDefaults.standard.value(forKey: "auth_token") as? String ?? "" }
var activationCode: String { return UserDefaults.standard.value(forKey: "activation_code") as? String ?? "" }

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var infoLablel: UILabel!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var initSDKBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var getIMEIbt: UIButton!
    @IBOutlet weak var sendDetailBtn: UIButton!
    @IBOutlet weak var sendSMSbtn: UIButton!
    @IBOutlet weak var openIMEIBtn: UIButton!
    
    var activationHelper = OAActivation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        infoLablel.text = ""

        initSDKBtn.setTitleColor(.blue, for: .normal)
        startBtn.setTitleColor(.gray, for: .normal)
        getIMEIbt.setTitleColor(.gray, for: .normal)
        sendDetailBtn.setTitleColor(.gray, for: .normal)
        sendSMSbtn.setTitleColor(.gray, for: .normal)
        openIMEIBtn.setTitleColor(.gray, for: .normal)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
    }
    
    @objc func removeKeyboard() {
        pincodeTF.resignFirstResponder()
        addressTF.resignFirstResponder()
        mobileTF.resignFirstResponder()
    }
    
    @IBAction func initSDKTapped(_ sender: Any) {
        statusLabel.text = ""
        infoLablel.text = "Setting Up SDK"
        activationHelper.initializeSDK(token: token, isDebugMode: true, completion: handleSDKCallback)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        statusLabel.text = ""
        infoLablel.text = "Starting FD FLow"
        getCurrentActivationState()
    }
    
    func getCurrentActivationState() {
        activationHelper.startActivation(for: activationCode, completion: handleSDKCallback)
    }
    
    @IBAction func getIMEITapped(_ sender: Any) {
        infoLablel.text = "Getting IMEI"
        activationHelper.fetchDeviceId(pincode: pincodeTF.text, address: addressTF.text, completion: handleSDKCallback)
    }
    
    @IBAction func sendDetailsTapped(_ sender: Any) {
        infoLablel.text = "Sending Details"
        activationHelper.submitBasicDetails(pincode: pincodeTF.text ?? "", address: addressTF.text ?? "", completion: handleSDKCallback)
    }
    
    @IBAction func sendSMSTapped(_ sender: Any) {
        infoLablel.text = "Sending SMS"
        activationHelper.sendUploadLink(mobileTF.text ?? "", completion: handleSDKCallback)
    }
    
    @IBAction func openIMEIScreen(_ sender: Any) {
        infoLablel.text = "Opening IMEI"
        activationHelper.openSecureScreen(onViewController: self, completion: handleSDKCallback)
    }
    
    func handleSDKCallback(status: Bool, stage: OAAction, error: OAError?) {
        if status {
            updateUI(stage: stage)
        } else if let error = error {
            let alert = UIAlertController(title: "Error \(error.errorCode)", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI(stage: OAAction) {
        initSDKBtn.setTitleColor(.gray, for: .normal)
        startBtn.setTitleColor(.gray, for: .normal)
        getIMEIbt.setTitleColor(.gray, for: .normal)
        sendDetailBtn.setTitleColor(.gray, for: .normal)
        sendSMSbtn.setTitleColor(.gray, for: .normal)
        openIMEIBtn.setTitleColor(.gray, for: .normal)
        switch stage {
        case .initializedSDK:
            statusLabel.text = ""
            infoLablel.text = "Setup Success"
            startBtn.setTitleColor(.blue, for: .normal)
        case .fetchDeviceId:
            statusLabel.text = "Documents Upload Pending"
            infoLablel.text = "Need IMEI"
            getIMEIbt.setTitleColor(.blue, for: .normal)
        case .provideUserBasicDetail:
            statusLabel.text = "Documents Upload Pending"
            infoLablel.text = "Need Detail"
            sendDetailBtn.setTitleColor(.blue, for: .normal)
        case .sendUploadLink:
            statusLabel.text = "Documents Upload Pending"
            infoLablel.text = "Enter number and send SMS"
            sendSMSbtn.setTitleColor(.blue, for: .normal)
        case .sendUploadLinkOrOpenSecureScreen:
            statusLabel.text = "Documents Upload Pending"
            infoLablel.text = "Upload documents"
            sendSMSbtn.setTitleColor(.blue, for: .normal)
            openIMEIBtn.setTitleColor(.blue, for: .normal)
        case .secureScreenDismissed:
            getCurrentActivationState()
        case .completed:
            statusLabel.text = "FD Completed"
            infoLablel.text = ""
        }
    }
}
