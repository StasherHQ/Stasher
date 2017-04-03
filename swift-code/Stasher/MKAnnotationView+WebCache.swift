//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  MKAnnotationView+WebCache.swift
//  SDWebImage
//
//  Created by Olivier Poitrey on 14/03/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//
/**
 * Integrates SDWebImage async downloading and caching of remote images with MKAnnotationView.
 */
extension MKAnnotationView: SDWebImageManagerDelegate {
    /**
     * Set the imageView `image` with an `url`.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     */
    func setImageWith(_ url: URL) {
        setImageWith(url, placeholderImage: nil)
    }
    /**
     * Set the imageView `image` with an `url` and a placeholder.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     * @param placeholder The image to be set initially, until the image request finishes.
     * @see setImageWithURL:placeholderImage:options:
     */

    func setImageWith(_ url: URL, placeholderImage placeholder: UIImage) {
        setImageWith(url, placeholderImage: placeholder, options: 0)
    }
    /**
     * Set the imageView `image` with an `url`, placeholder and custom options.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     * @param placeholder The image to be set initially, until the image request finishes.
     * @param options The options to use when downloading the image. @see SDWebImageOptions for the possible values.
     */

    func setImageWith(_ url: URL, placeholderImage placeholder: UIImage, options: SDWebImageOptions) {
        var manager = SDWebImageManager.shared
        // Remove in progress downloader from queue
        manager.cancel(forDelegate: self)
        image = placeholder
        if url {
            manager.download(with: url, delegate: self, options: options)
        }
    }
#if NS_BLOCKS_AVAILABLE
    /**
     * Set the imageView `image` with an `url`.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
     * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
     */

    func setImageWith(_ url: URL, success: @escaping (_ image: UIImage) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        setImageWith(url, placeholderImage: nil, success: success, failure: failure)
    }
    /**
     * Set the imageView `image` with an `url`, placeholder.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     * @param placeholder The image to be set initially, until the image request finishes.
     * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
     * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
     */

    func setImageWith(_ url: URL, placeholderImage placeholder: UIImage, success: @escaping (_ image: UIImage) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        setImageWith(url, placeholderImage: placeholder, options: 0, success: success, failure: failure)
    }
    /**
     * Set the imageView `image` with an `url`, placeholder and custom options.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url for the image.
     * @param placeholder The image to be set initially, until the image request finishes.
     * @param options The options to use when downloading the image. @see SDWebImageOptions for the possible values.
     * @param success A block to be executed when the image request succeed This block has no return value and takes the retrieved image as argument.
     * @param failure A block object to be executed when the image request failed. This block has no return value and takes the error object describing the network or parsing error that occurred (may be nil).
     */

    func setImageWith(_ url: URL, placeholderImage placeholder: UIImage, options: SDWebImageOptions, success: @escaping (_ image: UIImage) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var manager = SDWebImageManager.shared
        // Remove in progress downloader from queue
        manager.cancel(forDelegate: self)
        image = placeholder
        if url {
            // [manager downloadWithURL:url delegate:self options:options success:success failure:failure];
            manager.download(with: url, delegate: self, options: options)
        }
    }
#endif
    /**
     * Cancel the current download
     */

    func cancelCurrentImageLoad() {
        SDWebImageManager.shared.cancel(forDelegate: self)
    }

#if NS_BLOCKS_AVAILABLE
#endif

    func webImageManager(_ imageManager: SDWebImageManager, didProgressWithPartialImage image: UIImage, for url: URL) {
        self.image = image
    }

    func webImageManager(_ imageManager: SDWebImageManager, didFinishWith image: UIImage) {
        self.image = image
    }
}