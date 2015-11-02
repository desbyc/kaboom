//
//  ViewController.swift
//  KaBoom
//
//  Created by Dietz, Christian on 26.09.15.
//  Copyright © 2015 Dietz, Christian. All rights reserved.
//

//
//  ViewController.swift
//  KaBumm
//
//  Created by Dietz, Christian on 08.09.15.
//  Copyright (c) 2015 Dietz, Christian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
// some vars-------------------------------------------------------------------------------------
    var runSequence = 0
    var chooseDrumKit = 1
    var lockBDVolume = 0
    var lockHHVolume = 0
    var lockCLVolume = 0
    var lockSDVolume = 0
    var lockRSVolume = 0
    var rndOnBD = 1
    var rndOnHH = 1
    var rndOnCL = 1
    var rndOnSD = 1
    var rndOnRS = 1
    var counterPitchSB:Float = 0
    var counterPatternSB = 0
    var patternContinuousPlayBD = 0
    var patternContinuousPlayHH = 0
    var patternContinuousPlayCL = 0
    var patternContinuousPlaySD = 0
    var patternContinuousPlayRS = 0
    @IBOutlet var lblRimShot: UILabel!
    @IBOutlet var lblClap: UILabel!
    @IBOutlet var btn606: UIButton!
    @IBOutlet var btn808: UIButton!
    @IBOutlet var btn909: UIButton!
    @IBOutlet var btn78: UIButton!
    @IBOutlet var btnPlusMinus: [UIButton]!
//-------------------------------------------------------------------------------------
    
//make da shuffle-------------------------------------------------------------------------------------
    var shuffle:UInt64 = 0
    var shuffleValue = [0,30,45,60]
    var shuffleCounter = 0
    @IBOutlet var lblShuffle: UILabel!
//-------------------------------------------------------------------------------------
    
// make da Engine-------------------------------------------------------------------------------------
    var engine:AVAudioEngine!
    var mixer:AVAudioMixerNode!
//-------------------------------------------------------------------------------------
    
// make da BassDrum-------------------------------------------------------------------------------------
    var BassDrum:AVAudioPlayerNode!
    var distortionNodeBD:AVAudioUnitDistortion!
    var reverbNodeBD:AVAudioUnitReverb!
    var delayNodeBD:AVAudioUnitDelay!
    var audioFileBassDrum:AVAudioFile!
    var stepsBD = [Int](count:16, repeatedValue:0)
    var pattern1BD = [Int](count:16, repeatedValue:0)
    var pattern2BD = [Int](count:16, repeatedValue:0)
    @IBOutlet var btnMuteBD: UIButton!
    @IBOutlet var sldVolumeBD: UISlider!
    @IBOutlet var btnBD: [UIButton]!
    @IBOutlet var btnResetBD: UIButton!
    @IBOutlet var btnRNDPatternBD: UIButton!
    @IBOutlet var btnPattern1BD: UIButton!
    @IBOutlet var btnPattern2BD: UIButton!
    @IBOutlet var btnChooseBD606: UIButton!
    @IBOutlet var btnChooseBD808: UIButton!
    @IBOutlet var btnChooseBD909: UIButton!
    @IBOutlet var btnChooseBD78: UIButton!
    @IBOutlet var btnContinuousPlayBD: UIButton!
//-------------------------------------------------------------------------------------
    
// make da HiHat-------------------------------------------------------------------------------------
    var HiHat:AVAudioPlayerNode!
    var distortionNodeHH:AVAudioUnitDistortion!
    var reverbNodeHH:AVAudioUnitReverb!
    var delayNodeHH:AVAudioUnitDelay!
    var audioFileHiHat:AVAudioFile!
    var stepsHH = [Int](count:16, repeatedValue:0)
    var pattern1HH = [Int](count:16, repeatedValue:0)
    var pattern2HH = [Int](count:16, repeatedValue:0)
    @IBOutlet var btnMuteHH: UIButton!
    @IBOutlet var sldVolumeHH: UISlider!
    @IBOutlet var btnHH: [UIButton]!
    @IBOutlet var btnResetHH: UIButton!
    @IBOutlet var btnRNDPatternHH: UIButton!
    @IBOutlet var btnPattern1HH: UIButton!
    @IBOutlet var btnPattern2HH: UIButton!
    @IBOutlet var btnChooseHH606: UIButton!
    @IBOutlet var btnChooseHH808: UIButton!
    @IBOutlet var btnChooseHH909: UIButton!
    @IBOutlet var btnChooseHH78: UIButton!
    @IBOutlet var btnContinuousPlayHH: UIButton!
//-------------------------------------------------------------------------------------
    
// make da Clap-------------------------------------------------------------------------------------
    var Clap:AVAudioPlayerNode!
    var distortionNodeCL:AVAudioUnitDistortion!
    var reverbNodeCL:AVAudioUnitReverb!
    var delayNodeCL:AVAudioUnitDelay!
    var audioFileClap:AVAudioFile!
    var stepsCL = [Int](count:16, repeatedValue:0)
    var pattern1CL = [Int](count:16, repeatedValue:0)
    var pattern2CL = [Int](count:16, repeatedValue:0)
    @IBOutlet var btnMuteCL: UIButton!
    @IBOutlet var sldVolumeCL: UISlider!
    @IBOutlet var btnCL: [UIButton]!
    @IBOutlet var btnResetCL: UIButton!
    @IBOutlet var btnRNDPatternCL: UIButton!
    @IBOutlet var btnPattern1CL: UIButton!
    @IBOutlet var btnPattern2CL: UIButton!
    @IBOutlet var btnChooseCL606: UIButton!
    @IBOutlet var btnChooseCL808: UIButton!
    @IBOutlet var btnChooseCL909: UIButton!
    @IBOutlet var btnChooseCL78: UIButton!
    @IBOutlet var btnContinuousPlayCL: UIButton!
//-------------------------------------------------------------------------------------
    
// make da SnareDrum-------------------------------------------------------------------------------------
    var SnareDrum:AVAudioPlayerNode!
    var distortionNodeSD:AVAudioUnitDistortion!
    var reverbNodeSD:AVAudioUnitReverb!
    var delayNodeSD:AVAudioUnitDelay!
    var audioFileSnareDrum:AVAudioFile!
    var stepsSD = [Int](count:16, repeatedValue:0)
    //var tmpStepsSD = [Int](count:16, repeatedValue:0)
    var pattern1SD = [Int](count:16, repeatedValue:0)
    var pattern2SD = [Int](count:16, repeatedValue:0)
    @IBOutlet var btnMuteSD: UIButton!
    @IBOutlet var sldVolumeSD: UISlider!
    @IBOutlet var btnSD: [UIButton]!
    @IBOutlet var btnResetSD: UIButton!
    @IBOutlet var btnRNDPatternSD: UIButton!
    @IBOutlet var btnPattern1SD: UIButton!
    @IBOutlet var btnPattern2SD: UIButton!
    @IBOutlet var btnChooseSD606: UIButton!
    @IBOutlet var btnChooseSD808: UIButton!
    @IBOutlet var btnChooseSD909: UIButton!
    @IBOutlet var btnChooseSD78: UIButton!
    @IBOutlet var btnContinuousPlaySD: UIButton!
//-------------------------------------------------------------------------------------
    
// make da RimShot-------------------------------------------------------------------------------------
    var RimShot:AVAudioPlayerNode!
    var distortionNodeRS:AVAudioUnitDistortion!
    var reverbNodeRS:AVAudioUnitReverb!
    var delayNodeRS:AVAudioUnitDelay!
    var audioFileRimShot:AVAudioFile!
    var stepsRS = [Int](count:16, repeatedValue:0)
    var pattern1RS = [Int](count:16, repeatedValue:0)
    var pattern2RS = [Int](count:16, repeatedValue:0)
    @IBOutlet var btnMuteRS: UIButton!
    @IBOutlet var sldVolumeRS: UISlider!
    @IBOutlet var btnRS: [UIButton]!
    @IBOutlet var btnResetRS: UIButton!
    @IBOutlet var btnRNDPatternRS: UIButton!
    @IBOutlet var btnPattern1RS: UIButton!
    @IBOutlet var btnPattern2RS: UIButton!
    @IBOutlet var btnChooseRS606: UIButton!
    @IBOutlet var btnChooseRS808: UIButton!
    @IBOutlet var btnChooseRS909: UIButton!
    @IBOutlet var btnChooseRS78: UIButton!
    @IBOutlet var btnContinuousPlayRS: UIButton!
//-------------------------------------------------------------------------------------
    
