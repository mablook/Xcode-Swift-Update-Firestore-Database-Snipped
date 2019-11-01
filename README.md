# Xcode-Swift-Update-Firestore-Database-Snipped
# Created by Marcelo Bossle
Snipped to save information in firestore using java. It should be implemented in private or public functions depending on the need.

I need to save the information in Firestore but without creating a listener, access is restricted traffic is not important in this case.
Whenever the token changes, I need to save it for future access.
A snipped should be improved, but works very well for the concept.

see my idea for Java https://github.com/mablook/Android-Java-Update-Firestore-Database-Snipped


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
      
