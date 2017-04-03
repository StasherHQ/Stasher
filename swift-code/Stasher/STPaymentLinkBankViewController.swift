//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STPaymentLinkBankViewController.swift
//  Stasher
//
//  Created by Bhushan on 03/06/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STPaymentLinkBankViewController: UIViewController, NSURLConnectionDelegate {
    var receivedData: Data?

    @IBOutlet var buttonLinkAccount: UIButton!
    @IBOutlet var textFieldBankName: UITextField!
    @IBOutlet var textFieldUsername: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    var activityIndicatorView: STActivityIndicatorView?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
// MARK: ----- Actions

    func addActivityIndicatorView() {
        if activityIndicatorView != nil {
            activityIndicatorView = nil
        }
        activityIndicatorView = STActivityIndicatorView(defaultSizeandSuperView: view)
        activityIndicatorView?.startAnimation()
    }

    func removeActivityIndicatorView() {
        if activityIndicatorView != nil {
            activityIndicatorView?.stopAnimation()
            activityIndicatorView?.removeFromSuperview()
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func buttonLinkAccountPressed(_ sender: Any) {
        addActivityIndicatorView()
            // NSString *jsonRequest = [[[[NSString stringWithFormat:@"%@", requestHeadersDict] stringByReplacingOccurrencesOfString:@"=" withString:@":"] stringByReplacingOccurrencesOfString:@";" withString:@","] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            //NSString *jsonRequest = [NSString stringWithFormat:@"{\"JsonRequest\":{\"api_key\": \"%@\",\"api_pass\": \"%@\",\"bank_name\": \"%@\",\"user_name\": \"%@\",\"user_pass\": \"%@\"}}",KNOXAPIKEY,KNOXAPIPASSWORD,@"CHASUS33",self.textFieldUsername.text,self.textFieldPassword.text];
        var jsonRequest: String = "{\"api_key\":\"\(KNOXAPIKEY)\",\"api_pass\":\"\(KNOXAPIPASSWORD)\",\"swift_code\":\"\("CHASUS")\",\"user_name\":\"\(textFieldUsername.text)\",\"user_pass\":\"\(textFieldPassword.text)\"}"
        print("JsonRequest to Knox \(jsonRequest)")
        var url = URL(string: KNOX_LINK_BANK_URL)
        var request = NSMutableURLRequest(url: url!, cachePolicy: NSURLRequestUseProtocolCachePolicy, timeoutInterval: 60.0)
        var requestData: Data? = jsonRequest.data(using: String.Encoding.utf8)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(UInt(requestData?.length))", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = requestData
        var connection = NSURLConnection(request: request, delegate: self)
        if connection {
            receivedData = Data.data
        }
    }

    func connection(_ connection: NSURLConnection, didReceiveResponse response: URLResponse) {
        receivedData?.length = 0
    }

    func connection(_ connection: NSURLConnection, didReceiveData data: Data) {
        receivedData?.append(data)
    }

    func connection(_ connection: NSURLConnection, didFailWithError error: Error?) {
    }

    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        removeActivityIndicatorView()
        var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: receivedData, options: kNilOptions)
        if responseDictionary != nil {
            print("responseDictionary \(responseDictionary)")
        }
    }
}