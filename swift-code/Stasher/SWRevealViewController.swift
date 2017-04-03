//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Early code inspired on a similar class by Philip Kluz (Philip.Kluz@zuui.org)
 
*/
/*

 RELEASE NOTES
 
 Version 1.1.2 (Current Version)
 
 - The status bar style and appearance are now handled in sync with the class animations. 
    You can implement the methods preferredStatusBarStyle and prefersStatusBarHidden on your child controllers to define the desired appearance
    
 - The loadView method now calls a method, loadStoryboardControllers, just for the purpose of loading child controllers from a storyboard.
    You can override this method and remove the @try @catch statements if you want the debuger not to stop at them in case you have set an exception breakpoint.
 
 Version 1.1.1
 
 - You can now get a tapGestureRecognizer from the class. See the tapGestureRecognizer method for more information.
 
 - Both the panGestureRecognizer and the tapGestureRecognizer are now attached to the revealViewController's front content view
    by default, so they will start working just by calling their access methods even if you do not attach them to any of your views.
    This enables you to dissable interactions on your views -for example based on position- without breaking normal gesture behavior.
 
 - Corrected a bug that caused a crash on iOS6 and earlier.
 
 Version 1.1.0

 - The method setFrontViewController:animated now performs the correct animations both for left and right controllers.

 - The class now automatically handles the status bar appearance depending on the currently shown child controller.

 Version 1.0.8
 
 - Support for constant width frontView by setting a negative value to reveal widths. See properties rearViewRevealWidth and rightViewRevealWidth
 
 - Support for draggableBorderWidth. See property of the same name.
 
 - The Pan gesture recongnizer can be disabled by implementing the following delegate method and returning NO
    revealControllerPanGestureShouldBegin:

 - Added the ability to track pan gesture reveal progress through the following new delegate methods
    revealController:panGestureBeganFromLocation:progress:
    revealController:panGestureMovedToLocation:progress:
    revealController:panGestureEndedToLocation:progress:
 
 Previous Versions
 
 - No release notes were updated for previous versions.

*/
import UIKit

// MARK: - SWRevealViewController Class
// Enum values for setFrontViewPosition:animated:
enum FrontViewPosition : Int {
    // Front controller is removed from view. Animated transitioning from this state will cause the same
    // effect than animating from FrontViewPositionLeftSideMost. Use this instead of FrontViewPositionLeftSideMost when
    // you want to remove the front view controller view from the view hierarchy.
    case leftSideMostRemoved
    // Left most position, front view is presented left-offseted by rightViewRevealWidth+rigthViewRevealOverdraw
    case leftSideMost
    // Left position, front view is presented left-offseted by rightViewRevealWidth
    case leftSide
    // Center position, rear view is hidden behind front controller
    case left
    // Right possition, front view is presented right-offseted by rearViewRevealWidth
    case right
    // Right most possition, front view is presented right-offseted by rearViewRevealWidth+rearViewRevealOverdraw
    case rightMost
    // Front controller is removed from view. Animated transitioning from this state will cause the same
    // effect than animating from FrontViewPositionRightMost. Use this instead of FrontViewPositionRightMost when
    // you intent to remove the front controller view from the view hierarchy.
    case rightMostRemoved
}

class SWRevealViewController: UIViewController {

    func _getRevealWidth(_ pRevealWidth: CGFloat, revealOverDraw pRevealOverdraw: CGFloat, forSymetry symetry: Int) {
        if symetry < 0 {
            pRevealWidth = rightViewRevealWidth, pRevealOverdraw = rightViewRevealOverdraw
        }
        else {
            pRevealWidth = rearViewRevealWidth, pRevealOverdraw = rearViewRevealOverdraw
        }
        if pRevealWidth < 0 {
            pRevealWidth = _contentView.bounds.size.width + pRevealWidth
        }
    }

    func _getBounceBack(_ pBounceBack: Bool, pStableDrag: Bool, forSymetry symetry: Int) {
        if symetry < 0 {
            pBounceBack = bounceBackOnLeftOverdraw, pStableDrag = stableDragOnLeftOverdraw
        }
        else {
            pBounceBack = bounceBackOnOverdraw, pStableDrag = stableDragOnOverdraw
        }
    }

    func _getAdjustedFrontViewPosition(_ frontViewPosition: FrontViewPosition, forSymetry symetry: Int) {
        if symetry < 0 {
            frontViewPosition = .left + symetry * (frontViewPosition - .left)
        }
    }
    // Object instance init and rear view setting
    init(rearViewController: UIViewController, frontViewController: UIViewController) {
        super.init()
        
        _initDefaultProperties()
        _setRearViewController(rearViewController)
        _setFrontViewController(frontViewController)
    
    }
    // Rear view controller, can be nil if not used
    var rearViewController: UIViewController?
    // Optional right view controller, can be nil if not used
    var rightViewController: UIViewController?
    // Front view controller, can be nil on initialization but must be supplied by the time its view is loaded
    var frontViewController: UIViewController?
    // Sets the frontViewController using a default set of chained animations consisting on moving the
    // presented frontViewController to the top most right, replacing it, and moving it back to the left position

    func setFront(_ frontViewController: UIViewController, animated: Bool) {
        if !isViewLoaded() {
            _setFrontViewController(frontViewController)
            return
        }
        _dispatchSetFrontViewController(frontViewController, animated: animated)
    }
    // Front view position, use this to set a particular position state on the controller
    // On initialization it is set to FrontViewPositionLeft
    var frontViewPosition = FrontViewPosition(rawValue: 0)
    // Chained animation of the frontViewController position. You can call it several times in a row to achieve
    // any set of animations you wish. Animations will be chained and performed one after the other.

    func setFrontViewPosition(_ frontViewPosition: FrontViewPosition, animated: Bool) {
        if !isViewLoaded() {
            self.frontViewPosition = frontViewPosition
            _rearViewPosition = frontViewPosition
            _rightViewPosition = frontViewPosition
            return
        }
        _dispatchSetFrontViewPosition(frontViewPosition, animated: animated)
    }
    // Toogles the current state of the front controller between Left or Right and fully visible
    // Use setFrontViewPosition to set a particular position

    func revealToggle(animated: Bool) {
        var toogledFrontViewPosition: FrontViewPosition = .left
        if frontViewPosition <= .left {
            toogledFrontViewPosition = .right
        }
        setFrontViewPosition(toogledFrontViewPosition, animated: animated)
    }

