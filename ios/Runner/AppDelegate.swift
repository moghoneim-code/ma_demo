import UIKit
import Flutter
import SwiftUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let bottomSheetChannel = FlutterMethodChannel(name: "com.example.ma_demo/bottomSheet", binaryMessenger: controller.binaryMessenger)
        
        bottomSheetChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard call.method == "showFlutterBottomSheet" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            self?.showBottomSheet()
            result(nil)
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
//    private func showBottomSheet() {
//        guard let flutterViewController = window?.rootViewController as? FlutterViewController else {
//            return
//        }
//
//        let hostingController = UIHostingController(rootView: ContentView())
//        hostingController.modalPresentationStyle = .overCurrentContext
//        hostingController.modalTransitionStyle = .crossDissolve
//
//        flutterViewController.present(hostingController, animated: true, completion: nil)
//    }
    
    
    private func showBottomSheet() {
        guard let flutterViewController = window?.rootViewController as? FlutterViewController else {
            return
        }
        
        // Create a hosting controller with the ContentView
        let hostingController = UIHostingController(rootView: ContentView())
        
        // Set the presentation style to be a custom one
        hostingController.modalPresentationStyle = .custom
        
        // Set the transitioning delegate to manage the presentation animation
        hostingController.transitioningDelegate = self
        
        // Present the hosting controller
        flutterViewController.present(hostingController, animated: true, completion: nil)
    }
}

struct ContentView2: View {
    var body: some View {
        VStack {
            Text("This is a SwiftUI Bottom Sheet")
                .padding()
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
}
extension AppDelegate: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

//class BottomSheetPresentationController: UIPresentationController {
//    override var frameOfPresentedViewInContainerView: CGRect {
//        guard let containerView = containerView else {
//            return CGRect.zero
//        }
//
//        // Set the size and position of the presented view (bottom sheet)
//        let height: CGFloat = 300  // Adjust the height as needed
//        return CGRect(x: 0, y: containerView.frame.height - height, width: containerView.frame.width, height: height)
//    }
//}
class BottomSheetPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }
        
        let height: CGFloat = 360
        return CGRect(x: 0, y: containerView.frame.height - height, width: containerView.frame.width, height: height)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        // Add a gesture recognizer to dismiss the bottom sheet when tapped outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        containerView?.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: containerView)
        if !presentedView!.frame.contains(location) {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
