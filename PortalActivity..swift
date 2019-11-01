//
//  Created by Marcelo Bossle on 28/08/18.
//  Copyright © 2018 Marcelo Bossle. All rights reserved.
//
// Problem: I just need the information to be saved "without creating a listener".
// My database should be open for next writes.
// Solution:

import ...
 

class ViewPortal: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
   
    }

    let look_name = UserDefaults.standard.object(forKey: "look_name")
    let look_token = UserDefaults.standard.object(forKey: "look_token")
    let look_userID = UserDefaults.standard.object(forKey: "look_userID")
    let look_email = UserDefaults.standard.object(forKey: "look_email")
    let look_link = UserDefaults.standard.object(forKey: "look_link")
    
    // more let .... UserDefaults var

    var msgID = String()
    
    @IBOutlet var msgWeb: WKWebView!

    override func viewDidLoad() {
    super.viewDidLoad()
        
        if(url_target == nil){
            url_target = ""
        }

        self.msgWeb.uiDelegate = self
        self.msgWeb.navigationDelegate = self
        msgWeb.configuration.userContentController.add(self, name: "jsHandler")
        msgWeb.configuration.preferences.javaScriptEnabled = true
                 

        let myUrl = URL(string:"http://test.istiaonline.com/StockspotsTest/fStockspots.html?p_look_name=\(look_name ?? (Any).self)")
                 let myRequest = URLRequest(url: myUrl!)
                 self.msgWeb.load(myRequest)
       

        UserDefaults.standard.set("", forKey: "url_target")
        UserDefaults.standard.synchronize()
        

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(msgID)
        print("voltei aqui agora")
        UserDefaults.standard.set("", forKey: "url_target")
        UserDefaults.standard.synchronize()
        self.msgWeb.reloadFromOrigin()

    }
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
       UserDefaults.standard.set("", forKey: "url_target")
              UserDefaults.standard.synchronize()
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UserDefaults.standard.set("", forKey: "url_target")
        UserDefaults.standard.synchronize()
        
        // Check if user exist and create partial or total record

        let userID = Auth.auth().currentUser?.uid
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    
                    let now = Date()
                    let formatter = DateFormatter()
                    formatter.timeZone = TimeZone.current
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateString = formatter.string(from: now)

                    let userEmail = Auth.auth().currentUser?.email

                    guard let token = Messaging.messaging().fcmToken else { return }
                    

                                    ref.child("user").child(userID!).updateChildValues([
                                        "username": userEmail!,
                                        "useremail" : userEmail!,
                                        "create" : dateString,
                                        "emailverify": "true",
                                        "userpass": "_look_"

                                    ])

                    let iosId = UIDevice.current.identifierForVendor?.uuidString
                    
                    let modelName = UIDevice.current.localizedModel

                       ref.child("user").child(userID!).child("deviceGroup").child(iosId!).updateChildValues([
                                "date": dateString,
                                "iosId" : iosId!,
                                "brand" : "Apple",
                                "manufacturer" : dateString,
                                "model": modelName,
                                "token": token

                            ])
                          }
      

}