    func rightRevealToggle(animated: Bool) {
        var toogledFrontViewPosition: FrontViewPosition = .left
        if frontViewPosition >= .left {
            toogledFrontViewPosition = .leftSide
        }
        setFrontViewPosition(toogledFrontViewPosition, animated: animated)
    }
    // <-- simetric implementation of the above for the rightViewController
    // The following methods are meant to be directly connected to the action method of a button
    // to perform user triggered postion change of the controller views. This is ussually added to a
    // button on top left or right of the frontViewController

    func revealToggle(_ sender: Any) {
        revealToggle(animated: true)
    }

    func rightRevealToggle(_ sender: Any) {
        rightRevealToggle(animated: true)
    }
    // <-- simetric implementation of the above for the rightViewController
    // The following method will provide a panGestureRecognizer suitable to be added to any view
    // in order to perform usual drag and swipe gestures to reveal the rear views. This is usually added to the top bar
    // of a front controller, but it can be added to your frontViewController view or to the reveal controller view to provide full screen panning.
    // The provided panGestureRecognizer is initially added to the reveal controller's front container view, so you can dissable
    // user interactions on your controllers views and the recognizer will continue working. 

    func panGestureRecognizer() -> UIPanGestureRecognizer {
        if _panGestureRecognizer == nil {
            var panRecognizer = SWDirectionPanGestureRecognizer(target: self, action: #selector(self._handleRevealGesture))
            panRecognizer.direction = SWDirectionPanGestureRecognizerHorizontal
            panRecognizer.delegate = self
            _contentView.frontView.addGestureRecognizer(panRecognizer)
            _panGestureRecognizer = panRecognizer
        }
        return _panGestureRecognizer
    }
    // The following method will provide a tapGestureRecognizer suitable to be added to any view on the frontController
    // for concealing the rear views. By default no tap recognizer is created or added to any view, however if you call this method after
    // the controller's view has been loaded the recognizer is added to the reveal controller's front container view.
    // Thus, you can disable user interactions on your frontViewController view without affecting the tap recognizer.

    func tapGestureRecognizer() -> UITapGestureRecognizer {
        if _tapGestureRecognizer == nil {
            var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self._handleTapGesture))
            tapRecognizer.delegate = self
            _contentView.frontView.addGestureRecognizer(tapRecognizer)
            _tapGestureRecognizer = tapRecognizer
        }
        return _tapGestureRecognizer
    }
    // The following properties are provided for further customization, they are set to default values on initialization,
    // you should not generally have to set them
    // Defines how much of the rear or right view is shown, default is 260. A negative value indicates that the reveal width should be
    // computed by substracting the full front view width, so the revealed frontView width is constant.
    var rearViewRevealWidth: CGFloat = 0.0
    var rightViewRevealWidth: CGFloat = 0.0
    // <-- simetric implementation of the above for the rightViewController
    // Defines how much of an overdraw can occur when dragging further than 'rearViewRevealWidth', default is 60.
    var rearViewRevealOverdraw: CGFloat = 0.0
    var rightViewRevealOverdraw: CGFloat = 0.0
    // <-- simetric implementation of the above for the rightViewController
    // Defines how much displacement is applied to the rear view when animating or dragging the front view, default is 40.
    var rearViewRevealDisplacement: CGFloat = 0.0
    var rightViewRevealDisplacement: CGFloat = 0.0
    // Defines a width on the border of the view attached to the panGesturRecognizer where the gesture is allowed,
    // default is 0 which means no restriction.
    var draggableBorderWidth: CGFloat = 0.0
    // If YES (the default) the controller will bounce to the Left position when dragging further than 'rearViewRevealWidth'
    var isBounceBackOnOverdraw: Bool = false
    var isBounceBackOnLeftOverdraw: Bool = false
    // If YES (default is NO) the controller will allow permanent dragging up to the rightMostPosition
    var isStableDragOnOverdraw: Bool = false
    var isStableDragOnLeftOverdraw: Bool = false
    // <-- simetric implementation of the above for the rightViewController
    // If YES (default is NO) the front view controller will be ofsseted vertically by the height of a navigation bar.
    // Use this on iOS7 when you add an instance of RevealViewController as a child of a UINavigationController (or another SWRevealViewController)
    // and you want the front view controller to be presented below the navigation bar of its UINavigationController grand parent .
    // The rearViewController will still appear full size and blurred behind the navigation bar of its UINavigationController grand parent
    var isPresentFrontViewHierarchically: Bool = false
    // Velocity required for the controller to toggle its state based on a swipe movement, default is 300
    var quickFlickVelocity: CGFloat = 0.0
    // Default duration for the revealToggle animation, default is 0.25
    var toggleAnimationDuration = TimeInterval()
    // Defines the radius of the front view's shadow, default is 2.5f
    var frontViewShadowRadius: CGFloat = 0.0
    // Defines the radius of the front view's shadow offset default is {0.0f,2.5f}
    var frontViewShadowOffset = CGSize.zero
    //Defines the front view's shadow opacity, default is 1.0f
    var frontViewShadowOpacity: CGFloat = 0.0
    // The class properly handles all the relevant calls to appearance methods on the contained controllers.
    // Moreover you can assign a delegate to let the class inform you on positions and animation activity.
    // Delegate
    weak var delegate: SWRevealViewControllerDelegate?
    var panInitialFrontPosition = FrontViewPosition(rawValue: 0)
    var animationQueue = [Any]()
    var userInteractionStore: Bool = false


    let FrontViewPositionNone: Int = 0xff
// MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _initDefaultProperties()
    
    }

    convenience override init() {
        return init(rearViewController: nil, frontViewController: nil)
    }

    func _initDefaultProperties() {
        frontViewPosition = .left
        _rearViewPosition = .left
        _rightViewPosition = .left
        rearViewRevealWidth = 260.0
        rearViewRevealOverdraw = 60.0
        rearViewRevealDisplacement = 40.0
        rightViewRevealWidth = 260.0
        rightViewRevealOverdraw = 60.0
        rightViewRevealDisplacement = 40.0
        isBounceBackOnOverdraw = true
        isBounceBackOnLeftOverdraw = true
        isStableDragOnOverdraw = false
        isStableDragOnLeftOverdraw = false
        isPresentFrontViewHierarchically = false
        quickFlickVelocity = 250.0
        toggleAnimationDuration = 0.25
        frontViewShadowRadius = 2.5
        frontViewShadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(2.5))
        frontViewShadowOpacity = 1.0
        _userInteractionStore = true
        _animationQueue = [Any]()
        draggableBorderWidth = 0.0
    }
