//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
let kSDWebImageProgressView = 43919
let kSDWebImageProgressViewStyle = 101
extension UIImageView: SDWebImageManagerDelegate {
    /**
     * Set the imageView `image` with an `url`.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url that the image is found.
     * @see setImageWithURL:placeholderImage:
     */
    func setImageWith(_ url: URL) {
        setImageWith(url, placeholderImage: nil)
    }
    /**
     * Set the imageView `image` with an `url` and a placeholder.
     *
     * The downloand is asynchronous and cached.
     *
     * @param url The url that the `image` is found.
     * @param placeholder A `image` that will be visible while loading the final image.
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
     * @param url The url that the `image` is found.
     * @param placeholder A `image` that will be visible while loading the final image.
     * @param options A list of `SDWebImageOptions` for current `imageView`. Available options are `SDWebImageRetryFailed`, `SDWebImageLowPriority` and `SDWebImageCacheMemoryOnly`.
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
    /**
     * Cancel the current download
     */

    func cancelCurrentImageLoad() {
            //UIProgressView *prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
            //prg.hidden = YES;
        var arg: UIActivityIndicatorView? = (viewWithTag(kSDWebImageProgressView) as? UIActivityIndicatorView)
        arg?.isHidden = true
        SDWebImageManager.shared.cancel(forDelegate: self)
    }


    func webImageManager(_ imageManager: SDWebImageManager, didFinishWith image: UIImage) {
        for v: UIView in subviews {
            if (v is UIActivityIndicatorView) {
                // //NSLog(@"-didFinishWithImage-");
                (v as? UIActivityIndicatorView)?.stopAnimating()
                v.removeFromSuperview()
            }
        }
        ////NSLog(@"--haa---");
        backgroundColor = UIColor.white
        UIView.beginAnimations("fadeAnimation", context: nil)
        UIView.setAnimationDuration(0.9)
        alpha = 0
        self.image = image
        alpha = 1
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
        UIView.commitAnimations()
        //    self.image = image;
        ////	UIProgressView *prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
        ////	prg.hidden = YES;
        //    UIActivityIndicatorView *arg=(UIActivityIndicatorView *) [self viewWithTag:kSDWebImageProgressView];
        //    arg.hidden=YES;
    }

    func updateProgressView(_ progress: NSNumber) {
        if CFloat(progress) > 0 {
                //UIProgressView *prg = nil;
            var arg: UIActivityIndicatorView? = nil
            if viewWithTag(kSDWebImageProgressView) == nil {
                var r = CGRect(x: CGFloat(10), y: CGFloat((frame.size.height / 2) - 28), width: CGFloat(frame.size.width - 20), height: CGFloat(30))
                /*prg = [[UIProgressView alloc] initWithFrame:r];
                            prg.tag = kSDWebImageProgressView;
                			//prg.progressViewStyle = kSDWebImageProgressViewStyle;
                			prg.progressViewStyle=UIProgressViewStyleBar;
                			[self addSubview:prg];
                			[prg release];*/
                arg = UIActivityIndicatorView(frame: r)
                arg?.tag = kSDWebImageProgressView
                addSubview(arg!)
            }
            else {
                //prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
                arg = (viewWithTag(kSDWebImageProgressView) as? UIActivityIndicatorView)
            }
            //[prg setHidden:NO];
            //[prg setProgress:[progress floatValue]];
            arg?.startAnimating()
        }
    }
}