//make da Bass-------------------------------------------------------------------------------------
    var SynthBass:AVAudioPlayerNode!
    var pitchNodeSB:AVAudioUnitTimePitch!
    var distortionNodeSB:AVAudioUnitDistortion!
    var reverbNodeSB:AVAudioUnitReverb!
    var delayNodeSB:AVAudioUnitDelay!
    var audioFileSynthBass:AVAudioFile!
    var stepsSB = [Int](count:16, repeatedValue:0)
    var oktaveStep = [Float](count:16, repeatedValue:0)
    var SBOktave:[Float: String] = [
        0:"2C",
        100:"2C#",
        200:"2D",
        300:"2D#",
        400:"2E",
        500:"2F",
        600:"2F#",
        700:"2G",
        800:"2G#",
        900:"2A",
        1000:"2A#",
        1100:"2H",
        1200:"3C",
        1300:"3C#",
        1400:"3D",
        1500:"3D#",
        1600:"3E",
        1700:"3F",
        1800:"3F#",
        1900:"3G",
        2000:"3G#",
        2100:"3A",
        2200:"3A#",
        2300:"3H",
        2400:"4C",
        -100:"1H",
        -200:"1A#",
        -300:"1A",
        -400:"1G#",
        -500:"1G",
        -600:"1F#",
        -700:"1F",
        -800:"1E",
        -900:"1D#",
        -1000:"1D",
        -1100:"1C#",
        -1200:"1C",
        -1300:"0H",
        -1400:"0A#",
        -1500:"0A",
        -1600:"0G#",
        -1700:"0G",
        -1800:"0F#",
        -1900:"0F",
        -2000:"0E",
        -2100:"0D#",
        -2200:"0D",
        -2300:"0C#",
        -2400:"0C"
    ]
    @IBOutlet var lblSBOctave: UILabel!
    @IBOutlet var lblPositionPatternSB: UILabel!
    @IBOutlet var lblCurrentOctave: UILabel!
    @IBOutlet var btnSBAction: [UIButton]!
//-------------------------------------------------------------------------------------
    
    @IBOutlet var sldVolumeAll: [UISlider]!
    @IBOutlet var sldPanningAll: [UISlider]!
    @IBOutlet var sldReverbAll: [UISlider]!
    @IBOutlet var sldDistorsionAll: [UISlider]!
    @IBOutlet var sldDelayAll: [UISlider]!
    
//slider Pics-------------------------------------------------------------------------------------
    let thumbImageVolume = UIImage(named: "Volume.jpg")
    let thumbImagePanning = UIImage(named: "Panning.jpg")
    let thumbImageReverb = UIImage(named: "Reverb.jpg")
    let thumbImageDistorsion = UIImage(named: "Distorsion.jpg")
    let thumbImageDelay = UIImage(named: "Delay.jpg")
//-------------------------------------------------------------------------------------
    
// make da BPM-------------------------------------------------------------------------------------
    var BPM:UInt64 = 125
    var BPMcount:Float = 120
    @IBOutlet var lblBPM: UILabel!
//-------------------------------------------------------------------------------------
    
// make da Play-Button-------------------------------------------------------------------------------------
    @IBOutlet var btnPlay: UIButton!
//-------------------------------------------------------------------------------------
    
// some loads and nice view-------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAudioEngine()
        loadAudioFile()
        
        for i in 0...4{
            sldVolumeAll[i].setThumbImage(thumbImageVolume, forState: .Normal)
            sldVolumeAll[i].setThumbImage(thumbImageVolume, forState: .Highlighted)
        }
        
        for i in 0...4{
            sldPanningAll[i].setThumbImage(thumbImagePanning, forState: .Normal)
            sldPanningAll[i].setThumbImage(thumbImagePanning, forState: .Highlighted)
        }
        
        for i in 0...4{
            sldReverbAll[i].setThumbImage(thumbImageReverb, forState: .Normal)
            sldReverbAll[i].setThumbImage(thumbImageReverb, forState: .Highlighted)
        }
        
        for i in 0...4{
            sldDistorsionAll[i].setThumbImage(thumbImageDistorsion, forState: .Normal)
            sldDistorsionAll[i].setThumbImage(thumbImageDistorsion, forState: .Highlighted)
        }
        
        for i in 0...4{
            sldDelayAll[i].setThumbImage(thumbImageDelay, forState: .Normal)
            sldDelayAll[i].setThumbImage(thumbImageDelay, forState: .Highlighted)
        }
        
        btnPlay.layer.cornerRadius = 5
        
        btnResetBD.layer.cornerRadius = 5
        btnRNDPatternBD.layer.cornerRadius = 5
        btnMuteBD.layer.cornerRadius = 5
        btnPattern1BD.layer.cornerRadius = 5
        btnPattern1BD.enabled = false
        btnPattern1BD.backgroundColor = UIColor.blueColor()
        btnPattern2BD.layer.cornerRadius = 5
        btnChooseBD606.layer.cornerRadius = 5
        btnChooseBD808.layer.cornerRadius = 5
        btnChooseBD909.layer.cornerRadius = 5
        btnChooseBD78.layer.cornerRadius = 5
        btnContinuousPlayBD.layer.cornerRadius = 5
        for i in 0...15 {btnBD[i].layer.cornerRadius = 5}
        
        btnResetHH.layer.cornerRadius = 5
        btnRNDPatternHH.layer.cornerRadius = 5
        btnMuteHH.layer.cornerRadius = 5
        btnPattern1HH.layer.cornerRadius = 5
        btnPattern1HH.enabled = false
        btnPattern1HH.backgroundColor = UIColor.blueColor()
        btnPattern2HH.layer.cornerRadius = 5
        btnChooseHH606.layer.cornerRadius = 5
        btnChooseHH808.layer.cornerRadius = 5
        btnChooseHH909.layer.cornerRadius = 5
        btnChooseHH78.layer.cornerRadius = 5
        btnContinuousPlayHH.layer.cornerRadius = 5
        for i in 0...15 {btnHH[i].layer.cornerRadius = 5}
        
        btnResetCL.layer.cornerRadius = 5
        btnRNDPatternCL.layer.cornerRadius = 5
        btnMuteCL.layer.cornerRadius = 5
        btnPattern1CL.layer.cornerRadius = 5
        btnPattern1CL.enabled = false
        btnPattern1CL.backgroundColor = UIColor.blueColor()
        btnPattern2CL.layer.cornerRadius = 5
        btnChooseCL606.layer.cornerRadius = 5
        btnChooseCL808.layer.cornerRadius = 5
        btnChooseCL909.layer.cornerRadius = 5
        btnChooseCL78.layer.cornerRadius = 5
        btnContinuousPlayCL.layer.cornerRadius = 5
        for i in 0...15 {btnCL[i].layer.cornerRadius = 5}
        
        btnResetSD.layer.cornerRadius = 5
        btnRNDPatternSD.layer.cornerRadius = 5
        btnMuteSD.layer.cornerRadius = 5
        btnPattern1SD.layer.cornerRadius = 5
        btnPattern1SD.enabled = false
        btnPattern1SD.backgroundColor = UIColor.blueColor()
        btnPattern2SD.layer.cornerRadius = 5
        btnChooseSD606.layer.cornerRadius = 5
        btnChooseSD808.layer.cornerRadius = 5
        btnChooseSD909.layer.cornerRadius = 5
        btnChooseSD78.layer.cornerRadius = 5
        btnContinuousPlaySD.layer.cornerRadius = 5
        for i in 0...15 {btnSD[i].layer.cornerRadius = 5}
        
        btnResetRS.layer.cornerRadius = 5
        btnRNDPatternRS.layer.cornerRadius = 5
        btnMuteRS.layer.cornerRadius = 5
        btnPattern1RS.layer.cornerRadius = 5
        btnPattern1RS.enabled = false
        btnPattern1RS.backgroundColor = UIColor.blueColor()
        btnPattern2RS.layer.cornerRadius = 5
        btnChooseRS606.layer.cornerRadius = 5
        btnChooseRS808.layer.cornerRadius = 5
        btnChooseRS909.layer.cornerRadius = 5
        btnChooseRS78.layer.cornerRadius = 5
        btnContinuousPlayRS.layer.cornerRadius = 5
        for i in 0...15 {btnRS[i].layer.cornerRadius = 5}
        
        btn606.layer.cornerRadius = 5
        btn606.backgroundColor = UIColor.blueColor()
        btn808.layer.cornerRadius = 5
        btn909.layer.cornerRadius = 5
        btn78.layer.cornerRadius = 5
        
        for i in 0...2{btnPlusMinus[i].layer.cornerRadius = 5}
        
        for i in 0...5{btnSBAction[i].layer.cornerRadius = 5}
        
    }
//-------------------------------------------------------------------------------------
    