// MARK: Storyboard support
    static let SWSegueRearIdentifier: String = "sw_rear"
    static let SWSegueFrontIdentifier: String = "sw_front"
    static let SWSegueRightIdentifier: String = "sw_right"

    override func prepare(for segue: SWRevealViewControllerSegue, sender: Any) {
            // $ using a custom segue we can get access to the storyboard-loaded rear/front view controllers
            // the trick is to define segues of type SWRevealViewControllerSegue on the storyboard
            // connecting the SWRevealViewController to the desired front/rear controllers,
            // and setting the identifiers to "sw_rear" and "sw_front"
            // $ these segues are invoked manually in the loadView method if a storyboard
            // was used to instantiate the SWRevealViewController
            // $ none of this would be necessary if Apple exposed "relationship" segues for container view controllers.
        var identifier: String = segue.identifier
        if (segue is SWRevealViewControllerSegue) && sender == nil {
            if (identifier == SWSegueRearIdentifier) {
                segue.performBlock = {(_ rvc_segue: SWRevealViewControllerSegue, _ svc: UIViewController, _ dvc: UIViewController) -> Void in
                    self._setRearViewController(dvc)
                }
            }
            else if (identifier == SWSegueFrontIdentifier) {
                segue.performBlock = {(_ rvc_segue: SWRevealViewControllerSegue, _ svc: UIViewController, _ dvc: UIViewController) -> Void in
                    self._setFrontViewController(dvc)
                }
            }
            else if (identifier == SWSegueRightIdentifier) {
                segue.performBlock = {(_ rvc_segue: SWRevealViewControllerSegue, _ svc: UIViewController, _ dvc: UIViewController) -> Void in
                    self._setRightViewController(dvc)
                }
            }
        }
    }
    // Load any defined front/rear controllers from the storyboard
    // This method is intended to be overrided in case the default behavior will not meet your needs

    func loadStoryboardControllers() {
        if storyboard && rearViewController == nil {
            //Try each segue separately so it doesn't break prematurely if either Rear or Right views are not used.
            defer {
            }
            do {
                performSegue(withIdentifier: SWSegueRearIdentifier, sender: nil)
            } catch let exception {
            } 
            defer {
            }
            do {
                performSegue(withIdentifier: SWSegueFrontIdentifier, sender: nil)
            } catch let exception {
            } 
            defer {
            }
            do {
                performSegue(withIdentifier: SWSegueRightIdentifier, sender: nil)
            } catch let exception {
            }
        }
    }
// MARK: - StatusBar

    override func childViewControllerForStatusBarStyle() -> UIViewController {
        var positionDif: Int = frontViewPosition - .left
        var controller: UIViewController? = frontViewController
        if positionDif > 0 {
            controller = rearViewController
        }
        else if positionDif < 0 {
            controller = rightViewController
        }

        return controller!
    }

    override func childViewControllerForStatusBarHidden() -> UIViewController {
        var controller: UIViewController? = childViewControllerForStatusBarStyle()
        return controller!
    }
