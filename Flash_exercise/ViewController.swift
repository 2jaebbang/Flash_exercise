//
//  ViewController.swift
//  Flash_exercise
//
//  Created by 이재영 on 2021/01/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var flashView: UIImageView!
    
    var soundPlayer: AVAudioPlayer?
    var isOn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSound()
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    func prepareSound(){
        let path = Bundle.main.path(forResource: "switch.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do{
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.prepareToPlay()
        } catch {
            
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        toggleFlash()
        soundPlayer?.play()
        isOn = !isOn
        
        if isOn == true{
            button.setImage(#imageLiteral(resourceName: "onSwitch"), for: .normal)
            flashView.image = #imageLiteral(resourceName: "onBG")
        } else {
            button.setImage(#imageLiteral(resourceName: "offSwitch"), for: .normal)
            flashView.image = #imageLiteral(resourceName: "offBG")
        }
      
    }
    
}

