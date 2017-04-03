//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
enum SDWebImageOptions : Int {
    static let sdWebImageRetryFailed: SDWebImageOptions = 1 << 0
    static let sdWebImageLowPriority: SDWebImageOptions = 1 << 1
    static let sdWebImageCacheMemoryOnly: SDWebImageOptions = 1 << 2
}

class SDWebImageManager: NSObject, SDWebImageDownloaderDelegate, SDImageCacheDelegate {
    var downloadDelegates = [Any]()
    var downloaders = [Any]()
    var cacheDelegates = [Any]()
    var cacheURLs = [Any]()
    var downloaderForURL = [AnyHashable: Any]()
    var failedURLs = [Any]()

    class func sharedManager() -> Any {
        if instance == nil {
            instance = SDWebImageManager()
        }
        return instance
    }

    func image(with url: URL) -> UIImage {
        return SDImageCache.shared().image(fromKey: url.absoluteString)
    }

    func download(with url: URL, delegate: SDWebImageManagerDelegate) {
        download(with: url, delegate: delegate, options: 0)
    }

    func download(with url: URL, delegate: SDWebImageManagerDelegate, options: SDWebImageOptions) {
        // Very common mistake is to send the URL using NSString object instead of NSURL. For some strange reason, XCode won't
        // throw any warning for this type mismatch. Here we failsafe this error by allowing URLs to be passed as NSString.
        if (url is NSString) {
            url = URL(string: (url as? String))
        }
        if !url || !delegate || (!(options & .sdWebImageRetryFailed) && failedURLs.contains(url)) {
            return
        }
        // Check the on-disk cache async so we don't block the main thread
        cacheDelegates.append(delegate)
        cacheURLs.append(url)
        var info: [AnyHashable: Any] = [
                "delegate" : delegate,
                "url" : url,
                "options" : Int(options)
            ]

        SDImageCache.shared().queryDiskCache(forKey: url.absoluteString, delegate: self, userInfo: info)
    }

    func download(with url: URL, delegate: SDWebImageManagerDelegate, retryFailed: Bool) {
        download(with: url, delegate: delegate, options: (retryFailed ? .sdWebImageRetryFailed : 0))
    }


    override init() {
        if (super.init()) {
            downloadDelegates = [Any]()
            downloaders = [Any]()
            cacheDelegates = [Any]()
            cacheURLs = [Any]()
            downloaderForURL = [AnyHashable: Any]()
            failedURLs = [Any]()
        }
    }

    deinit {
        , downloadDelegates = nil
        , downloaders = nil
        , cacheDelegates = nil
        , cacheURLs = nil
        , downloaderForURL = nil
        , failedURLs = nil
    }
    /**
     * @deprecated
     */
    /**
     * @deprecated
     */
    /**
     * @deprecated
     */

    func download(with url: URL, delegate: SDWebImageManagerDelegate, retryFailed: Bool, lowPriority: Bool) {
        var options: SDWebImageOptions = 0
        if retryFailed {
            options |= .sdWebImageRetryFailed
        }
        if lowPriority {
            options |= .sdWebImageLowPriority
        }
        download(with: url, delegate: delegate, options: options)
    }

    func cancel(for delegate: SDWebImageManagerDelegate) {
        var idx: Int
        while (idx = (cacheDelegates as NSArray).indexOfObjectIdentical(to: delegate)) != NSNotFound {
            cacheDelegates.remove(at: idx)
            cacheURLs.remove(at: idx)
        }
        while (idx = (downloadDelegates as NSArray).indexOfObjectIdentical(to: delegate)) != NSNotFound {
            var downloader: SDWebImageDownloader? = (downloaders[idx] as? SDWebImageDownloader)?
            downloadDelegates.remove(at: idx)
            downloaders.remove(at: idx)
            if !downloaders.contains(downloader) {
                // No more delegate are waiting for this download, cancel it
                downloader?.cancel()
                downloaderForURL.removeValueForKey(downloader?.url)
            }
        }
    }
// MARK: SDImageCacheDelegate

    func indexOf(_ delegate: SDWebImageManagerDelegate, waitingFor url: URL) -> Int {
            // Do a linear search, simple (even if inefficient)
        var idx: Int
        for idx in 0..<cacheDelegates.count {
            if cacheDelegates[idx] == delegate && cacheURLs[idx].isEqual(url) {
                return idx
            }
        }
        return NSNotFound
    }

    func imageCache(_ imageCache: SDImageCache, didFind image: UIImage, forKey key: String, userInfo info: [AnyHashable: Any]) {
        var url: URL? = (info["url"] as? URL)
        var delegate: SDWebImageManagerDelegate? = (info["delegate"] as? SDWebImageManagerDelegate)
        var idx: Int = indexOf(delegate, waitingFor: url)
        if idx == NSNotFound {
            // Request has since been canceled
            return
        }
        if delegate?.responds(to: Selector("webImageManager:didFinishWithImage:")) {
            delegate?.perform(Selector("webImageManager:didFinishWithImage:"), withObject: self, withObject: image)
        }
        cacheDelegates.remove(at: idx)
        cacheURLs.remove(at: idx)
    }