// MARK: - View lifecycle

    override func loadView() {
            // Do not call super, to prevent the apis from unfruitful looking for inexistent xibs!
            // This is what Apple tells us to set as the initial frame, which is of course totally irrelevant
            // with the modern view controller containment patterns, let's leave it for the sake of it!
            //CGRect frame = [[UIScreen mainScreen] applicationFrame];
            // On iOS7 the applicationFrame does not return the whole screen. This is possibly a bug.
            // As a workaround we use the screen bounds, this still works on iOS6
        var frame: CGRect = UIScreen.main.bounds
        // create a custom content view for the controller
        _contentView = SWRevealView(frame: frame, controller: self)
        // set the content view to resize along with its superview
        _contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // set our contentView to the controllers view
        view = _contentView
        // load any defined front/rear controllers from the storyboard
        loadStoryboardControllers()
        // Apple also tells us to do this:
        _contentView.backgroundColor = UIColor.black
            // we set the current frontViewPosition to none before seting the
            // desired initial position, this will force proper controller reload
        var initialPosition: FrontViewPosition = frontViewPosition
        frontViewPosition = FrontViewPositionNone
        _rearViewPosition = FrontViewPositionNone
        _rightViewPosition = FrontViewPositionNone
        // now set the desired initial position
        _setFrontViewPosition(initialPosition, withDuration: 0.0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Uncomment the following code if you want the child controllers
        // to be loaded at this point.
        //
        // We leave this commented out because we think loading childs here is conceptually wrong.
        // Instead, we refrain view loads until necesary, for example we may never load
        // the rear controller view -or the front controller view- if it is never displayed.
        //
        // If you need to manipulate views of any of your child controllers in an override
        // of this method, you can load yourself the views explicitly on your overriden method.
        // However we discourage it as an app following the MVC principles should never need to do so
        //  [_frontViewController view];
        //  [_rearViewController view];
        // we store at this point the view's user interaction state as we may temporarily disable it
        // and resume it back to the previous state, it is possible to override this behaviour by
        // intercepting it on the panGestureBegan and panGestureEnded delegates
        _userInteractionStore = _contentView.userInteractionEnabled
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    // Support for earlier than iOS 6.0
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000

    func shouldAutorotate(to interfaceOrientation: UIInterfaceOrientation) -> Bool {
        return true
    }
#endif
// MARK: - Public methods and property accessors

    func setFront(_ frontViewController: UIViewController) {
        setFront(frontViewController, animated: false)
    }

    func setRear(_ rightViewController: UIViewController) {
        if !isViewLoaded() {
            _setRearViewController(rightViewController)
            return
        }
        _dispatchSetRearViewController(rightViewController)
    }

    func setRight(_ rightViewController: UIViewController) {
        if !isViewLoaded() {
            _setRightViewController(rightViewController)
            return
        }
        _dispatchSetRightViewController(rightViewController)
    }

    func setFrontViewPosition(_ frontViewPosition: FrontViewPosition) {
        setFrontViewPosition(frontViewPosition, animated: false)
    }
// MARK: - Provided acction methods
// MARK: - UserInteractionEnabling
    // disable userInteraction on the entire control

    func _disableUserInteraction() {
        _contentView.userInteractionEnabled = false
        _contentView.disableLayout = true
    }
    // restore userInteraction on the control

    func _restoreUserInteraction() {
        // we use the stored userInteraction state just in case a developer decided
        // to have our view interaction disabled beforehand
        _contentView.userInteractionEnabled = _userInteractionStore
        _contentView.disableLayout = false
    }
// MARK: - PanGesture progress notification

    func _notifyPanGestureBegan() {
        if delegate?.responds(to: #selector(self.revealControllerPanGestureBegan)) {
            delegate?.revealControllerPanGestureBegan(self)
        }
        var xLocation: CGFloat
        var dragProgress: CGFloat
        _getDragLocation(xLocation, progress: dragProgress)
        if delegate?.responds(to: Selector("revealController:panGestureBeganFromLocation:progress:")) {
            delegate?.revealController(self, panGestureBeganFromLocation: xLocation, progress: dragProgress)
        }
    }

    func _notifyPanGestureMoved() {
        var xLocation: CGFloat
        var dragProgress: CGFloat
        _getDragLocation(xLocation, progress: dragProgress)
        if delegate?.responds(to: Selector("revealController:panGestureMovedToLocation:progress:")) {
            delegate?.revealController(self, panGestureMovedToLocation: xLocation, progress: dragProgress)
        }
    }

    func _notifyPanGestureEnded() {
        var xLocation: CGFloat
        var dragProgress: CGFloat
        _getDragLocation(xLocation, progress: dragProgress)
        if delegate?.responds(to: Selector("revealController:panGestureEndedToLocation:progress:")) {
            delegate?.revealController(self, panGestureEndedToLocation: xLocation, progress: dragProgress)
        }
        if delegate?.responds(to: #selector(self.revealControllerPanGestureEnded)) {
            delegate?.revealControllerPanGestureEnded(self)
        }
    }
// MARK: - Symetry

    func _getDragLocation(_ xLocation: CGFloat, progress: CGFloat) {
        var frontView: UIView? = _contentView.frontView
        xLocation = frontView?.frame?.origin?.x
        var symetry: Int = xLocation < 0 ? -1 : 1
        var xWidth: CGFloat = symetry < 0 ? rightViewRevealWidth : rearViewRevealWidth
        if xWidth < 0 {
            xWidth = _contentView.bounds.size.width + xWidth
        }
        progress = xLocation / xWidth * symetry
    }
// MARK: - Deferred block execution queue
    // Define a convenience macro to enqueue single statements
func _enqueue(code: Any) -> Any {
    return _enqueueBlock({() -> Void in
    var code = ()
})
}
    // Defers the execution of the passed in block until a paired _dequeue call is received,
    // or executes the block right away if no pending requests are present.

    func _enqueueBlock(_ block: @escaping (_: Void) -> Void) {
        _animationQueue.insert(block, at: 0)
        if _animationQueue.count == 1 {
            block()
        }
    }
    // Removes the top most block in the queue and executes the following one if any.
    // Calls to this method must be paired with calls to _enqueueBlock, particularly it may be called
    // from within a block passed to _enqueueBlock to remove itself when done with animations.  

    func _dequeue() {
        _animationQueue.removeLast()
        if _animationQueue.count > 0 {
            var block: ((_: Void) -> Void)?? = _animationQueue.last
            block()
        }
    }
// MARK: - Gesture Delegate

    func gestureRecognizerShouldBegin(_ recognizer: UIGestureRecognizer) -> Bool {
        // only allow gesture if no previous request is in process
        if _animationQueue.count == 0 {
            if recognizer == _panGestureRecognizer {
                return _panGestureShouldBegin()
            }
            if recognizer == _tapGestureRecognizer {
                return _tapGestureShouldBegin()
            }
        }
        return false
    }

    func _tapGestureShouldBegin() -> Bool {
        if frontViewPosition == .left || frontViewPosition == .rightMostRemoved || frontViewPosition == .leftSideMostRemoved {
            return false
        }
        // forbid gesture if the following delegate is implemented and returns NO
        if delegate?.responds(to: #selector(self.revealControllerTapGestureShouldBegin)) {
            if delegate?.revealControllerTapGestureShouldBegin(self) == false {
                return false
            }
        }
        return true
    }

    func _panGestureShouldBegin() -> Bool {
        //    // only allow gesture if no previous request is in process
        //    if ( recognizer != _panGestureRecognizer || _animationQueue.count != 0 )
        //        return NO;
        // forbid gesture if the following delegate is implemented and returns NO
        if delegate?.responds(to: #selector(self.revealControllerPanGestureShouldBegin)) {
            if delegate?.revealControllerPanGestureShouldBegin(self) == false {
                return false
            }
        }
        var recognizerView: UIView? = _panGestureRecognizer.view
        var xLocation: CGFloat = _panGestureRecognizer.location(in: recognizerView).x
        var width: CGFloat? = recognizerView?.bounds?.size?.width
        var draggableBorderAllowing: Bool = (frontViewPosition != .left || draggableBorderWidth == 0.0 || xLocation <= draggableBorderWidth || xLocation >= (width - draggableBorderWidth))
        // allow gesture only within the bounds defined by the draggableBorderWidth property
        return draggableBorderAllowing
    }
// MARK: - Gesture Based Reveal

    func _handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        var duration: TimeInterval = toggleAnimationDuration
        _setFrontViewPosition(.left, withDuration: duration)
    }

    func _handleRevealGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
            case .began:
                _handleRevealGestureStateBegan(with: recognizer)
            case .changed:
                _handleRevealGestureStateChanged(with: recognizer)
            case .ended:
                _handleRevealGestureStateEnded(with: recognizer)
            case .cancelled:
                //case UIGestureRecognizerStateFailed:
                _handleRevealGestureStateCancelled(with: recognizer)
            default:
                break
        }

    }

    func _handleRevealGestureStateBegan(with recognizer: UIPanGestureRecognizer) {
        // we know that we will not get here unless the animationQueue is empty because the recognizer
        // delegate prevents it, however we do not want any forthcoming programatic actions to disturb
        // the gesture, so we just enqueue a dummy block to ensure any programatic acctions will be
        // scheduled after the gesture is completed
        _enqueueBlock({() -> Void in
        })
        // <-- dummy block
        // we store the initial position and initialize a target position
        _panInitialFrontPosition = frontViewPosition
        // we disable user interactions on the views, however programatic accions will still be
        // enqueued to be performed after the gesture completes
        _disableUserInteraction()
        _notifyPanGestureBegan()
    }

    func _handleRevealGestureStateChanged(with recognizer: UIPanGestureRecognizer) {
        var translation: CGFloat = recognizer.translation(in: _contentView).x
        var baseLocation: CGFloat = _contentView.frontLocation(for: _panInitialFrontPosition)
        var xLocation: CGFloat = baseLocation + translation
        if xLocation < 0 {
            if rightViewController == nil {
                xLocation = 0
            }
            _rightViewDeployment(forNewFrontViewPosition: .leftSide)()
            _rearViewDeployment(forNewFrontViewPosition: .leftSide)()
        }
        if xLocation > 0 {
            if rearViewController == nil {
                xLocation = 0
            }
            _rightViewDeployment(forNewFrontViewPosition: .right)()
            _rearViewDeployment(forNewFrontViewPosition: .right)()
        }
        _contentView.dragFrontView(toXLocation: xLocation)
        _notifyPanGestureMoved()
    }

    func _handleRevealGestureStateEnded(with recognizer: UIPanGestureRecognizer) {
        var frontView: UIView? = _contentView.frontView
        var xLocation: CGFloat? = frontView?.frame?.origin?.x
        var velocity: CGFloat = recognizer.velocity(in: _contentView).x
            //NSLog( @"Velocity:%1.4f", velocity);
            // depending on position we compute a simetric replacement of widths and positions
        var symetry: Int = xLocation < 0 ? -1 : 1
            // simetring computing of widths
        var revealWidth: CGFloat
        var revealOverdraw: CGFloat
        var bounceBack: Bool
        var stableDrag: Bool
        _getRevealWidth(revealWidth, revealOverDraw: revealOverdraw, forSymetry: symetry)
        _getBounceBack(bounceBack, pStableDrag: stableDrag, forSymetry: symetry)
        // simetric replacement of position
        xLocation = xLocation * symetry
            // initially we assume drag to left and default duration
        var frontViewPosition: FrontViewPosition = .left
        var duration: TimeInterval = toggleAnimationDuration
        // Velocity driven change:
        if fabs(velocity) > quickFlickVelocity {
                // we may need to set the drag position and to adjust the animation duration
            var journey: CGFloat? = xLocation
            if velocity * symetry > 0.0 {
                frontViewPosition = .right
                journey = revealWidth - xLocation
                if xLocation > revealWidth {
                    if !bounceBack && stableDrag {
                        frontViewPosition = .rightMost
                        journey = revealWidth + revealOverdraw - xLocation
                    }
                }
            }
            duration = fabs(journey / velocity)
        }
        else {
            // we may need to set the drag position        
            if xLocation > revealWidth * 0.5 {
                frontViewPosition = .right
                if xLocation > revealWidth {
                    if bounceBack {
                        frontViewPosition = .left
                    }
                    else if stableDrag && xLocation > revealWidth + revealOverdraw * 0.5 {
                        frontViewPosition = .rightMost
                    }
                }
            }
        }
        // symetric replacement of frontViewPosition
        _getAdjustedFrontViewPosition(frontViewPosition, forSymetry: symetry)
        // restore user interaction and animate to the final position
        _restoreUserInteraction()
        _notifyPanGestureEnded()
        _setFrontViewPosition(frontViewPosition, withDuration: duration)
    }

    func _handleRevealGestureStateCancelled(with recognizer: UIPanGestureRecognizer) {
        _restoreUserInteraction()
        _notifyPanGestureEnded()
        _dequeue()
    }