// make da Audio-Engine-------------------------------------------------------------------------------------
    func initAudioEngine(){
        engine = AVAudioEngine()
        
        BassDrum = AVAudioPlayerNode()
        engine.attachNode(BassDrum)
        
        HiHat = AVAudioPlayerNode()
        engine.attachNode(HiHat)
        
        Clap = AVAudioPlayerNode()
        engine.attachNode(Clap)
        
        SnareDrum = AVAudioPlayerNode()
        engine.attachNode(SnareDrum)
        
        RimShot = AVAudioPlayerNode()
        engine.attachNode(RimShot)
        
        SynthBass = AVAudioPlayerNode()
        engine.attachNode(SynthBass)
        
        
        mixer = engine.mainMixerNode
        mixer.outputVolume = 1.0
        mixer.pan = 0.0
        
        distortionBD()
        reverbBD()
        delayBD()
        
        distortionHH()
        reverbHH()
        delayHH()
        
        distortionCL()
        reverbCL()
        delayCL()
        
        distortionSD()
        reverbSD()
        delaySD()
        
        distortionRS()
        reverbRS()
        delayRS()
        
        pitchSB()
        distortionSB()
        reverbSB()
        delaySB()
        volumeSB()
        
        let format = mixer.outputFormatForBus(0)
        
        engine.connect(BassDrum, to: reverbNodeBD, format: format)
        engine.connect(reverbNodeBD, to: distortionNodeBD, format: format)
        engine.connect(distortionNodeBD, to: delayNodeBD, format: format)
        engine.connect(delayNodeBD, to: mixer, format: format)
        
        engine.connect(HiHat, to: reverbNodeHH, format: format)
        engine.connect(reverbNodeHH, to: distortionNodeHH, format: format)
        engine.connect(distortionNodeHH, to: delayNodeHH, format: format)
        engine.connect(delayNodeHH, to: mixer, format: format)
        
        engine.connect(Clap, to: reverbNodeCL, format: format)
        engine.connect(reverbNodeCL, to: distortionNodeCL, format: format)
        engine.connect(distortionNodeCL, to: delayNodeCL, format: format)
        engine.connect(delayNodeCL, to: mixer, format: format)
        
        engine.connect(SnareDrum, to: reverbNodeSD, format: format)
        engine.connect(reverbNodeSD, to: distortionNodeSD, format: format)
        engine.connect(distortionNodeSD, to: delayNodeSD, format: format)
        engine.connect(delayNodeSD, to: mixer, format: format)
        
        engine.connect(RimShot, to: reverbNodeRS, format: format)
        engine.connect(reverbNodeRS, to: distortionNodeRS, format: format)
        engine.connect(distortionNodeRS, to: delayNodeRS, format: format)
        engine.connect(delayNodeRS, to: mixer, format: format)
        
        engine.connect(SynthBass, to: reverbNodeSB, format: format)
        engine.connect(reverbNodeSB, to: distortionNodeSB, format: format)
        engine.connect(distortionNodeSB, to: delayNodeSB, format: format)
        engine.connect(delayNodeSB, to: pitchNodeSB, format: format)
        engine.connect(pitchNodeSB, to: mixer, format: format)
        
        engine.prepare()
        do {
          try
        engine.start()
        } catch _ {
        }
    }
//-------------------------------------------------------------------------------------
    