    func imageCache(_ imageCache: SDImageCache, didNotFindImageForKey key: String, userInfo info: [AnyHashable: Any]) {
        var url: URL? = (info["url"] as? URL)
        var delegate: SDWebImageManagerDelegate? = (info["delegate"] as? SDWebImageManagerDelegate)
        var options: SDWebImageOptions? = CInt((info["options"] as? SDWebImageOptions))
        var idx: Int = indexOf(delegate, waitingFor: url)
        if idx == NSNotFound {
            // Request has since been canceled
            return
        }
        cacheDelegates.remove(at: idx)
        cacheURLs.remove(at: idx)
            // Share the same downloader for identical URLs so we don't download the same URL several times
        var downloader: SDWebImageDownloader? = (downloaderForURL[url] as? SDWebImageDownloader)
        if downloader == nil {
            downloader = SDWebImageDownloader(url, delegate: self, userInfo: info, lowPriority: (options & .sdWebImageLowPriority))
            downloaderForURL[url] = downloader
        }
        else {
            // Reuse shared downloader
            downloader?.userInfo = info
            downloader?.isLowPriority = (options & .sdWebImageLowPriority)
        }
        downloadDelegates.append(delegate)
        downloaders.append(downloader)
    }
// MARK: SDWebImageDownloaderDelegate

    func imageDownloader(_ downloader: SDWebImageDownloader, didReceive data: Data) {
        downloader
        // Notify all the delegates with this downloader
        var idx = downloaders.count - 1
        while idx >= 0 {
            var aDownloader: SDWebImageDownloader? = (downloaders[idx] as? SDWebImageDownloader)
            if aDownloader == downloader {
                //            id<SDWebImageManagerDelegate> delegate = [downloadDelegates objectAtIndex:idx];
                //            if (data && [delegate respondsToSelector:@selector(updateProgressView:)])
                //            {
                //				NSNumber *progress = [NSNumber numberWithFloat:(aDownloader.totalReceivedLength / aDownloader.expectedContentLength)];
                //                [delegate performSelector:@selector(updateProgressView:) withObject:progress];
                //            }
            }
            idx -= 1
        }
    }

    func imageDownloader(_ downloader: SDWebImageDownloader, didFinishWith image: UIImage) {
        downloader
        var options: SDWebImageOptions? = CInt((downloader.userInfo?["options"] as? SDWebImageOptions))
        // Notify all the downloadDelegates with this downloader
        var idx = Int(downloaders.count) - 1
        while idx >= 0 {
            var uidx = Int(idx)
            var aDownloader: SDWebImageDownloader? = (downloaders[uidx] as? SDWebImageDownloader)
            if aDownloader == downloader {
                var delegate: SDWebImageManagerDelegate? = (downloadDelegates[uidx] as? SDWebImageManagerDelegate)?
                if image {
                    if delegate?.responds(to: Selector("webImageManager:didFinishWithImage:")) {
                        delegate?.perform(Selector("webImageManager:didFinishWithImage:"), withObject: self, withObject: image)
                    }
                }
                else {
                    if delegate?.responds(to: Selector("webImageManager:didFailWithError:")) {
                        delegate?.perform(Selector("webImageManager:didFailWithError:"), withObject: self, withObject: nil)
                    }
                }
                downloaders.remove(at: uidx)
                downloadDelegates.remove(at: uidx)
            }
            idx -= 1
        }
        if image {
            // Store the image in the cache
            SDImageCache.shared().store(image, imageData: downloader.imageData, forKey: downloader.url.absoluteString, toDisk: !(options & .sdWebImageCacheMemoryOnly))
        }
        else if !(options & .sdWebImageRetryFailed) {
            // The image can't be downloaded from this URL, mark the URL as failed so we won't try and fail again and again
            // (do this only if SDWebImageRetryFailed isn't activated)
            failedURLs.append(downloader.url)
        }

        // Release the downloader
        downloaderForURL.removeValueForKey(downloader.url)
    }

    func imageDownloader(_ downloader: SDWebImageDownloader, didFailWithError error: Error?) {
        downloader
        // Notify all the downloadDelegates with this downloader
        var idx = Int(downloaders.count) - 1
        while idx >= 0 {
            var uidx = Int(idx)
            var aDownloader: SDWebImageDownloader? = (downloaders[uidx] as? SDWebImageDownloader)
            if aDownloader == downloader {
                var delegate: SDWebImageManagerDelegate? = (downloadDelegates[uidx] as? SDWebImageManagerDelegate)?
                if delegate?.responds(to: Selector("webImageManager:didFailWithError:")) {
                    delegate?.perform(Selector("webImageManager:didFailWithError:"), withObject: self, withObject: error)
                }
                downloaders.remove(at: uidx)
                downloadDelegates.remove(at: uidx)
            }
            idx -= 1
        }
        // Release the downloader
        downloaderForURL.removeValueForKey(downloader.url)
    }
}
// use options:SDWebImageRetryFailed instead

func download(with url: URL, delegate: SDWebImageManagerDelegate, retryFailed: Bool, lowPriority isLowPriority: Bool) {
    (deprecated)
    // use options:SDWebImageRetryFailed|SDWebImageLowPriority instead
    -( as? Void)
    var instance: SDWebImageManager?
}