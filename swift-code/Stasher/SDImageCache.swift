//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import Foundation
class SDImageCache: NSObject {
    var memCache = [AnyHashable: Any]()
    var diskCachePath: String = ""
    var cacheInQueue: OperationQueue?
    var cacheOutQueue: OperationQueue?

    class func shared() -> SDImageCache {
        if instance == nil {
            instance = SDImageCache()
        }
        return instance
    }

    func store(_ image: UIImage, forKey key: String) {
        store(image, imageData: nil, forKey: key, toDisk: true)
    }

    func store(_ image: UIImage, forKey key: String, toDisk: Bool) {
        store(image, imageData: nil, forKey: key, toDisk: toDisk)
    }

    func store(_ image: UIImage, imageData data: Data, forKey key: String, toDisk: Bool) {
        if !image || !key {
            return
        }
        memCache[key] = image
        if toDisk {
            if !data {
                return
            }
            var keyWithData: [Any]
            if data {
                keyWithData = [key, data]
            }
            else {
                keyWithData = [key]
            }
            cacheInQueue?.addOperation(NSInvocationOperation(target: self, selector: #selector(self.storeKeyWithDataToDisk), object: keyWithData))
        }
    }

    func image(fromKey key: String) -> UIImage {
        return image(fromKey: key, fromDisk: true)
    }

    func image(fromKey key: String, fromDisk: Bool) -> UIImage {
        if key == nil {
            return nil
        }
        var image: UIImage? = (memCache[key] as? UIImage)
        if !image && fromDisk {
            image = UIImage(contentsOfFile: cachePath(forKey: key))?
            if image != nil {
                memCache[key] = image
            }
        }
        return image!
    }

    func queryDiskCache(forKey key: String, delegate: SDImageCacheDelegate, userInfo info: [AnyHashable: Any]) {
        if !delegate {
            return
        }
        if key == "" {
            if delegate.responds(to: Selector("imageCache:didNotFindImageForKey:userInfo:")) {
                delegate.imageCache(self, didNotFindImageForKey: key, userInfo: info)
            }
            return
        }
            // First check the in-memory cache...
        var image: UIImage? = (memCache[key] as? UIImage)
        if image != nil {
            // ...notify delegate immediately, no need to go async
            if delegate.responds(to: Selector("imageCache:didFindImage:forKey:userInfo:")) {
                delegate.imageCache(self, didFind: image, forKey: key, userInfo: info)
            }
            return
        }
        var arguments = [AnyHashable: Any](minimumCapacity: 3)
        arguments["key"] = key
        arguments["delegate"] = delegate
        if !info.isEmpty {
            arguments["userInfo"] = info
        }
        cacheOutQueue?.addOperation(NSInvocationOperation(target: self, selector: #selector(self.queryDiskCacheOperation), object: arguments))
    }

    func removeImage(forKey key: String) {
        if key == nil {
            return
        }
        memCache.removeValueForKey(key)
        try? FileManager.default.removeItem(atPath: cachePath(forKey: key))
    }

    func clearMemory() {
        cacheInQueue?.cancelAllOperations()
        // won't be able to complete
        memCache.removeAll()
    }

    func clearDisk() {
        cacheInQueue?.cancelAllOperations()
        try? FileManager.default.removeItem(atPath: diskCachePath)
        try? FileManager.default.createDirectory(atPath: diskCachePath, withIntermediateDirectories: true, attributes: nil)
    }

    func cleanDisk() {
        var expirationDate = Date(timeIntervalSinceNow: -cacheMaxCacheAge)
        var fileEnumerator: NSDirectoryEnumerator? = FileManager.default.enumerator(atPath: diskCachePath)
        for fileName: String in fileEnumerator {
            var filePath: String = URL(fileURLWithPath: diskCachePath).appendingPathComponent(fileName).absoluteString
            var attrs: [AnyHashable: Any]? = try? FileManager.default.attributesOfItem(at: filePath)
            if attrs?.fileModificationDate()?.laterDate(expirationDate)?.isEqual(to: expirationDate) {
                try? FileManager.default.removeItem(atPath: filePath)
            }
        }
    }

// MARK: NSObject

    override init() {
        if (super.init()) {
            // Init the memory cache
            memCache = [AnyHashable: Any]()
                // Init the disk cache
            var paths: [Any] = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
            diskCachePath = URL(fileURLWithPath: paths[0]).appendingPathComponent("ImageCache").absoluteString
            if !FileManager.default.fileExists(atPath: diskCachePath) {
                try? FileManager.default.createDirectory(atPath: diskCachePath, withIntermediateDirectories: true, attributes: nil)
            }
            // Init the operation queue
            cacheInQueue = OperationQueue()
            cacheInQueue?.maxConcurrentOperationCount = 1
            cacheOutQueue = OperationQueue()
            cacheOutQueue?.maxConcurrentOperationCount = 1
#if TARGET_OS_IPHONE
            // Subscribe to app events
            NotificationCenter.default.addObserver(self, selector: #selector(self.clearMemory), name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.cleanDisk), name: UIApplicationWillTerminateNotification, object: nil)
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
            var device = UIDevice.current
            if device.responds(to: #selector(self.isMultitaskingSupported)) && device.multitaskingSupported {
                // When in background, clean memory in order to have less chance to be killed
                NotificationCenter.default.addObserver(self, selector: #selector(self.clearMemory), name: UIApplicationDidEnterBackgroundNotification, object: nil)
            }
#endif
#endif
        }
    }

    deinit {
        , memCache = nil
        , diskCachePath = nil
        , cacheInQueue = nil
        NotificationCenter.default.removeObserver(self)
    }
// MARK: SDImageCache (class methods)
// MARK: SDImageCache (private)

    func cachePath(forKey key: String) -> String {
        let str = key.utf8
        var r = [UInt8](repeating: 0, count: CC_MD5_DIGEST_LENGTH)
        CC_MD5(str, (strlen(str) as? CC_LONG), r)
        var filename = String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15])
        return URL(fileURLWithPath: diskCachePath).appendingPathComponent(filename).absoluteString
    }

    func storeKeyWithData(toDisk keyAndData: [Any]) {
            // Can't use defaultManager another thread
        var fileManager = FileManager()
        var key: String? = (keyAndData[0] as? String)
        var data = keyAndData.count > 1 ? (keyAndData[1] as? Data) : nil
        if data != nil {
            fileManager.createFile(at: cachePath(forKey: key), contents: data, attributes: nil)
        }
        else {
                // If no data representation given, convert the UIImage in JPEG and store it
                // This trick is more CPU/memory intensive and doesn't preserve alpha channel
            var image: UIImage? = self.image(fromKey: key, fromDisk: true)
            // be thread safe with no lock
            if image != nil {
#if TARGET_OS_IPHONE
                fileManager.createFile(at: cachePath(forKey: key), contents: .uiImageJPEGRepresentation(), attributes: nil)
#else
                var representations: [Any]? = image?.representations()
                var jpegData: Data? = NSBitmapImageRep.representationOfImageReps(inArray: representations, using: NSJPEGFileType, properties: nil)
                fileManager.createFile(at: cachePath(forKey: key), contents: jpegData, attributes: nil)
#endif
            }
        }
    }

    func notifyDelegate(_ arguments: [AnyHashable: Any]) {
        var key: String? = (arguments["key"] as? String)
        var delegate: SDImageCacheDelegate? = (arguments["delegate"] as? SDImageCacheDelegate)
        var info: [AnyHashable: Any]? = (arguments["userInfo"] as? [AnyHashable: Any])
        var image: UIImage? = (arguments["image"] as? UIImage)
        if image != nil {
            memCache[key] = image
            if delegate?.responds(to: Selector("imageCache:didFindImage:forKey:userInfo:")) {
                delegate?.imageCache(self, didFind: image, forKey: key, userInfo: info)
            }
        }
        else {
            if delegate?.responds(to: Selector("imageCache:didNotFindImageForKey:userInfo:")) {
                delegate?.imageCache(self, didNotFindImageForKey: key, userInfo: info)
            }
        }
    }

    func queryDiskCacheOperation(_ arguments: [AnyHashable: Any]) {
        var key: String? = (arguments["key"] as? String)
        var mutableArguments: [AnyHashable: Any] = arguments
        var image = UIImage(contentsOfFile: cachePath(forKey: key))?
        if image {
#if ENABLE_SDWEBIMAGE_DECODER
            var decodedImage = UIImage.decodedImage(with: image)
            if decodedImage {
                image = decodedImage
            }
#endif
            mutableArguments["image"] = image
        }
        performSelector(onMainThread: #selector(self.notifyDelegate), withObject: mutableArguments, waitUntilDone: false)
    }
// MARK: ImageCache
}
//#import "SDWebImageDecoder.h"
import CommonCrypto
#if ENABLE_SDWEBIMAGE_DECODER
#endif
var cacheMaxCacheAge: Int = 60 * 60 * 24 * 7
// 1 week
var instance: SDImageCache?