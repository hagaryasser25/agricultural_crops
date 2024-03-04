import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signupPage';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String dropdownValue = "تاجر";
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/register.png'),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Container(
                padding: EdgeInsets.only(right: 40.w),
                child: const Text(
                  "انشاء حساب",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      right: 35.w,
                      left: 35.w,
                      top: MediaQuery.of(context).size.height * 0.21),
                  child: Column(children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "الاسم",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "البريد الألكترونى",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: "رقم الهاتف",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),

                        // Step 3.
                        value: dropdownValue,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 119, 118, 118)),
                        ),

                        // Step 4.
                        items: ["تاجر", "مستخدم"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 118, 118)),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 75.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "انشاء حساب",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  var name = nameController.text.trim();
                                  var email = emailController.text.trim();
                                  var password = passwordController.text.trim();
                                  var phone = phoneController.text.trim();
                                  String role = dropdownValue;

                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty ||
                                      phone.isEmpty) {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("please fill all fields"))
                                        .show(context);

                                    return;
                                  }

                                  if (password.length < 6) {
                                    // show error toast
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description: Text(
                                                "Weak Password, at least 6 characters are required"))
                                        .show(context);

                                    return;
                                  }

                                  ProgressDialog progressDialog =
                                      ProgressDialog(context,
                                          title: Text('Signing Up'),
                                          message: Text('Please Wait'));
                                  progressDialog.show();

                                  try {
                                    FirebaseAuth auth = FirebaseAuth.instance;

                                    UserCredential userCredential = await auth
                                        .createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );

                                    User? user = userCredential.user;
                                    user!.updateDisplayName(role);

                                    if (userCredential.user != null) {
                                      DatabaseReference userRef =
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('users');

                                      String uid = userCredential.user!.uid;
                                      int dt =
                                          DateTime.now().millisecondsSinceEpoch;

                                      await userRef.child(uid).set({
                                        'name': name,
                                        'email': email,
                                        'password': password,
                                        'uid': uid,
                                        'dt': dt,
                                        'phoneNumber': phone,
                                      });

                                      Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null;
                                    } else {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text("failed"))
                                          .show(context);
                                    }
                                    progressDialog.dismiss();
                                  } on FirebaseAuthException catch (e) {
                                    progressDialog.dismiss();
                                    if (e.code == 'email-already-in-use') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "email is already exist"))
                                          .show(context);
                                    } else if (e.code == 'weak-password') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("password is weak"))
                                          .show(context);
                                    }
                                  } catch (e) {
                                    progressDialog.dismiss();
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("something went wrong"))
                                        .show(context);
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
