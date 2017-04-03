//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

protocol SDWebImageDownloaderDelegate: NSObjectProtocol {
    func imageDownloaderDidFinish(_ downloader: SDWebImageDownloader)

    func imageDownloader(_ downloader: SDWebImageDownloader, didFinishWith image: UIImage)

    func imageDownloader(_ downloader: SDWebImageDownloader, didFailWithError error: Error?)

    func imageDownloader(_ downloader: SDWebImageDownloader, didReceive data: Data)
}