// load da files-------------------------------------------------------------------------------------
    func loadAudioFile(){
        var error: NSError?
        
        let SBURL = NSBundle.mainBundle().URLForResource("Bass", withExtension: "wav")
        do {
            audioFileSynthBass = try AVAudioFile(forReading: SBURL!)
        } catch let error1 as NSError {
            error = error1
            audioFileSynthBass = nil
        }

        if chooseDrumKit == 1 {
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum606", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            let HHURL = NSBundle.mainBundle().URLForResource("ClosedHiHat606", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            let CLURL = NSBundle.mainBundle().URLForResource("HiTom606", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum606", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            let RSURL = NSBundle.mainBundle().URLForResource("OpenHiHat606", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            lblRimShot.text = "OH"
            lblClap.text = "HT"
        }
        if chooseDrumKit == 2 {
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum808", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat808", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            let CLURL = NSBundle.mainBundle().URLForResource("Clap808", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum808", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot808", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            lblRimShot.text = "RS"
            lblClap.text = "CL"
        }
        if chooseDrumKit == 3 {
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum909", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat909", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            let CLURL = NSBundle.mainBundle().URLForResource("Clap909", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum909", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot909", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            lblRimShot.text = "RS"
            lblClap.text = "CL"
        }
        if chooseDrumKit == 4 {
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum78", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat78", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            let CLURL = NSBundle.mainBundle().URLForResource("Guiro78", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum78", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot78", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            lblRimShot.text = "RS"
            lblClap.text = "GU"
        }
    }
//-------------------------------------------------------------------------------------
    
// effects BassDrum-------------------------------------------------------------------------------------
    func distortionBD() {
        distortionNodeBD = AVAudioUnitDistortion()
        distortionNodeBD.wetDryMix = 0
        distortionNodeBD.preGain = 0
        engine.attachNode(distortionNodeBD)
    }
    func reverbBD() {
        reverbNodeBD = AVAudioUnitReverb()
        reverbNodeBD.loadFactoryPreset(.Cathedral)
        reverbNodeBD.wetDryMix = 0.0
        engine.attachNode(reverbNodeBD)
    }
    func delayBD() {
        delayNodeBD = AVAudioUnitDelay()
        delayNodeBD.delayTime = 0.3
        delayNodeBD.feedback = 30
        delayNodeBD.wetDryMix = 0
        engine.attachNode(delayNodeBD)
    }
//-------------------------------------------------------------------------------------
    
// effects HiHat-------------------------------------------------------------------------------------
    func distortionHH() {
        distortionNodeHH = AVAudioUnitDistortion()
        distortionNodeHH.wetDryMix = 0
        distortionNodeHH.preGain = 0
        engine.attachNode(distortionNodeHH)
    }
    func reverbHH() {
        reverbNodeHH = AVAudioUnitReverb()
        reverbNodeHH.loadFactoryPreset(.Cathedral)
        reverbNodeHH.wetDryMix = 0.0
        engine.attachNode(reverbNodeHH)
    }
    func delayHH() {
        delayNodeHH = AVAudioUnitDelay()
        delayNodeHH.delayTime = 0.3
        delayNodeHH.feedback = 30
        delayNodeHH.wetDryMix = 0
        engine.attachNode(delayNodeHH)
    }
//-------------------------------------------------------------------------------------
    
// effects Clap-------------------------------------------------------------------------------------
    func distortionCL() {
        distortionNodeCL = AVAudioUnitDistortion()
        distortionNodeCL.wetDryMix = 0
        distortionNodeCL.preGain = 0
        engine.attachNode(distortionNodeCL)
    }
    func reverbCL() {
        reverbNodeCL = AVAudioUnitReverb()
        reverbNodeCL.loadFactoryPreset(.Cathedral)
        reverbNodeCL.wetDryMix = 0.0
        engine.attachNode(reverbNodeCL)
    }
    func delayCL() {
        delayNodeCL = AVAudioUnitDelay()
        delayNodeCL.delayTime = 0.3
        delayNodeCL.feedback = 30
        delayNodeCL.wetDryMix = 0
        engine.attachNode(delayNodeCL)
    }
//-------------------------------------------------------------------------------------
    
// effects SnareDrum-------------------------------------------------------------------------------------
    func distortionSD() {
        distortionNodeSD = AVAudioUnitDistortion()
        distortionNodeSD.wetDryMix = 0
        distortionNodeSD.preGain = 0
        engine.attachNode(distortionNodeSD)
    }
    func reverbSD() {
        reverbNodeSD = AVAudioUnitReverb()
        reverbNodeSD.loadFactoryPreset(.Cathedral)
        reverbNodeSD.wetDryMix = 0.0
        engine.attachNode(reverbNodeSD)
    }
    func delaySD() {
        delayNodeSD = AVAudioUnitDelay()
        delayNodeSD.delayTime = 0.3
        delayNodeSD.feedback = 30
        delayNodeSD.wetDryMix = 0
        engine.attachNode(delayNodeSD)
    }
//-------------------------------------------------------------------------------------
    
// effects RimShot-------------------------------------------------------------------------------------
    func distortionRS() {
        distortionNodeRS = AVAudioUnitDistortion()
        distortionNodeRS.wetDryMix = 0
        distortionNodeRS.preGain = 0
        engine.attachNode(distortionNodeRS)
    }
    func reverbRS() {
        reverbNodeRS = AVAudioUnitReverb()
        reverbNodeRS.loadFactoryPreset(.Cathedral)
        reverbNodeRS.wetDryMix = 0.0
        engine.attachNode(reverbNodeRS)
    }
    func delayRS() {
        delayNodeRS = AVAudioUnitDelay()
        delayNodeRS.delayTime = 0.3
        delayNodeRS.feedback = 30
        delayNodeRS.lowPassCutoff = 5000
        delayNodeRS.wetDryMix = 0
        engine.attachNode(delayNodeRS)
    }
//-------------------------------------------------------------------------------------
    
//effects Bass-------------------------------------------------------------------------------------
    func pitchSB(){
        pitchNodeSB = AVAudioUnitTimePitch()
        pitchNodeSB.pitch = 0
        engine.attachNode(pitchNodeSB)
    }
    func distortionSB() {
        distortionNodeSB = AVAudioUnitDistortion()
        distortionNodeSB.wetDryMix = 2
        distortionNodeSB.preGain = 0
        engine.attachNode(distortionNodeSB)
    }
    func reverbSB() {
        reverbNodeSB = AVAudioUnitReverb()
        reverbNodeSB.loadFactoryPreset(.Cathedral)
        reverbNodeSB.wetDryMix = 8.0
        engine.attachNode(reverbNodeSB)
    }
    func delaySB() {
        delayNodeSB = AVAudioUnitDelay()
        delayNodeSB.delayTime = 0.2
        delayNodeSB.feedback = 50
        delayNodeSB.lowPassCutoff = 5000
        delayNodeSB.wetDryMix = 2
        engine.attachNode(delayNodeSB)
        SynthBass.volume = 2
    }
    func volumeSB(){SynthBass.volume = 1}
//-------------------------------------------------------------------------------------
    
// play da sequence-------------------------------------------------------------------------------------
    @IBAction func btnPlay(sender: UIButton) {
        if runSequence == 1 {
            playSequence(runSequence);runSequence = 0
            sender.backgroundColor = UIColor.redColor()
        } else {
            playSequence(runSequence);runSequence = 1
            sender.backgroundColor = UIColor.blueColor()
        }
    }
//-------------------------------------------------------------------------------------
    
// da sequence-------------------------------------------------------------------------------------
    func playSequence (seqPlay:Int){
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
            var tmpShuffle:UInt64 = 0
            var counter = 0
            var ms:UInt64 = 0
            var startTime: UInt64 = 0
            var currentTime: UInt64 = 0
            var info = mach_timebase_info(numer: 0, denom: 0)
            mach_timebase_info(&info)
            let tick = UInt64(info.numer / info.denom)
            startTime = mach_absolute_time()
            while self.runSequence == 1 {
                if (counter + 1) % 2 == 0 {tmpShuffle = self.shuffle} else {tmpShuffle = 0}
                if ms == tmpShuffle && self.stepsBD[counter] == 1 && self.lockBDVolume == 0 {
                    self.BassDrum.stop()
                    self.BassDrum.scheduleFile(self.audioFileBassDrum, atTime: nil, completionHandler: nil)
                    self.BassDrum.play()
                }
                if ms == tmpShuffle && self.stepsHH[counter] == 1 && self.lockHHVolume == 0 {
                    self.HiHat.stop()
                    self.HiHat.scheduleFile(self.audioFileHiHat, atTime: nil, completionHandler: nil)
                    self.HiHat.play()
                }
                if ms == tmpShuffle && self.stepsCL[counter] == 1 && self.lockCLVolume == 0 {
                    self.Clap.stop()
                    self.Clap.scheduleFile(self.audioFileClap, atTime: nil, completionHandler: nil)
                    self.Clap.play()
                }
                if ms == tmpShuffle && self.stepsSD[counter] == 1 && self.lockSDVolume == 0 {
                    self.SnareDrum.stop()
                    self.SnareDrum.scheduleFile(self.audioFileSnareDrum, atTime: nil, completionHandler: nil)
                    self.SnareDrum.play()
                }
                if ms == tmpShuffle && self.stepsRS[counter] == 1 && self.lockRSVolume == 0 {
                    self.RimShot.stop()
                    self.RimShot.scheduleFile(self.audioFileRimShot, atTime: nil, completionHandler: nil)
                    self.RimShot.play()
                }
                if ms == 0 && self.stepsSB[counter] == 1 {
                    self.pitchNodeSB.pitch = self.oktaveStep[counter]
                    self.SynthBass.stop()
                    self.SynthBass.scheduleFile(self.audioFileSynthBass, atTime: nil, completionHandler: nil)
                    self.SynthBass.play()
                }
                currentTime = mach_absolute_time()
                ms = (currentTime - startTime) / (1000000 / tick)
                if ms >= self.BPM {
                    ms = 0
                    startTime = mach_absolute_time()
                    counter++
                }
                if self.patternContinuousPlayBD == 1 && self.rndOnBD == 1 && counter == 16 {
                    if self.pattern1BD == self.stepsBD {self.stepsBD = self.pattern2BD} else {self.stepsBD = self.pattern1BD}
                }
                if self.patternContinuousPlayHH == 1 && self.rndOnHH == 1 && counter == 16 {
                    if self.pattern1HH == self.stepsHH {self.stepsHH = self.pattern2HH} else {self.stepsHH = self.pattern1HH}
                }
                if self.patternContinuousPlayCL == 1 && self.rndOnCL == 1 && counter == 16 {
                    if self.pattern1CL == self.stepsCL {self.stepsCL = self.pattern2CL} else {self.stepsCL = self.pattern1CL}
                }
                if self.patternContinuousPlaySD == 1 && self.rndOnSD == 1 && counter == 16 {
                    if self.pattern1SD == self.stepsSD {self.stepsSD = self.pattern2SD} else {self.stepsSD = self.pattern1SD}
                }
                if self.patternContinuousPlayRS == 1 && self.rndOnRS == 1 && counter == 16 {
                    if self.pattern1RS == self.stepsRS {self.stepsRS = self.pattern2RS} else {self.stepsRS = self.pattern1RS}
                }
                if counter == 16 {counter = 0}
            }
        }
    }
//-------------------------------------------------------------------------------------
    
// all BassDrum-Action-------------------------------------------------------------------------------------
    @IBAction func btnStepsBD(sender: UIButton) {
        if patternContinuousPlayBD == 0 {
            if stepsBD[Int(sender.currentTitle!)!] == 0 {
                stepsBD[Int(sender.currentTitle!)!] = 1
                sender.backgroundColor = UIColor.orangeColor()
                }else{
                stepsBD[Int(sender.currentTitle!)!] = 0
                sender.backgroundColor = UIColor.redColor()
            }
            if btnPattern1BD.backgroundColor == UIColor.blueColor() {
                pattern1BD = stepsBD
            }
            if btnPattern2BD.backgroundColor == UIColor.blueColor() {
                pattern2BD = stepsBD
            }
        }
        if patternContinuousPlayBD == 1 {
            if btnPattern1BD.backgroundColor == UIColor.blueColor() {
                if pattern1BD[Int(sender.currentTitle!)!] == 0 {
                    pattern1BD[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern1BD[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            if btnPattern2BD.backgroundColor == UIColor.blueColor() {
                if pattern2BD[Int(sender.currentTitle!)!] == 0 {
                    pattern2BD[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern2BD[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }
    }
    @IBAction func RNDStepsBD(sender: AnyObject) {
        for buttons in btnBD {buttons.backgroundColor = UIColor.redColor()}
        if rndOnBD == 1 {
            btnRNDPatternBD.backgroundColor = UIColor.blueColor()
            for i in 0...15 {
                let RND = Int(arc4random_uniform(2))
                stepsBD[i] = RND
                if RND == 1 {btnBD[i].backgroundColor = UIColor.orangeColor()}
            }
            rndOnBD = 0
        } else {
            btnRNDPatternBD.backgroundColor = UIColor.redColor()
            if btnPattern1BD.backgroundColor == UIColor.blueColor() {
                stepsBD = pattern1BD
            }
            if btnPattern2BD.backgroundColor == UIColor.blueColor() {
                stepsBD = pattern2BD
            }
            for i in 0...15{if stepsBD[i] == 1{btnBD[i].backgroundColor = UIColor.orangeColor()}}
            rndOnBD = 1
        }
    }
    @IBAction func sldDistortionBD(sender: UISlider) {distortionNodeBD.wetDryMix = sender.value}
    @IBAction func sldDelayBD(sender: UISlider) {delayNodeBD.wetDryMix = sender.value}
    @IBAction func sldReverbBD(sender: UISlider) {reverbNodeBD.wetDryMix = sender.value}
    @IBAction func sldVolumeBD(sender: UISlider) {BassDrum.volume = sender.value}
    @IBAction func btnMuteBD(sender: UIButton) {if lockBDVolume == 0 {lockBDVolume = 1; btnMuteBD.backgroundColor = UIColor.blueColor()
    }else{lockBDVolume = 0; btnMuteBD.backgroundColor = UIColor.redColor()}}
    @IBAction func sldPanBD(sender: AnyObject) {BassDrum.pan = sender.value}
    @IBAction func btnBDReset(sender: AnyObject) {
        btnRNDPatternBD.backgroundColor = UIColor.redColor()
        rndOnBD = 1
        for i in 0...15 {stepsBD [i] = 0}
        for buttons in self.btnBD {buttons.backgroundColor = UIColor.redColor()}
        if btnPattern1BD.backgroundColor == UIColor.blueColor() {
            pattern1BD = stepsBD
        }
        if btnPattern2BD.backgroundColor == UIColor.blueColor() {
            pattern2BD = stepsBD
        }
    }
    @IBAction func btnPattern1BD(sender: AnyObject) {
        if patternContinuousPlayBD == 0 {stepsBD = pattern1BD}
        btnPattern1BD.backgroundColor = UIColor.blueColor()
        btnPattern2BD.backgroundColor = UIColor.redColor()
        btnRNDPatternBD.backgroundColor = UIColor.redColor()
        rndOnBD = 1
        for i in 0...15 {
            if pattern1BD[i] == 1 {
                self.btnBD[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnBD[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern2BD.enabled = true
        btnPattern1BD.enabled = false
    }
    @IBAction func btnPattern2BD(sender: AnyObject) {
        if patternContinuousPlayBD == 0 {stepsBD = pattern2BD}
        btnPattern2BD.backgroundColor = UIColor.blueColor()
        btnPattern1BD.backgroundColor = UIColor.redColor()
        btnRNDPatternBD.backgroundColor = UIColor.redColor()
        rndOnBD = 1
        for i in 0...15 {
            if pattern2BD[i] == 1 {
                self.btnBD[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnBD[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern1BD.enabled = true
        btnPattern2BD.enabled = false
    }
    @IBAction func btnChooseBD606(sender: UIButton) {
        if btnChooseBD606.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum606", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
                } catch let error1 as NSError {
                    error = error1
                    audioFileBassDrum = nil
            }
            btnChooseBD606.backgroundColor = UIColor.blueColor()
            btnChooseBD808.backgroundColor = UIColor.redColor()
            btnChooseBD909.backgroundColor = UIColor.redColor()
            btnChooseBD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseBD808(sender: UIButton) {
        if btnChooseBD808.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum808", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            btnChooseBD606.backgroundColor = UIColor.redColor()
            btnChooseBD808.backgroundColor = UIColor.blueColor()
            btnChooseBD909.backgroundColor = UIColor.redColor()
            btnChooseBD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseBD909(sender: UIButton) {
        if btnChooseBD909.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum909", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            btnChooseBD606.backgroundColor = UIColor.redColor()
            btnChooseBD808.backgroundColor = UIColor.redColor()
            btnChooseBD909.backgroundColor = UIColor.blueColor()
            btnChooseBD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseBD78(sender: UIButton) {
        if btnChooseBD78.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let BDURL = NSBundle.mainBundle().URLForResource("BassDrum78", withExtension: "wav")
            do {
                audioFileBassDrum = try AVAudioFile(forReading: BDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileBassDrum = nil
            }
            btnChooseBD606.backgroundColor = UIColor.redColor()
            btnChooseBD808.backgroundColor = UIColor.redColor()
            btnChooseBD909.backgroundColor = UIColor.redColor()
            btnChooseBD78.backgroundColor = UIColor.blueColor()
        }
    }
    @IBAction func btnPatternContinuousBD(sender: UIButton) {
        if patternContinuousPlayBD == 0 {patternContinuousPlayBD = 1;sender.backgroundColor = UIColor.blueColor()} else {
            patternContinuousPlayBD = 0
            sender.backgroundColor = UIColor.redColor()
            if btnPattern1BD.backgroundColor == UIColor.blueColor() {
                stepsBD = pattern1BD
            }
            if btnPattern2BD.backgroundColor == UIColor.blueColor() {
                stepsBD = pattern2BD
            }
        }
    }
    
//-------------------------------------------------------------------------------------
    
// all HiHat-Action-------------------------------------------------------------------------------------
    @IBAction func btnStepsHH(sender: UIButton) {
        if patternContinuousPlayHH == 0 {
            if stepsHH[Int(sender.currentTitle!)!] == 0 {
                stepsHH[Int(sender.currentTitle!)!] = 1
                sender.backgroundColor = UIColor.orangeColor()
            }else{
                stepsHH[Int(sender.currentTitle!)!] = 0
                sender.backgroundColor = UIColor.redColor()
            }
            if btnPattern1HH.backgroundColor == UIColor.blueColor() {
                pattern1HH = stepsHH
            }
            if btnPattern2HH.backgroundColor == UIColor.blueColor() {
                pattern2HH = stepsHH
            }
        }
        if patternContinuousPlayHH == 1 {
            if btnPattern1HH.backgroundColor == UIColor.blueColor() {
                if pattern1HH[Int(sender.currentTitle!)!] == 0 {
                    pattern1HH[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern1HH[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            if btnPattern2HH.backgroundColor == UIColor.blueColor() {
                if pattern2HH[Int(sender.currentTitle!)!] == 0 {
                    pattern2HH[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern2HH[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }

    }
    @IBAction func RNDStepsHH(sender: AnyObject) {
        for buttons in btnHH {buttons.backgroundColor = UIColor.redColor()}
        if rndOnHH == 1 {
            btnRNDPatternHH.backgroundColor = UIColor.blueColor()
            for i in 0...15 {
                let RND = Int(arc4random_uniform(2))
                stepsHH[i] = RND
                if RND == 1 {btnHH[i].backgroundColor = UIColor.orangeColor()}
            }
            rndOnHH = 0
        } else {
            btnRNDPatternHH.backgroundColor = UIColor.redColor()
            if btnPattern1HH.backgroundColor == UIColor.blueColor() {
                stepsHH = pattern1HH
            }
            if btnPattern2HH.backgroundColor == UIColor.blueColor() {
                stepsHH = pattern2HH
            }
            for i in 0...15{if stepsHH[i] == 1{btnHH[i].backgroundColor = UIColor.orangeColor()}}
            rndOnHH = 1
        }
    }
    @IBAction func sldDistortionHH(sender: UISlider) {distortionNodeHH.wetDryMix = sender.value}
    @IBAction func sldDelayHH(sender: UISlider) {delayNodeHH.wetDryMix = sender.value}
    @IBAction func sldReverbHH(sender: UISlider) {reverbNodeHH.wetDryMix = sender.value}
    @IBAction func sldVolumeHH(sender: UISlider) {HiHat.volume = sender.value}
    @IBAction func btnMuteHH(sender: UIButton) {if lockHHVolume == 0 {lockHHVolume = 1; btnMuteHH.backgroundColor = UIColor.blueColor()
    }else{lockHHVolume = 0; btnMuteHH.backgroundColor = UIColor.redColor()}}
    @IBAction func sldPanHH(sender: AnyObject) {HiHat.pan = sender.value}
    @IBAction func btnHHReset(sender: AnyObject){
        btnRNDPatternHH.backgroundColor = UIColor.redColor()
        rndOnHH = 1
        for i in 0...15 {stepsHH [i] = 0}
        for buttons in self.btnHH {buttons.backgroundColor = UIColor.redColor()}
        if btnPattern1HH.backgroundColor == UIColor.blueColor() {
            pattern1HH = stepsHH
        }
        if btnPattern2HH.backgroundColor == UIColor.blueColor() {
            pattern2HH = stepsHH
        }
    }
    @IBAction func btnPattern1HH(sender: AnyObject) {
        if patternContinuousPlayHH == 0 {stepsHH = pattern1HH}
        btnPattern1HH.backgroundColor = UIColor.blueColor()
        btnPattern2HH.backgroundColor = UIColor.redColor()
        btnRNDPatternHH.backgroundColor = UIColor.redColor()
        rndOnHH = 1
        for i in 0...15 {
            if pattern1HH[i] == 1 {
                self.btnHH[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnHH[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern2HH.enabled = true
        btnPattern1HH.enabled = false
    }
    @IBAction func btnPattern2HH(sender: AnyObject) {
        if patternContinuousPlayHH == 0 {stepsHH = pattern2HH}
        btnPattern2HH.backgroundColor = UIColor.blueColor()
        btnPattern1HH.backgroundColor = UIColor.redColor()
        btnRNDPatternHH.backgroundColor = UIColor.redColor()
        rndOnHH = 1
        for i in 0...15 {
            if pattern2HH[i] == 1 {
                self.btnHH[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnHH[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern1HH.enabled = true
        btnPattern2HH.enabled = false
    }
    @IBAction func btnChooseHH606(sender: UIButton) {
        if btnChooseHH606.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let HHURL = NSBundle.mainBundle().URLForResource("ClosedHiHat606", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            btnChooseHH606.backgroundColor = UIColor.blueColor()
            btnChooseHH808.backgroundColor = UIColor.redColor()
            btnChooseHH909.backgroundColor = UIColor.redColor()
            btnChooseHH78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseHH808(sender: UIButton) {
        if btnChooseHH808.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat808", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            btnChooseHH606.backgroundColor = UIColor.redColor()
            btnChooseHH808.backgroundColor = UIColor.blueColor()
            btnChooseHH909.backgroundColor = UIColor.redColor()
            btnChooseHH78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseHH909(sender: UIButton) {
        if btnChooseHH909.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat909", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            btnChooseHH606.backgroundColor = UIColor.redColor()
            btnChooseHH808.backgroundColor = UIColor.redColor()
            btnChooseHH909.backgroundColor = UIColor.blueColor()
            btnChooseHH78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseHH78(sender: UIButton) {
        if btnChooseHH78.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let HHURL = NSBundle.mainBundle().URLForResource("HiHat78", withExtension: "wav")
            do {
                audioFileHiHat = try AVAudioFile(forReading: HHURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileHiHat = nil
            }
            btnChooseHH606.backgroundColor = UIColor.redColor()
            btnChooseHH808.backgroundColor = UIColor.redColor()
            btnChooseHH909.backgroundColor = UIColor.redColor()
            btnChooseHH78.backgroundColor = UIColor.blueColor()
        }
    }
    @IBAction func btnPatternContinuousHH(sender: UIButton) {
        if patternContinuousPlayHH == 0 {patternContinuousPlayHH = 1;sender.backgroundColor = UIColor.blueColor()} else {
            patternContinuousPlayHH = 0
            sender.backgroundColor = UIColor.redColor()
            if btnPattern1HH.backgroundColor == UIColor.blueColor() {
                stepsHH = pattern1HH
            }
            if btnPattern2HH.backgroundColor == UIColor.blueColor() {
                stepsHH = pattern2HH
            }
        }
    }
//-------------------------------------------------------------------------------------
    
// all Clap-Action-------------------------------------------------------------------------------------
    @IBAction func btnStepsCL(sender: UIButton) {
        if patternContinuousPlayCL == 0 {
            if stepsCL[Int(sender.currentTitle!)!] == 0 {
                stepsCL[Int(sender.currentTitle!)!] = 1
                sender.backgroundColor = UIColor.orangeColor()
            }else{
                stepsCL[Int(sender.currentTitle!)!] = 0
                sender.backgroundColor = UIColor.redColor()
            }
            if btnPattern1CL.backgroundColor == UIColor.blueColor() {
                pattern1CL = stepsCL
            }
            if btnPattern2CL.backgroundColor == UIColor.blueColor() {
                pattern2CL = stepsCL
            }
        }
        if patternContinuousPlayCL == 1 {
            if btnPattern1CL.backgroundColor == UIColor.blueColor() {
                if pattern1CL[Int(sender.currentTitle!)!] == 0 {
                    pattern1CL[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern1CL[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            if btnPattern2CL.backgroundColor == UIColor.blueColor() {
                if pattern2CL[Int(sender.currentTitle!)!] == 0 {
                    pattern2CL[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern2CL[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }
    }
    @IBAction func RNDStepsCL(sender: AnyObject) {
        for buttons in btnCL {buttons.backgroundColor = UIColor.redColor()}
        if rndOnCL == 1 {
            btnRNDPatternCL.backgroundColor = UIColor.blueColor()
            for i in 0...15 {
                let RND = Int(arc4random_uniform(2))
                stepsCL[i] = RND
                if RND == 1 {btnCL[i].backgroundColor = UIColor.orangeColor()}
            }
            rndOnCL = 0
        } else {
            btnRNDPatternCL.backgroundColor = UIColor.redColor()
            if btnPattern1CL.backgroundColor == UIColor.blueColor() {
                stepsCL = pattern1CL
            }
            if btnPattern2CL.backgroundColor == UIColor.blueColor() {
                stepsCL = pattern2CL
            }
            for i in 0...15{if stepsCL[i] == 1{btnCL[i].backgroundColor = UIColor.orangeColor()}}
            rndOnCL = 1
        }
    }
    @IBAction func sldDistortionCL(sender: UISlider) {distortionNodeCL.wetDryMix = sender.value}
    @IBAction func sldDelayCL(sender: UISlider) {delayNodeCL.wetDryMix = sender.value}
    @IBAction func sldReverbCL(sender: UISlider) {reverbNodeCL.wetDryMix = sender.value}
    @IBAction func sldVolumeCL(sender: UISlider) {Clap.volume = sender.value}
    @IBAction func btnMuteCL(sender: UIButton) {if lockCLVolume == 0 {lockCLVolume = 1; btnMuteCL.backgroundColor = UIColor.blueColor()
    }else{lockCLVolume = 0; btnMuteCL.backgroundColor = UIColor.redColor()}}
    @IBAction func sldPanCL(sender: AnyObject) {Clap.pan = sender.value}
    @IBAction func btnCLReset(sender: AnyObject) {
        btnRNDPatternCL.backgroundColor = UIColor.redColor()
        rndOnCL = 1
        for i in 0...15 {stepsCL [i] = 0}
        for buttons in self.btnCL {buttons.backgroundColor = UIColor.redColor()}
        if btnPattern1CL.backgroundColor == UIColor.blueColor() {
            pattern1CL = stepsCL
        }
        if btnPattern2CL.backgroundColor == UIColor.blueColor() {
            pattern2CL = stepsCL
        }
    }
    @IBAction func btnPattern1CL(sender: AnyObject) {
        if patternContinuousPlayCL == 0 {stepsCL = pattern1CL}
        btnPattern1CL.backgroundColor = UIColor.blueColor()
        btnPattern2CL.backgroundColor = UIColor.redColor()
        btnRNDPatternCL.backgroundColor = UIColor.redColor()
        rndOnCL = 1
        for i in 0...15 {
            if pattern1CL[i] == 1 {
                self.btnCL[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnCL[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern2CL.enabled = true
        btnPattern1CL.enabled = false
    }
    @IBAction func btnPattern2CL(sender: AnyObject) {
        if patternContinuousPlayCL == 0 {stepsCL = pattern2CL}
        btnPattern2CL.backgroundColor = UIColor.blueColor()
        btnPattern1CL.backgroundColor = UIColor.redColor()
        btnRNDPatternCL.backgroundColor = UIColor.redColor()
        rndOnCL = 1
        for i in 0...15 {
            if pattern2CL[i] == 1 {
                self.btnCL[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnCL[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern1CL.enabled = true
        btnPattern2CL.enabled = false
    }
    @IBAction func btnChooseCL606(sender: UIButton) {
        if btnChooseCL606.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let CLURL = NSBundle.mainBundle().URLForResource("HiTom606", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            btnChooseCL606.backgroundColor = UIColor.blueColor()
            btnChooseCL808.backgroundColor = UIColor.redColor()
            btnChooseCL909.backgroundColor = UIColor.redColor()
            btnChooseCL78.backgroundColor = UIColor.redColor()
            lblClap.text = "HT"
        }
    }
    @IBAction func btnChooseCL808(sender: UIButton) {
        if btnChooseCL808.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let CLURL = NSBundle.mainBundle().URLForResource("Clap808", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            btnChooseCL606.backgroundColor = UIColor.redColor()
            btnChooseCL808.backgroundColor = UIColor.blueColor()
            btnChooseCL909.backgroundColor = UIColor.redColor()
            btnChooseCL78.backgroundColor = UIColor.redColor()
            lblClap.text = "CL"
        }
    }
    @IBAction func btnChooseCL909(sender: UIButton) {
        if btnChooseCL909.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let CLURL = NSBundle.mainBundle().URLForResource("Clap909", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            btnChooseCL606.backgroundColor = UIColor.redColor()
            btnChooseCL808.backgroundColor = UIColor.redColor()
            btnChooseCL909.backgroundColor = UIColor.blueColor()
            btnChooseCL78.backgroundColor = UIColor.redColor()
            lblClap.text = "CL"
        }
    }
    @IBAction func btnChooseCL78(sender: UIButton) {
        if btnChooseCL78.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let CLURL = NSBundle.mainBundle().URLForResource("Guiro78", withExtension: "wav")
            do {
                audioFileClap = try AVAudioFile(forReading: CLURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileClap = nil
            }
            btnChooseCL606.backgroundColor = UIColor.redColor()
            btnChooseCL808.backgroundColor = UIColor.redColor()
            btnChooseCL909.backgroundColor = UIColor.redColor()
            btnChooseCL78.backgroundColor = UIColor.blueColor()
            lblClap.text = "GU"
        }
    }
    @IBAction func btnPatternContinuousCL(sender: UIButton) {
        if patternContinuousPlayCL == 0 {patternContinuousPlayCL = 1;sender.backgroundColor = UIColor.blueColor()} else {
            patternContinuousPlayCL = 0
            sender.backgroundColor = UIColor.redColor()
            if btnPattern1CL.backgroundColor == UIColor.blueColor() {
                stepsCL = pattern1CL
            }
            if btnPattern2CL.backgroundColor == UIColor.blueColor() {
                stepsCL = pattern2CL
            }
        }
    }
//-------------------------------------------------------------------------------------
    
// all SnareDrum-Action-------------------------------------------------------------------------------------
    @IBAction func btnStepsSD(sender: UIButton) {
        if patternContinuousPlaySD == 0 {
            if stepsSD[Int(sender.currentTitle!)!] == 0 {
                stepsSD[Int(sender.currentTitle!)!] = 1
                sender.backgroundColor = UIColor.orangeColor()
            }else{
                stepsSD[Int(sender.currentTitle!)!] = 0
                sender.backgroundColor = UIColor.redColor()
            }
            if btnPattern1SD.backgroundColor == UIColor.blueColor() {
                pattern1SD = stepsSD
            }
            if btnPattern2SD.backgroundColor == UIColor.blueColor() {
                pattern2SD = stepsSD
            }
        }
        if patternContinuousPlaySD == 1 {
            if btnPattern1SD.backgroundColor == UIColor.blueColor() {
                if pattern1SD[Int(sender.currentTitle!)!] == 0 {
                    pattern1SD[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern1SD[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            if btnPattern2SD.backgroundColor == UIColor.blueColor() {
                if pattern2SD[Int(sender.currentTitle!)!] == 0 {
                    pattern2SD[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern2SD[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }
    }
    @IBAction func RNDStepsSD(sender: AnyObject) {
        for buttons in btnSD {buttons.backgroundColor = UIColor.redColor()}
        if rndOnSD == 1 {
            btnRNDPatternSD.backgroundColor = UIColor.blueColor()
            for i in 0...15 {
                let RND = Int(arc4random_uniform(2))
                stepsSD[i] = RND
                if RND == 1 {btnSD[i].backgroundColor = UIColor.orangeColor()}
            }
            rndOnSD = 0
        } else {
            btnRNDPatternSD.backgroundColor = UIColor.redColor()
            if btnPattern1SD.backgroundColor == UIColor.blueColor() {
                stepsSD = pattern1SD
            }
            if btnPattern2SD.backgroundColor == UIColor.blueColor() {
                stepsSD = pattern2SD
            }
            for i in 0...15{if stepsSD[i] == 1{btnSD[i].backgroundColor = UIColor.orangeColor()}}
            rndOnSD = 1
        }
    }
    @IBAction func sldDistortionSD(sender: UISlider) {distortionNodeSD.wetDryMix = sender.value}
    @IBAction func sldDelaySD(sender: UISlider) {delayNodeSD.wetDryMix = sender.value}
    @IBAction func sldReverbSD(sender: UISlider) {reverbNodeSD.wetDryMix = sender.value}
    @IBAction func sldVolumeSD(sender: UISlider) {SnareDrum.volume = sender.value}
    @IBAction func btnMuteSD(sender: UIButton) {if lockSDVolume == 0 {lockSDVolume = 1; btnMuteSD.backgroundColor = UIColor.blueColor()
    }else{lockSDVolume = 0; btnMuteSD.backgroundColor = UIColor.redColor()}}
    @IBAction func sldPanSD(sender: AnyObject) {SnareDrum.pan = sender.value}
    @IBAction func btnSDReset(sender: AnyObject) {
        btnRNDPatternSD.backgroundColor = UIColor.redColor()
        rndOnSD = 1
        for i in 0...15 {stepsSD [i] = 0}
        for buttons in self.btnSD {buttons.backgroundColor = UIColor.redColor()}
        if btnPattern1SD.backgroundColor == UIColor.blueColor() {
            pattern1SD = stepsSD
        }
        if btnPattern2SD.backgroundColor == UIColor.blueColor() {
            pattern2SD = stepsSD
        }
    }
    @IBAction func btnPattern1SD(sender: AnyObject) {
        if patternContinuousPlaySD == 0 {stepsSD = pattern1SD}
        btnPattern1SD.backgroundColor = UIColor.blueColor()
        btnPattern2SD.backgroundColor = UIColor.redColor()
        btnRNDPatternSD.backgroundColor = UIColor.redColor()
        rndOnSD = 1
        for i in 0...15 {
            if pattern1SD[i] == 1 {
                self.btnSD[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnSD[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern2SD.enabled = true
        btnPattern1SD.enabled = false
    }
    @IBAction func btnPattern2SD(sender: AnyObject) {
        if patternContinuousPlaySD == 0 {stepsSD = pattern2SD}
        btnPattern2SD.backgroundColor = UIColor.blueColor()
        btnPattern1SD.backgroundColor = UIColor.redColor()
        btnRNDPatternSD.backgroundColor = UIColor.redColor()
        rndOnSD = 1
        for i in 0...15 {
            if pattern2SD[i] == 1 {
                self.btnSD[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnSD[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern1SD.enabled = true
        btnPattern2SD.enabled = false
    }
    @IBAction func btnChooseSD606(sender: UIButton) {
        if btnChooseSD606.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum606", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            btnChooseSD606.backgroundColor = UIColor.blueColor()
            btnChooseSD808.backgroundColor = UIColor.redColor()
            btnChooseSD909.backgroundColor = UIColor.redColor()
            btnChooseSD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseSD808(sender: UIButton) {
        if btnChooseSD808.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum808", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            btnChooseSD606.backgroundColor = UIColor.redColor()
            btnChooseSD808.backgroundColor = UIColor.blueColor()
            btnChooseSD909.backgroundColor = UIColor.redColor()
            btnChooseSD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseSD909(sender: UIButton) {
        if btnChooseSD909.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum909", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            btnChooseSD606.backgroundColor = UIColor.redColor()
            btnChooseSD808.backgroundColor = UIColor.redColor()
            btnChooseSD909.backgroundColor = UIColor.blueColor()
            btnChooseSD78.backgroundColor = UIColor.redColor()
        }
    }
    @IBAction func btnChooseSD78(sender: UIButton) {
        if btnChooseSD78.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let SDURL = NSBundle.mainBundle().URLForResource("SnareDrum78", withExtension: "wav")
            do {
                audioFileSnareDrum = try AVAudioFile(forReading: SDURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileSnareDrum = nil
            }
            btnChooseSD606.backgroundColor = UIColor.redColor()
            btnChooseSD808.backgroundColor = UIColor.redColor()
            btnChooseSD909.backgroundColor = UIColor.redColor()
            btnChooseSD78.backgroundColor = UIColor.blueColor()
        }
    }
    @IBAction func btnPatternContinuousSD(sender: UIButton) {
        if patternContinuousPlaySD == 0 {patternContinuousPlaySD = 1;sender.backgroundColor = UIColor.blueColor()} else {
            patternContinuousPlaySD = 0
            sender.backgroundColor = UIColor.redColor()
            if btnPattern1SD.backgroundColor == UIColor.blueColor() {
                stepsSD = pattern1SD
            }
            if btnPattern2SD.backgroundColor == UIColor.blueColor() {
                stepsSD = pattern2SD
            }
        }
    }
//-------------------------------------------------------------------------------------
    
// all RimShot-Action-------------------------------------------------------------------------------------
    @IBAction func btnStepsRS(sender: UIButton) {
        if patternContinuousPlayRS == 0 {
            if stepsRS[Int(sender.currentTitle!)!] == 0 {
                stepsRS[Int(sender.currentTitle!)!] = 1
                sender.backgroundColor = UIColor.orangeColor()
            }else{
                stepsRS[Int(sender.currentTitle!)!] = 0
                sender.backgroundColor = UIColor.redColor()
            }
            if btnPattern1RS.backgroundColor == UIColor.blueColor() {
                pattern1RS = stepsRS
            }
            if btnPattern2RS.backgroundColor == UIColor.blueColor() {
                pattern2RS = stepsRS
            }
        }
        if patternContinuousPlayRS == 1 {
            if btnPattern1RS.backgroundColor == UIColor.blueColor() {
                if pattern1RS[Int(sender.currentTitle!)!] == 0 {
                    pattern1RS[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern1RS[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            if btnPattern2RS.backgroundColor == UIColor.blueColor() {
                if pattern2RS[Int(sender.currentTitle!)!] == 0 {
                    pattern2RS[Int(sender.currentTitle!)!] = 1
                    sender.backgroundColor = UIColor.orangeColor()
                }else{
                    pattern2RS[Int(sender.currentTitle!)!] = 0
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }
    }
    @IBAction func RNDStepsRS(sender: AnyObject) {
        for buttons in btnRS {buttons.backgroundColor = UIColor.redColor()}
        if rndOnRS == 1 {
            btnRNDPatternRS.backgroundColor = UIColor.blueColor()
            for i in 0...15 {
                let RND = Int(arc4random_uniform(2))
                stepsRS[i] = RND
                if RND == 1 {btnRS[i].backgroundColor = UIColor.orangeColor()}
            }
            rndOnRS = 0
        } else {
            btnRNDPatternRS.backgroundColor = UIColor.redColor()
            if btnPattern1RS.backgroundColor == UIColor.blueColor() {
                stepsRS = pattern1RS
            }
            if btnPattern2RS.backgroundColor == UIColor.blueColor() {
                stepsRS = pattern2RS
            }
            for i in 0...15{if stepsRS[i] == 1{btnRS[i].backgroundColor = UIColor.orangeColor()}}
            rndOnRS = 1
        }
    }
    @IBAction func sldDistortionRS(sender: UISlider) {distortionNodeRS.wetDryMix = sender.value}
    @IBAction func sldDelayRS(sender: UISlider) {delayNodeRS.wetDryMix = sender.value}
    @IBAction func sldReverbRS(sender: UISlider) {reverbNodeRS.wetDryMix = sender.value}
    @IBAction func sldVolumeRS(sender: UISlider) {RimShot.volume = sender.value}
    @IBAction func btnMuteRS(sender: UIButton) {if lockRSVolume == 0 {lockRSVolume = 1; btnMuteRS.backgroundColor = UIColor.blueColor()
    }else{lockRSVolume = 0; btnMuteRS.backgroundColor = UIColor.redColor()}}
    @IBAction func sldPanRS(sender: AnyObject) {RimShot.pan = sender.value}
    @IBAction func btnRSReset(sender: AnyObject) {
        btnRNDPatternRS.backgroundColor = UIColor.redColor()
        rndOnRS = 1
        for i in 0...15 {stepsRS [i] = 0}
        for buttons in self.btnRS {buttons.backgroundColor = UIColor.redColor()}
        if btnPattern1RS.backgroundColor == UIColor.blueColor() {
            pattern1RS = stepsRS
        }
        if btnPattern2RS.backgroundColor == UIColor.blueColor() {
            pattern2RS = stepsRS
        }
    }
    @IBAction func btnPattern1RS(sender: AnyObject) {
        if patternContinuousPlayRS == 0 {stepsRS = pattern1RS}
        btnPattern1RS.backgroundColor = UIColor.blueColor()
        btnPattern2RS.backgroundColor = UIColor.redColor()
        btnRNDPatternRS.backgroundColor = UIColor.redColor()
        rndOnRS = 1
        for i in 0...15 {
            if pattern1RS[i] == 1 {
                self.btnRS[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnRS[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern2RS.enabled = true
        btnPattern1RS.enabled = false
    }
    @IBAction func btnPattern2RS(sender: AnyObject) {
        if patternContinuousPlayRS == 0 {stepsRS = pattern2RS}
        btnPattern2RS.backgroundColor = UIColor.blueColor()
        btnPattern1RS.backgroundColor = UIColor.redColor()
        btnRNDPatternRS.backgroundColor = UIColor.redColor()
        rndOnRS = 1
        for i in 0...15 {
            if pattern2RS[i] == 1 {
                self.btnRS[i].backgroundColor = UIColor.orangeColor()
            } else {
                self.btnRS[i].backgroundColor = UIColor.redColor()
            }
        }
        btnPattern1RS.enabled = true
        btnPattern2RS.enabled = false
    }
    @IBAction func btnChooseRS606(sender: UIButton) {
        if btnChooseRS606.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let RSURL = NSBundle.mainBundle().URLForResource("OpenHiHat606", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            btnChooseRS606.backgroundColor = UIColor.blueColor()
            btnChooseRS808.backgroundColor = UIColor.redColor()
            btnChooseRS909.backgroundColor = UIColor.redColor()
            btnChooseRS78.backgroundColor = UIColor.redColor()
            lblRimShot.text = "OH"
        }
    }
    @IBAction func btnChooseRS808(sender: UIButton) {
        if btnChooseRS808.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot808", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            btnChooseRS606.backgroundColor = UIColor.redColor()
            btnChooseRS808.backgroundColor = UIColor.blueColor()
            btnChooseRS909.backgroundColor = UIColor.redColor()
            btnChooseRS78.backgroundColor = UIColor.redColor()
            lblRimShot.text = "RS"
        }
    }
    @IBAction func btnChooseRS909(sender: UIButton) {
        if btnChooseRS909.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot909", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            btnChooseRS606.backgroundColor = UIColor.redColor()
            btnChooseRS808.backgroundColor = UIColor.redColor()
            btnChooseRS909.backgroundColor = UIColor.blueColor()
            btnChooseRS78.backgroundColor = UIColor.redColor()
            lblRimShot.text = "RS"
        }
    }
    @IBAction func btnChooseRS78(sender: UIButton) {
        if btnChooseRS78.backgroundColor == UIColor.redColor(){
            var error: NSError?
            let RSURL = NSBundle.mainBundle().URLForResource("RimShot78", withExtension: "wav")
            do {
                audioFileRimShot = try AVAudioFile(forReading: RSURL!)
            } catch let error1 as NSError {
                error = error1
                audioFileRimShot = nil
            }
            btnChooseRS606.backgroundColor = UIColor.redColor()
            btnChooseRS808.backgroundColor = UIColor.redColor()
            btnChooseRS909.backgroundColor = UIColor.redColor()
            btnChooseRS78.backgroundColor = UIColor.blueColor()
            lblRimShot.text = "RS"
        }
    }
    @IBAction func btnPatternContinuousRS(sender: UIButton) {
        if patternContinuousPlayRS == 0 {patternContinuousPlayRS = 1;sender.backgroundColor = UIColor.blueColor()} else {
            patternContinuousPlayRS = 0
            sender.backgroundColor = UIColor.redColor()
            if btnPattern1RS.backgroundColor == UIColor.blueColor() {
                stepsRS = pattern1RS
            }
            if btnPattern2RS.backgroundColor == UIColor.blueColor() {
                stepsRS = pattern2RS
            }
        }
    }
//-------------------------------------------------------------------------------------
    
// all SynthBass Action-------------------------------------------------------------------------------------
    @IBAction func btnPitchDownSB(sender: UIButton) {
        counterPitchSB = counterPitchSB - 100
        if counterPitchSB <= -2400 {counterPitchSB = 2400}
        lblSBOctave.text = SBOktave[counterPitchSB]
    }
    @IBAction func btnPitchUpSB(sender: UIButton) {
        counterPitchSB = counterPitchSB + 100
        if counterPitchSB >= 2400 {counterPitchSB = -2400}
        lblSBOctave.text = SBOktave[counterPitchSB]
    }
    @IBAction func btnStepDownSB(sender: UIButton) {
        counterPatternSB = counterPatternSB - 1
        if counterPatternSB < 0 {counterPatternSB = 15}
        lblPositionPatternSB.text = "\(counterPatternSB + 1)"
        if stepsSB[counterPatternSB] == 1 {
            lblCurrentOctave.text = "\(SBOktave[oktaveStep[counterPatternSB]]!)"
        }else{
            lblCurrentOctave.text = " "
        }
    }
    @IBAction func btnStepUpSB(sender: UIButton) {
        counterPatternSB = counterPatternSB + 1
        if counterPatternSB > 15 {counterPatternSB = 0}
        lblPositionPatternSB.text = "\(counterPatternSB + 1)"
        if stepsSB[counterPatternSB] == 1 {
            lblCurrentOctave.text = "\(SBOktave[oktaveStep[counterPatternSB]]!)"
        }else{
            lblCurrentOctave.text = " "
        }
    }
    @IBAction func btnSetOctaveSB(sender: UIButton) {
        stepsSB[counterPatternSB] = 1
        oktaveStep[counterPatternSB] = counterPitchSB
        lblCurrentOctave.text = SBOktave[counterPitchSB]
    }
    @IBAction func btnClearStepSB(sender: UIButton) {
        stepsSB[counterPatternSB] = 0
        oktaveStep[counterPatternSB] = 0
        lblCurrentOctave.text = " "
    }
//-------------------------------------------------------------------------------------
    
// choose da DrumKit-------------------------------------------------------------------------------------
    @IBAction func btn606DrumKit(sender: AnyObject) {
        chooseDrumKit = 1
        loadAudioFile()
        btn606.backgroundColor = UIColor.blueColor()
        btn808.backgroundColor = UIColor.redColor()
        btn909.backgroundColor = UIColor.redColor()
        btn78.backgroundColor = UIColor.redColor()
        resetCooseAll()
    }
    @IBAction func btn808DrumKit(sender: AnyObject) {
        chooseDrumKit = 2
        loadAudioFile()
        btn606.backgroundColor = UIColor.redColor()
        btn808.backgroundColor = UIColor.blueColor()
        btn909.backgroundColor = UIColor.redColor()
        btn78.backgroundColor = UIColor.redColor()
        resetCooseAll()
    }
    @IBAction func btn909DrumKit(sender: AnyObject) {
        chooseDrumKit = 3
        loadAudioFile()
        btn606.backgroundColor = UIColor.redColor()
        btn808.backgroundColor = UIColor.redColor()
        btn909.backgroundColor = UIColor.blueColor()
        btn78.backgroundColor = UIColor.redColor()
        resetCooseAll()
    }
    @IBAction func btn78DrumKit(sender: AnyObject) {
        chooseDrumKit = 4
        loadAudioFile()
        btn606.backgroundColor = UIColor.redColor()
        btn808.backgroundColor = UIColor.redColor()
        btn909.backgroundColor = UIColor.redColor()
        btn78.backgroundColor = UIColor.blueColor()
        resetCooseAll()
    }
    func resetCooseAll(){
        btnChooseBD606.backgroundColor = UIColor.redColor()
        btnChooseBD808.backgroundColor = UIColor.redColor()
        btnChooseBD909.backgroundColor = UIColor.redColor()
        btnChooseBD78.backgroundColor = UIColor.redColor()
        btnChooseHH606.backgroundColor = UIColor.redColor()
        btnChooseHH808.backgroundColor = UIColor.redColor()
        btnChooseHH909.backgroundColor = UIColor.redColor()
        btnChooseHH78.backgroundColor = UIColor.redColor()
        btnChooseCL606.backgroundColor = UIColor.redColor()
        btnChooseCL808.backgroundColor = UIColor.redColor()
        btnChooseCL909.backgroundColor = UIColor.redColor()
        btnChooseCL78.backgroundColor = UIColor.redColor()
        btnChooseSD606.backgroundColor = UIColor.redColor()
        btnChooseSD808.backgroundColor = UIColor.redColor()
        btnChooseSD909.backgroundColor = UIColor.redColor()
        btnChooseSD78.backgroundColor = UIColor.redColor()
        btnChooseRS606.backgroundColor = UIColor.redColor()
        btnChooseRS808.backgroundColor = UIColor.redColor()
        btnChooseRS909.backgroundColor = UIColor.redColor()
        btnChooseRS78.backgroundColor = UIColor.redColor()
    }
//-------------------------------------------------------------------------------------
    
// da shuffle-Action-------------------------------------------------------------------------------------
    @IBAction func btnShuffleUp(sender: AnyObject) {
        shuffleCounter++
        if shuffleCounter > 3 {shuffleCounter = 0}
        shuffle = UInt64(shuffleValue[shuffleCounter])
        lblShuffle.text = "\(shuffleCounter)"
    }
//-------------------------------------------------------------------------------------
    
// da BPM-Action-------------------------------------------------------------------------------------
    @IBAction func btnBPMUp(sender: AnyObject) {
        BPMcount++
        if BPMcount > 180 {BPMcount = 180}
        BPM = UInt64((15 / BPMcount) * 1000)
        let BPMint = Int(BPMcount)
        lblBPM.text = "\(BPMint)"
    }
    @IBAction func btnBPMDown(sender: AnyObject) {
        BPMcount = BPMcount - 1
        if BPMcount < 60 {BPMcount = 60}
        BPM = UInt64((15 / BPMcount) * 1000)
        let BPMint = Int(BPMcount)
        lblBPM.text = "\(BPMint)"
    }
//-------------------------------------------------------------------------------------
    
//bae-------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning(){super.didReceiveMemoryWarning()}
//-------------------------------------------------------------------------------------
    
}