// MARK: Enqueued position and controller setup

    func _dispatchSetFrontViewPosition(_ frontViewPosition: FrontViewPosition, animated: Bool) {
        var duration: TimeInterval = animated ? toggleAnimationDuration : 0.0
        weak var theSelf: SWRevealViewController? = self
        _enqueue(theSelf?._setFrontViewPosition(frontViewPosition, withDuration: duration))
    }

    func _dispatchSetFrontViewController(_ newFrontViewController: UIViewController, animated: Bool) {
        var preReplacementPosition: FrontViewPosition = .left
        if frontViewPosition > .left {
            preReplacementPosition = .rightMost
        }
        if frontViewPosition < .left {
            preReplacementPosition = .leftSideMost
        }
        var duration: TimeInterval = animated ? toggleAnimationDuration : 0.0
        var firstDuration: TimeInterval = duration
        var initialPosDif: Int = (frontViewPosition - preReplacementPosition)
        if initialPosDif == 1 {
            firstDuration *= 0.8
        }
        else if initialPosDif == 0 {
            firstDuration = 0
        }

        weak var theSelf: SWRevealViewController? = self
        if animated {
            _enqueue(theSelf?._setFrontViewPosition(preReplacementPosition, withDuration: firstDuration))
            _enqueue(theSelf?._setFrontViewController(newFrontViewController))
            _enqueue(theSelf?._setFrontViewPosition(.left, withDuration: duration))
        }
        else {
            _enqueue(theSelf?._setFrontViewController(newFrontViewController))
        }
    }

    func _dispatchSetRearViewController(_ newRearViewController: UIViewController) {
        weak var theSelf: SWRevealViewController? = self
        _enqueue(theSelf?._setRearViewController(newRearViewController))
    }

    func _dispatchSetRightViewController(_ newRightViewController: UIViewController) {
        weak var theSelf: SWRevealViewController? = self
        _enqueue(theSelf?._setRightViewController(newRightViewController))
    }
// MARK: animated view controller deployment and layout
    // Primitive method for view controller deployment and animated layout to the given position.

    func _setFrontViewPosition(_ newPosition: FrontViewPosition, withDuration duration: TimeInterval) {
        var rearDeploymentCompletion: (() -> Void)? = _rearViewDeployment(forNewFrontViewPosition: newPosition)
        var rightDeploymentCompletion: (() -> Void)? = _rightViewDeployment(forNewFrontViewPosition: newPosition)
        var frontDeploymentCompletion: (() -> Void)? = _frontViewDeployment(forNewFrontViewPosition: newPosition)
        var animations: (() -> Void)?? = {() -> Void in
                // Calling this in the animation block causes the status bar to appear/dissapear in sync with our own animation
                if self.responds(to: #selector(self.setNeedsStatusBarAppearanceUpdate)) {
                    self.perform(#selector(self.setNeedsStatusBarAppearanceUpdate), with: nil)
                }
                // We call the layoutSubviews method on the contentView view and send a delegate, which will
                // occur inside of an animation block if any animated transition is being performed
                _contentView.layoutSubviews()
                if delegate?.responds(to: Selector("revealController:animateToPosition:")) {
                    delegate?.revealController(self, animateTo: frontViewPosition)
                }
            }
        var completion: ((_: Bool) -> Void)? = {(_ finished: Bool) -> Void in
                rearDeploymentCompletion()
                rightDeploymentCompletion()
                frontDeploymentCompletion()
                self._dequeue()
            }
        if duration > 0.0 {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: animations, completion: completion)
        }
        else {
            animations()
            completion(true)
        }
    }
    // primitive method for front controller transition

    func _setFrontViewController(_ newFrontViewController: UIViewController) {
        var old: UIViewController? = frontViewController
        frontViewController = newFrontViewController
        _transition(from: old, to: newFrontViewController, in: _contentView.frontView)()
        _dequeue()
    }
    // Primitive method for rear controller transition

    func _setRearViewController(_ newRearViewController: UIViewController) {
        var old: UIViewController? = rearViewController
        rearViewController = newRearViewController
        _transition(from: old, to: newRearViewController, in: _contentView.rearView)()
        _dequeue()
    }
    // Primitive method for right controller transition

    func _setRightViewController(_ newRightViewController: UIViewController) {
        var old: UIViewController? = rightViewController
        rightViewController = newRightViewController
        _transition(from: old, to: newRightViewController, inView: _contentView.rightView)()
        _dequeue()
        //    UIViewController *old = _rightViewController;
        //    void (^completion)() = [self _transitionRearController:old toController:newRightViewController inView:_contentView.rightView];
        //    [newRightViewController.view setAlpha:0.0];
        //    [UIView animateWithDuration:_toggleAnimationDuration
        //    animations:^
        //    {
        //        [old.view setAlpha:0.0f];
        //        [newRightViewController.view setAlpha:1.0];
        //    }
        //    completion:^(BOOL finished)
        //    {
        //        completion();
        //        [self _dequeue];
        //    }];
    }
