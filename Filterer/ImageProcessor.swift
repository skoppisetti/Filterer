import Foundation
import UIKit



public class ImageProcessor {
    
    // redify is a simple filter which will accentuate the redness of an image
    public class func redify(image: UIImage, intensity: Int = 5) -> UIImage {
        let myRGBA = RGBAImage(image: image)
        var totalRed = 0
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                totalRed += Int(pixel.red)
            }
        }
        
        let totalPixels = myRGBA!.height * myRGBA!.width
        let avgRed = totalRed/totalPixels
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index  = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                let redDiff = Int(pixel.red) - avgRed
                if redDiff > 0 {
                    pixel.red = UInt8(max(0, min( 255, avgRed + redDiff * intensity)))
                    myRGBA!.pixels[index] = pixel
                }
            }
        }
        return myRGBA!.toUIImage()!
    }
    
    // hulkify is a simple filter which will accentuate the greenness of an image
    public class func hulkify(image: UIImage, intensity: Int = 5) -> UIImage {
        let myRGBA = RGBAImage(image: image)
        var totalGreen = 0
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                totalGreen += Int(pixel.green)
            }
        }
        
        let totalPixels = myRGBA!.height * myRGBA!.width
        let avgGreen = totalGreen/totalPixels
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index  = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                let greenDiff = Int(pixel.green) - avgGreen
                if greenDiff > 0 {
                    pixel.red = UInt8(max(0, min( 255, avgGreen + greenDiff * intensity)))
                    myRGBA!.pixels[index] = pixel
                }
            }
        }
        return myRGBA!.toUIImage()!
    }
    
    // smurfify is a simple filter which will accentuate the blueness of an image
    public class func smurfify(image: UIImage, intensity: Int = 5) -> UIImage {
        let myRGBA = RGBAImage(image: image)
        var totalBlue = 0
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                totalBlue += Int(pixel.blue)
            }
        }
        
        let totalPixels = myRGBA!.height * myRGBA!.width
        let avgBlue = totalBlue/totalPixels
        
        for y in 0..<myRGBA!.height {
            for x in 0..<myRGBA!.width {
                let index  = y * myRGBA!.width + x
                var pixel = myRGBA!.pixels[index]
                let blueDiff = Int(pixel.blue) - avgBlue
                if blueDiff > 0 {
                    pixel.red = UInt8(max(0, min( 255, avgBlue + blueDiff * intensity)))
                    myRGBA!.pixels[index] = pixel
                }
            }
        }
        return myRGBA!.toUIImage()!
    }
        
    public class func applyFilter(image: UIImage, filterName: Filter, v : Int? = 0) -> UIImage {
        switch filterName {
        case .Redify:
            return redify(image, intensity: v!)
        case .Hulkify:
            return hulkify(image, intensity: v!)
        case .Smurfify:
            return smurfify(image, intensity: v!)
        case .TwoXContrast:
            return hulkify(redify(image, intensity: 10), intensity: 10)
        case .DoubleBright:
            return hulkify(redify(image, intensity: -10), intensity: -10)
        case .None:
            return image
        }
    }
}
