import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_hub_challenge_box/Admin/Pages/Solved_queries_page.dart';
import 'package:technical_hub_challenge_box/Admin/Pages/Unsolved_query.dart';
import 'package:technical_hub_challenge_box/Admin/Pages/pendingQuery.dart';
import 'package:technical_hub_challenge_box/Auth/Auth_Services.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:technical_hub_challenge_box/complaint_display.dart';

class Admin_query_page extends StatefulWidget {
  const Admin_query_page({Key? key}) : super(key: key);

  @override
  State<Admin_query_page> createState() => _TabBarPage1State();
}

class _TabBarPage1State extends State<Admin_query_page>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(11, 72, 73, 1),
              Color.fromRGBO(6, 37, 37, 1)
            ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 35,
                    // color: Color.fromRGBO(6, 37, 37, 1),
                    width: wi / 1.25,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(6, 37, 37, 0.3),
                        border: Border.all(color: Colors.green),
                        //  gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.topRight,colors:
                        // [ Color.fromRGBO(6, 37, 37, 1),
                        //      Color.fromRGBO(6, 37, 37, 1)]),

                        borderRadius: BorderRadius.circular(20)),

                    child: TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Color.fromRGBO(4, 39, 40, 1),
                        // indicatorColor: Colors.white54,
                        controller: tabController,
                        indicatorWeight: 3,
                        dividerColor: Colors.white54,

                        // dividerHeight: 0.001,
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelStyle: TextStyle(color: Colors.white),
                        //indicatorPadding: EdgeInsets.symmetric(horizontal: 2,vertical:2) ,

                        indicator: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF539463),
                                  Color(0xFF639F71),
                                  Color(0xFF377546),
                                  Color(0xFF74A580)
                                ]),
                            borderRadius: BorderRadius.circular(20)),
                        tabs: [
                          Tab(
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Solved',
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Unsolved',
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                  ),
                  // SizedBox(
                  //   height: hi / 20,
                  // ),
                  Expanded(
                      child: TabBarView(
                    controller: tabController,
                    children: [
                      pendingQuery(),
                      Solvedqueries(),
                      Unsolvedquries(),
                    ],
                  )),
                  SizedBox(
                    height: hi / 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