// MARK: Position based view controller deployment
    // Deploy/Undeploy of the front view controller following the containment principles. Returns a block
    // that must be invoked on animation completion in order to finish deployment

    func _frontViewDeployment(forNewFrontViewPosition newPosition: FrontViewPosition) -> @escaping (_: Void) -> Void {
        if (rightViewController == nil && newPosition < .left) || (rearViewController == nil && newPosition > .left) {
            newPosition = .left
        }
        var positionIsChanging: Bool = (frontViewPosition != newPosition)
        var appear: Bool = (frontViewPosition >= .rightMostRemoved || frontViewPosition <= .leftSideMostRemoved) && (newPosition < .rightMostRemoved && newPosition > .leftSideMostRemoved)
        var disappear: Bool = (newPosition >= .rightMostRemoved || newPosition <= .leftSideMostRemoved) && (frontViewPosition < .rightMostRemoved && frontViewPosition > .leftSideMostRemoved)
        if positionIsChanging {
            if delegate?.responds(to: Selector("revealController:willMoveToPosition:")) {
                delegate?.revealController(self, willMoveTo: newPosition)
            }
        }
        frontViewPosition = newPosition
        var deploymentCompletion: (() -> Void)? = _deployment(for: frontViewController, in: _contentView.frontView, appear: appear, disappear: disappear)
        var completion: (() -> Void)?? = {() -> Void in
                deploymentCompletion()
                if positionIsChanging {
                    if delegate?.responds(to: Selector("revealController:didMoveToPosition:")) {
                        delegate?.revealController(self, didMoveTo: newPosition)
                    }
                }
            }
        return completion!
    }
    // Deploy/Undeploy of the left view controller following the containment principles. Returns a block
    // that must be invoked on animation completion in order to finish deployment

    func _rearViewDeployment(forNewFrontViewPosition newPosition: FrontViewPosition) -> @escaping (_: Void) -> Void {
        if isPresentFrontViewHierarchically {
            newPosition = .right
        }
        if rearViewController == nil && newPosition > .left {
            newPosition = .left
        }
        var appear: Bool = (_rearViewPosition <= .left || _rearViewPosition == FrontViewPositionNone) && newPosition > .left
        var disappear: Bool = (newPosition <= .left || newPosition == FrontViewPositionNone) && _rearViewPosition > .left
        if appear {
            _contentView.prepareRearView(for: newPosition)
        }
        _rearViewPosition = newPosition
        return _deployment(for: rearViewController, in: _contentView.rearView, appear: appear, disappear: disappear)
    }
    // Deploy/Undeploy of the right view controller following the containment principles. Returns a block
    // that must be invoked on animation completion in order to finish deployment

    func _rightViewDeployment(forNewFrontViewPosition newPosition: FrontViewPosition) -> @escaping (_: Void) -> Void {
        if rightViewController == nil && newPosition < .left {
            newPosition = .left
        }
        var appear: Bool = _rightViewPosition >= .left && newPosition < .left
        var disappear: Bool = newPosition >= .left && _rightViewPosition < .left
        if appear {
            _contentView.prepareRightView(for: newPosition)
        }
        _rightViewPosition = newPosition
        return _deployment(for: rightViewController, inView: _contentView.rightView, appear: appear, disappear: disappear)
    }

    func _deployment(for controller: UIViewController, in view: UIView, appear: Bool, disappear: Bool) -> @escaping (_: Void) -> Void {
        if appear {
            return _deploy(for: controller, in: view)
        }
        if disappear {
            return _undeploy(for: controller)
        }
        return {() -> Void in
        }
    }
