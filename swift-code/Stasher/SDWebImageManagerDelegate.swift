//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

protocol SDWebImageManagerDelegate: NSObjectProtocol {
    func webImageManager(_ imageManager: SDWebImageManager, didFinishWith image: UIImage)

    func webImageManager(_ imageManager: SDWebImageManager, didFailWithError error: Error?)

    func updateProgressView(_ progress: NSNumber)
}