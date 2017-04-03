//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import Foundation
let SDWebImageDownloadStartNotification: String = ""
let SDWebImageDownloadStopNotification: String = ""
class SDWebImageDownloader: NSObject {

    var connection: NSURLConnection?

    var expectedContentLength: Float = 0.0
    var totalReceivedLength: Float = 0.0
    var url: URL?
    weak var delegate: SDWebImageDownloaderDelegate?
    var connection: NSURLConnection?
    var imageData: Data?
    var userInfo: Any?
    var lowPriority: Bool = false
    var url: URL?
    weak var delegate: SDWebImageDownloaderDelegate?
    var imageData: Data?
    var userInfo: Any?
    var expectedContentLength: Float = 0.0
    var totalReceivedLength: Float = 0.0
    var isLowPriority: Bool = false

    convenience init(url: URL, delegate: SDWebImageDownloaderDelegate, userInfo: Any, lowPriority isLowPriority: Bool) {
        // Bind SDNetworkActivityIndicator if available (download it here: http://github.com/rs/SDNetworkActivityIndicator )
        // To use it, just add #import "SDNetworkActivityIndicator.h" in addition to the SDWebImage import
        if NSClassFromString("SDNetworkActivityIndicator") {
            var activityIndicator: Any? = NSClassFromString("SDNetworkActivityIndicator").perform(NSSelectorFromString("sharedActivityIndicator"))
            NotificationCenter.default.addObserver(activityIndicator, selector: NSSelectorFromString("startActivity"), name: SDWebImageDownloadStartNotification, object: nil)
            NotificationCenter.default.addObserver(activityIndicator, selector: NSSelectorFromString("stopActivity"), name: SDWebImageDownloadStopNotification, object: nil)
        }
        var downloader = SDWebImageDownloader()
        downloader.url = url
        downloader.delegate = delegate
        downloader.userInfo = userInfo
        downloader.isLowPriority = isLowPriority
        downloader.performSelector(onMainThread: #selector(self.start), withObject: nil, waitUntilDone: true)
        return downloader
    }

    convenience init(url: URL, delegate: SDWebImageDownloaderDelegate, userInfo: Any) {
        return self.init(url: url, delegate: delegate, userInfo: userInfo, lowPriority: false)
    }

    convenience init(url: URL, delegate: SDWebImageDownloaderDelegate) {
        return self.init(url: url, delegate: delegate, userInfo: nil)
    }

    func start() {
            // In order to prevent from potential duplicate caching (NSURLCache + SDImageCache) we disable the cache for image requests
        var request = URLRequest(url: url, cachePolicy: NSURLRequestReloadIgnoringLocalCacheData, timeoutInterval: 15)
        connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        // If not in low priority mode, ensure we aren't blocked by UI manipulations (default runloop mode for NSURLConnection is NSEventTrackingRunLoopMode)
        if !isLowPriority {
            connection?.schedule(inRunLoop: RunLoop.current, forMode: NSRunLoopCommonModes)
        }
        connection?.start()
        if connection != nil {
            imageData = Data.data
            NotificationCenter.default.post(name: SDWebImageDownloadStartNotification, object: nil)
        }
        else {
            if delegate.responds(to: Selector("imageDownloader:didFailWithError:")) {
                delegate.perform(Selector("imageDownloader:didFailWithError:"), withObject: self, withObject: nil)
            }
        }
    }

    func cancel() {
        if connection != nil {
            connection?.cancel()
            connection = nil
            NotificationCenter.default.post(name: SDWebImageDownloadStopNotification, object: nil)
        }
    }
    // This method is now no-op and is deprecated

    class func setMaxConcurrentDownloads(_ max: Int) {
        // NOOP
    }

// MARK: Public Methods
// MARK: NSURLConnection (delegate)

    func connection(_ aConnection: NSURLConnection, didReceiveData data: Data) {
        imageData?.append(data)
        totalReceivedLength += data.length
        if delegate.responds(to: Selector("imageDownloader:didReceiveData:")) {
            delegate.perform(Selector("imageDownloader:didReceiveData:"), with: self)
        }
    }
//GCC diagnostic ignored "-Wundeclared-selector"

    func connectionDidFinishLoading(_ aConnection: NSURLConnection) {
        connection = nil
        NotificationCenter.default.post(name: SDWebImageDownloadStopNotification, object: nil)
        if delegate.responds(to: #selector(self.imageDownloaderDidFinish)) {
            delegate.perform(#selector(self.imageDownloaderDidFinish), with: self)
        }
        if delegate.responds(to: Selector("imageDownloader:didFinishWithImage:")) {
            var image = UIImage(data: imageData!)
#if ENABLE_SDWEBIMAGE_DECODER
            SDWebImageDecoder.shared().decode(image, withDelegate: self, userInfo: nil)
#else
            delegate.perform(Selector("imageDownloader:didFinishWithImage:"), withObject: self, withObject: image)
#endif
        }
    }

    func connection(_ connection: NSURLConnection, didFailWithError error: Error?) {
        NotificationCenter.default.post(name: SDWebImageDownloadStopNotification, object: nil)
        if delegate.responds(to: Selector("imageDownloader:didFailWithError:")) {
            delegate.perform(Selector("imageDownloader:didFailWithError:"), withObject: self, withObject: error)
        }
        self.connection = nil
        imageData = nil
    }

    func connection(_ connection: NSURLConnection, didReceiveResponse response: URLResponse) {
        expectedContentLength = response.expectedContentLength
    }
// MARK: SDWebImageDecoderDelegate
#if ENABLE_SDWEBIMAGE_DECODER

    func imageDecoder(_ decoder: SDWebImageDecoder, didFinishDecoding image: UIImage, userInfo: [AnyHashable: Any]) {
        delegate.perform(Selector("imageDownloader:didFinishWithImage:"), withObject: self, withObject: image)
    }
#endif
// MARK: NSObject

    deinit {
        NotificationCenter.default.removeObserver(self)
        , url = nil
        , connection = nil
        , imageData = nil
        , userInfo = nil
    }
}
#if ENABLE_SDWEBIMAGE_DECODER
extension SDWebImageDownloader: SDWebImageDecoderDelegate {
}
#endif
let SDWebImageDownloadStartNotification: String = "SDWebImageDownloadStartNotification"
let SDWebImageDownloadStopNotification: String = "SDWebImageDownloadStopNotification"