// MARK: Containment view controller deployment and transition
    // Containment Deploy method. Returns a block to be invoked at the
    // animation completion, or right after return in case of non-animated deployment.

    func _deploy(for controller: UIViewController, in view: UIView) -> @escaping (_: Void) -> Void {
        if !controller || !view {
            return {(_: Void) -> Void in
            }
        }
        var frame: CGRect = view.bounds
        var controllerView: UIView? = controller.view
        controllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controllerView?.frame = frame
        if controller.responds(to: #selector(self.automaticallyAdjustsScrollViewInsets)) && (controllerView? is UIScrollView) {
            var adjust = Bool(controller.perform(#selector(self.automaticallyAdjustsScrollViewInsets), with: nil))
            if adjust {
                (controllerView as? Any)?.contentInset = UIEdgeInsetsMake(statusBarAdjustment(_contentView), 0, 0, 0)
            }
        }
        view.addSubview(controllerView!)
        var completionBlock: ((_: Void) -> Void)? = {(_: Void) -> Void in
                // nothing to do on completion at this stage
            }
        return completionBlock!
    }
    // Containment Undeploy method. Returns a block to be invoked at the
    // animation completion, or right after return in case of non-animated deployment.

    func _undeploy(for controller: UIViewController) -> @escaping (_: Void) -> Void {
        if !controller {
            return {(_: Void) -> Void in
            }
        }
            // nothing to do before completion at this stage
        var completionBlock: ((_: Void) -> Void)? = {(_: Void) -> Void in
                controller.view.removeFromSuperview()
            }
        return completionBlock!
    }
    // Containment Transition method. Returns a block to be invoked at the
    // animation completion, or right after return in case of non-animated transition.

    func _transition(from fromController: UIViewController, to toController: UIViewController, in view: UIView) -> @escaping (_: Void) -> Void {
        if fromController == toController {
            return {(_: Void) -> Void in
            }
        }
        if toController {
            addChildViewController(toController)
        }
        var deployCompletion: (() -> Void)? = _deploy(for: toController, in: view)
        fromController.willMove(toParentViewController: nil)
        var undeployCompletion: (() -> Void)? = _undeploy(for: fromController)
        var completionBlock: ((_: Void) -> Void)? = {(_: Void) -> Void in
                undeployCompletion()
                fromController.removeFromParent()
                deployCompletion()
                toController.didMove(toParentViewController: self)
            }
        return completionBlock!
    }
}
// MARK: - SWRevealViewControllerDelegate Protocol
protocol SWRevealViewControllerDelegate: NSObjectProtocol {
    // The following delegate methods will be called before and after the front view moves to a position
    func revealController(_ revealController: SWRevealViewController, willMoveTo position: FrontViewPosition)

    func revealController(_ revealController: SWRevealViewController, didMoveTo position: FrontViewPosition)
    // This will be called inside the reveal animation, thus you can use it to place your own code that will be animated in sync

    func revealController(_ revealController: SWRevealViewController, animateTo position: FrontViewPosition)
    // Implement this to return NO when you want the pan gesture recognizer to be ignored

    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController) -> Bool
    // Implement this to return NO when you want the tap gesture recognizer to be ignored

    func revealControllerTapGestureShouldBegin(_ revealController: SWRevealViewController) -> Bool
    // Called when the gestureRecognizer began and ended

    func revealControllerPanGestureBegan(_ revealController: SWRevealViewController)

    func revealControllerPanGestureEnded(_ revealController: SWRevealViewController)
    // The following methods provide a means to track the evolution of the gesture recognizer.
    // The 'location' parameter is the X origin coordinate of the front view as the user drags it
    // The 'progress' parameter is a positive value from 0 to 1 indicating the front view location relative to the
    // rearRevealWidth or rightRevealWidth. 1 is fully revealed, dragging ocurring in the overDraw region will result in values above 1.

    func revealController(_ revealController: SWRevealViewController, panGestureBeganFromLocation location: CGFloat, progress: CGFloat)

    func revealController(_ revealController: SWRevealViewController, panGestureMovedToLocation location: CGFloat, progress: CGFloat)

    func revealController(_ revealController: SWRevealViewController, panGestureEndedToLocation location: CGFloat, progress: CGFloat)
}
// MARK: - UIViewController(SWRevealViewController) Category
// We add a category of UIViewController to let childViewControllers easily access their parent SWRevealViewController
extension UIViewController {
    func revealViewController() -> SWRevealViewController {
        var parent: UIViewController? = self
        var revealClass: AnyClass = SWRevealViewController.self
        while nil != (parent = parent?.parent) && !(parent? is revealClass) {

        }
        return (parent as? Any)!
    }
}
// This will allow the class to be defined on a storyboard
// MARK: - SWRevealViewControllerSegue
class SWRevealViewControllerSegue: UIStoryboardSegue {
    var performBlock: ((_ segue: SWRevealViewControllerSegue, _ svc: UIViewController, _ dvc: UIViewController) -> Void)? = nil


    override func perform() {
        if performBlock != nil {
            performBlock(self, source, destination)
        }
    }
}
import QuartzCore
import UIKit
// MARK: - SWDirectionPanGestureRecognizer
enum SWDirectionPanGestureRecognizerDirection : Int {
    case swDirectionPanGestureRecognizerVertical
    case swDirectionPanGestureRecognizerHorizontal
}

class SWDirectionPanGestureRecognizer: UIPanGestureRecognizer {
    var direction = SWDirectionPanGestureRecognizerDirection(rawValue: 0)
    var dragging: Bool = false
    var init = CGPoint.zero



    override func touchesBegan(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        var touch: UITouch? = touches.first
        _init = touch?.location(in: view)
        _dragging = false
    }

    override func touchesMoved(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        if state == .failed {
            return
        }
        if _dragging {
            return
        }
        let kDirectionPanThreshold: Int = 5
        var touch: UITouch? = touches.first
        var nowPoint: CGPoint? = touch?.location(in: view)
        var moveX: CGFloat? = nowPoint?.x - _init.x
        var moveY: CGFloat? = nowPoint?.y - _init.y
        if fabs(moveX) > kDirectionPanThreshold {
            if direction == .swDirectionPanGestureRecognizerHorizontal {
                _dragging = true
            }
            else {
                state = .failed
            }
        }
        else if fabs(moveY) > kDirectionPanThreshold {
            if direction == .swDirectionPanGestureRecognizerVertical {
                _dragging = true
            }
            else {
                state = .failed
            }
        }

    }
}
// MARK: - StatusBar Helper Function
// computes the required offset adjustment due to the status bar for the passed in view,
// it will return the statusBar height if view fully overlaps the statusBar, otherwise returns 0.0f
func statusBarAdjustment(view: UIView) -> CGFloat {
    var adjustment: CGFloat = 0.0
    var viewFrame: CGRect = view.convertRect(view.bounds, to: nil)
    var statusBarFrame: CGRect = UIApplication.shared.statusBarFrame
    if viewFrame.contains(statusBarFrame) {
        adjustment = fminf(statusBarFrame.size.width, statusBarFrame.size.height)
    }
    return adjustment
}
// MARK: - SWRevealView Class
class SWRevealView: UIView {
    var c: SWRevealViewController?

    private(set) var rearView: UIView?
    private(set) var rightView: UIView?
    private(set) var frontView: UIView?
    var isDisableLayout: Bool = false

    class func scaledValue(v1: CGFloat, min2: CGFloat, max2: CGFloat, min1: CGFloat, max1: CGFloat) -> CGFloat {
        var result: CGFloat = min2 + (v1 - min1) * (max2 - min2) / (max1 - min1)
        if result != result {
            return min2
        }
        // nan
        if result < min2 {
            return min2
        }
        if result > max2 {
            return max2
        }
        return result
    }

