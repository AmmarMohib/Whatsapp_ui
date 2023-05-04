import 'package:country_picker/country_picker.dart';
import 'package:whatsap_ui/commons/colors.dart';
import 'package:whatsap_ui/getInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  var selCountryCode = "+92";
  bool otpVisibility = false;

  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Enter your phone number",
            style: TextStyle(fontSize: 20, color: maincolor),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//             ElevatedButton(onPressed: () {
// showCountryPicker(
//   context: context,
//   showPhoneCode: true, // optional. Shows phone code before the country name.
//   // countryListTheme: materialco,
//   onSelect: (Country country) {
//     print('Select country: ${country.displayName}');
//   },
// );
//             }, child: Text("data")),
              Text(
                'WhatsappClone by Ammar will need to verify \n your account.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  // style: ,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: maincolor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: maincolor)),
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            iconColor: maincolor,
                          ),
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              // countryListTheme: materialco,
                              onSelect: (Country country) {
                                print('Select country: ${country.displayName}');
                                setState(() {
                                  selCountryCode = "+" + country.phoneCode;
                                });
                              },
                            );
                          },
                          child: SizedBox(
                            height: 20,
                            width: 57,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selCountryCode,
                                  style: TextStyle(color: maincolor),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          )),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Visibility(
                child: TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    ),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
                visible: otpVisibility,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: maincolor,
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(
                  otpVisibility == false ? "Verify" : "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+92" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        print(e.message);
        Fluttertoast.showToast(msg: e.message.toString(),gravity: ToastGravity.CENTER);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
    Fluttertoast.showToast(
        msg: 'Wait for a while, so the app will send you verification code',
        fontSize: 20,
        backgroundColor: Colors.green);
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then(
      (value) {
        print("You are logged in successfully");
        Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    ).whenComplete(
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GetInfo()));
      },
    );
  }
}
