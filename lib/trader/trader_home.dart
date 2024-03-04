import 'package:agricultural_crops/auth/login_page.dart';
import 'package:agricultural_crops/models/user_model.dart';
import 'package:agricultural_crops/trader/trader_crops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class TraderHome extends StatefulWidget {
  static const routeName = '/traderHome';
  const TraderHome({super.key});

  @override
  State<TraderHome> createState() => _TraderHomeState();
}

class _TraderHomeState extends State<TraderHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print(currentUser.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'الصفحة الرئيسية',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: HexColor('#6fa8dc'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكيد'),
                          content: Text('هل انت متأكد من تسجيل الخروج'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
                              },
                              child: Text('نعم'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('لا'),
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Image.asset('assets/images/trader.jpg'),
              Text('الخدمات المتاحة',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          //  Navigator.pushNamed(context, UserDonators.routeName);
                        },
                        child: card('#6fa8dc', "قائمة الحجوزات")),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TraderCrops(
                              traderName: '${currentUser.fullName}',
                            );
                          }));
                        },
                        child: card('#6fa8dc', "أضافة محاصيل")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(String color, String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      color: HexColor(color),
      child: SizedBox(
        width: 177.w,
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 20.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