    init(frame: CGRect, controller: SWRevealViewController) {
        super.init(frame: frame)
        
        _c = controller
        var bounds: CGRect = self.bounds
        frontView = UIView(frame: bounds)
        frontView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(frontView!)
        var frontViewLayer: CALayer? = frontView?.layer
        frontViewLayer?.masksToBounds = false
        frontViewLayer?.shadowColor = UIColor.black.cgColor
        //frontViewLayer.shadowOpacity = 1.0f;
        frontViewLayer?.shadowOpacity = _c.frontViewShadowOpacity
        frontViewLayer?.shadowOffset = _c.frontViewShadowOffset
        frontViewLayer?.shadowRadius = _c.frontViewShadowRadius
    
    }

    func hierarchycalFrameAdjustment(_ frame: CGRect) -> CGRect {
        if _c.isPresentFrontViewHierarchically {
            var offset: CGFloat = 44 + statusBarAdjustment(self)
            frame.origin.y += offset
            frame.size.height -= offset
        }
        return frame
    }

    override func layoutSubviews() {
        if isDisableLayout {
            return
        }
        var bounds: CGRect = self.bounds
        var xLocation: CGFloat = frontLocation(for: _c.frontViewPosition)
        _layoutRearViews(forLocation: xLocation)
        var frame = CGRect(x: xLocation, y: CGFloat(0.0), width: CGFloat(bounds.size.width), height: CGFloat(bounds.size.height))
        frontView?.frame = hierarchycalFrameAdjustment(frame)
        var shadowPath = UIBezierPath(rect: frontView?.bounds)
        frontView?.layer?.shadowPath = shadowPath?.cgPath
    }

    func prepareRearView(for newPosition: FrontViewPosition) {
        if rearView == nil {
            rearView = UIView(frame: bounds)
            rearView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(rearView, belowSubview: frontView)
        }
        var xLocation: CGFloat = frontLocation(for: _c.frontViewPosition)
        _layoutRearViews(forLocation: xLocation)
        _prepare(forNewPosition: newPosition)
    }

    func prepareRightView(for newPosition: FrontViewPosition) {
        if rightView == nil {
            rightView = UIView(frame: bounds)
            rightView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(rightView, belowSubview: frontView)
        }
        var xLocation: CGFloat = frontLocation(for: _c.frontViewPosition)
        _layoutRearViews(forLocation: xLocation)
        _prepare(forNewPosition: newPosition)
    }

    func frontLocation(for frontViewPosition: FrontViewPosition) -> CGFloat {
        var revealWidth: CGFloat
        var revealOverdraw: CGFloat
        var location: CGFloat = 0.0
        var symetry: Int = frontViewPosition < .left ? -1 : 1
        _c._getRevealWidth(revealWidth, revealOverDraw: revealOverdraw, forSymetry: symetry)
        _c._getAdjustedFrontViewPosition(frontViewPosition, forSymetry: symetry)
        if frontViewPosition == .right {
            location = revealWidth
        }
        else if frontViewPosition > .right {
            location = revealWidth + revealOverdraw
        }

        return location * symetry
    }

    func dragFrontView(toXLocation xLocation: CGFloat) {
        var bounds: CGRect = self.bounds
        xLocation = _adjustedDragLocation(forLocation: xLocation)
        _layoutRearViews(forLocation: xLocation)
        var frame = CGRect(x: xLocation, y: CGFloat(0.0), width: CGFloat(bounds.size.width), height: CGFloat(bounds.size.height))
        frontView?.frame = hierarchycalFrameAdjustment(frame)
    }
// MARK: private

    func _layoutRearViews(forLocation xLocation: CGFloat) {
        var bounds: CGRect = self.bounds
        var rearRevealWidth: CGFloat = _c.rearViewRevealWidth
        if rearRevealWidth < 0 {
            rearRevealWidth = bounds.size.width + _c.rearViewRevealWidth
        }
        var rearXLocation: CGFloat = scaledValue(xLocation, -_c.rearViewRevealDisplacement, 0, 0, rearRevealWidth)
        var rearWidth: CGFloat = rearRevealWidth + _c.rearViewRevealOverdraw
        rearView?.frame = CGRect(x: rearXLocation, y: CGFloat(0.0), width: rearWidth, height: CGFloat(bounds.size.height))
        var rightRevealWidth: CGFloat = _c.rightViewRevealWidth
        if rightRevealWidth < 0 {
            rightRevealWidth = bounds.size.width + _c.rightViewRevealWidth
        }
        var rightXLocation: CGFloat = scaledValue(xLocation, 0, _c.rightViewRevealDisplacement, -rightRevealWidth, 0)
        var rightWidth: CGFloat = rightRevealWidth + _c.rightViewRevealOverdraw
        rightView?.frame = CGRect(x: CGFloat(bounds.size.width - rightWidth + rightXLocation), y: CGFloat(0.0), width: rightWidth, height: CGFloat(bounds.size.height))
    }

    func _prepare(forNewPosition newPosition: FrontViewPosition) {
        if rearView == nil || rightView == nil {
            return
        }
        var symetry: Int = newPosition < .left ? -1 : 1
        var subViews: [Any] = subviews
        var rearIndex: Int = (subViews as NSArray).indexOfObjectIdentical(to: rearView)
        var rightIndex: Int = (subViews as NSArray).indexOfObjectIdentical(to: rightView)
        if (symetry < 0 && rightIndex < rearIndex) || (symetry > 0 && rearIndex < rightIndex) {
            exchangeSubview(at: rightIndex, withSubviewat: rearIndex)
        }
    }

    func _adjustedDragLocation(forLocation x: CGFloat) -> CGFloat {
        var result: CGFloat
        var revealWidth: CGFloat
        var revealOverdraw: CGFloat
        var bounceBack: Bool
        var stableDrag: Bool
        var position: FrontViewPosition = _c.frontViewPosition
        var symetry: Int = x < 0 ? -1 : 1
        _c._getRevealWidth(revealWidth, revealOverDraw: revealOverdraw, forSymetry: symetry)
        _c._getBounceBack(bounceBack, pStableDrag: stableDrag, forSymetry: symetry)
        var stableTrack: Bool = !bounceBack || stableDrag || position == .rightMost || position == .leftSideMost
        if stableTrack {
            revealWidth += revealOverdraw
            revealOverdraw = 0.0
        }
        x = x * symetry
        if x <= revealWidth {
            result = x
        }
        else if x <= revealWidth + 2 * revealOverdraw {
            result = revealWidth + (x - revealWidth) / 2
        }
        else {
            result = revealWidth + revealOverdraw
        }

        // keep at the rightMost location.
        return result * symetry
    }
}
// MARK: - SWRevealViewController Class

// MARK: - UIViewController(SWRevealViewController) Category

// MARK: - SWRevealViewControllerSegue Class