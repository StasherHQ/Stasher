/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}

- (void)cancelCurrentImageLoad
{
	//UIProgressView *prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
	//prg.hidden = YES;
    UIActivityIndicatorView *arg=(UIActivityIndicatorView *) [self viewWithTag:kSDWebImageProgressView];
    arg.hidden=YES;
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    for (UIView *v in [self subviews])
    {
        if ([v isKindOfClass:[UIActivityIndicatorView class]])
        {
            // //NSLog(@"-didFinishWithImage-");
            [((UIActivityIndicatorView*)v) stopAnimating];
            [v removeFromSuperview];
        }
    }
    
    ////NSLog(@"--haa---");
    [self setBackgroundColor:[UIColor whiteColor]];
    [UIView beginAnimations:@"fadeAnimation" context:NULL];
    [UIView setAnimationDuration:0.9];
    self.alpha = 0;
    self.image = image;
    self.alpha=1;
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    [UIView commitAnimations];
//    self.image = image;
////	UIProgressView *prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
////	prg.hidden = YES;
//    UIActivityIndicatorView *arg=(UIActivityIndicatorView *) [self viewWithTag:kSDWebImageProgressView];
//    arg.hidden=YES;
}

- (void)updateProgressView:(NSNumber *)progress {
	if ([progress floatValue] > 0) {
		//UIProgressView *prg = nil;
        UIActivityIndicatorView *arg=nil;
		if ([self viewWithTag:kSDWebImageProgressView] == nil) {
			CGRect r = CGRectMake(10, (self.frame.size.height / 2) - 28, self.frame.size.width - 20, 30);
			/*prg = [[UIProgressView alloc] initWithFrame:r];
            prg.tag = kSDWebImageProgressView;
			//prg.progressViewStyle = kSDWebImageProgressViewStyle;
			prg.progressViewStyle=UIProgressViewStyleBar;
			[self addSubview:prg];
			[prg release];*/
            arg=[[UIActivityIndicatorView alloc]initWithFrame:r];
            arg.tag=kSDWebImageProgressView;
            [self addSubview:arg];
            
            
		} else {
			//prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
            arg=(UIActivityIndicatorView *)[self viewWithTag:kSDWebImageProgressView];
		}
		//[prg setHidden:NO];
		//[prg setProgress:[progress floatValue]];
        [arg startAnimating];
	}
}


@end
