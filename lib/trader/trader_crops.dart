import 'package:agricultural_crops/models/crops_model.dart';
import 'package:agricultural_crops/trader/add_crops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class TraderCrops extends StatefulWidget {
  String traderName;
  static const routeName = '/traderCrops';
  TraderCrops({required this.traderName});

  @override
  State<TraderCrops> createState() => _TraderCropsState();
}

class _TraderCropsState extends State<TraderCrops> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Crops> cropsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCrops();
  }

  fetchCrops() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base =
        await database.reference().child("crops").child('${widget.traderName}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Crops p = Crops.fromJson(event.snapshot.value);
      cropsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      if (mounted) {
        setState(() {});
      }
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
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: HexColor('#6fa8dc'),
              title: TextButton.icon(
                // Your icon here
                label: Text(
                  "أضافة محاصيل",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                icon: Align(
                    child: Icon(
                  Icons.add,
                  color: Colors.white,
                )), // Your text here
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddCrops(
                      traderName: '${widget.traderName}',
                    );
                  }));
                },
              ),
            ),
            body: ListView.builder(
                itemCount: cropsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Container(
                                  width: 130.w,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Image.network(
                                              '${cropsList[index].imageUrl.toString()}',height: 200.h,)),
                                      Text(
                                        '${cropsList[index].name.toString()}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'سعر المنتج : ${cropsList[index].price.toString()}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'الكمية المتاحة : ${cropsList[index].amount.toString()} كيلو',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${cropsList[index].description.toString()}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('feeds')
                                              .child('${widget.traderName}')
                                              .child('${cropsList[index].id}')
                                              .remove();
                                        },
                                        child: Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 122, 122, 122)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  );
                }),
          ),
        ));
  }
}
