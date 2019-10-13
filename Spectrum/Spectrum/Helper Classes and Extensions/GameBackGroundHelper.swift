//
//  GameBackGroundHelper.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/12/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit
extension SpectrumScene{
    
    func setupBackground(){
        
        let gradient = SKSpriteNode(color: UIColor.purple, size: frame.size)
        
        gradient.texture = SKTexture(image: gradientImage(size: gradient.size, color1: CIColor(color: UIColor.purple), color2: CIColor(color: UIColor.red)))
        
        
        background.addChild(gradient)
        addChild(background)
        
    }
    
    
    func gradientImage(size: CGSize, color1: CIColor, color2: CIColor) -> UIImage {
        
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CILinearGradient")
        var startVector: CIVector
        var endVector: CIVector
        
        filter!.setDefaults()
        
        startVector = CIVector(x: size.width * 0.5, y: 0)
        endVector = CIVector(x: size.width * 0.5, y: size.height * 0.8)
        
        filter!.setValue(startVector, forKey: "inputPoint0")
        filter!.setValue(endVector, forKey: "inputPoint1")
        filter!.setValue(color1, forKey: "inputColor0")
        filter!.setValue(color2, forKey: "inputColor1")
        
        let image = UIImage(cgImage: context.createCGImage(filter!.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))!)
        return image
    }
    
    
    
    
}
