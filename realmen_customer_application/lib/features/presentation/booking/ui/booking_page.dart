import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch.dart';

import 'package:sizer/sizer.dart';

class BookingPage extends StatefulWidget {
  final Function callback;

  const BookingPage(this.callback, {super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
  static const String BookingPageRoute = "/booking-Page";
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  final BookingBloc bookingBloc = BookingBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bookingBloc,
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 15,
                bottom: 27,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, left: 0),
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(left: 7),
                          child: Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: IconButton(
                                    alignment: Alignment.centerLeft,
                                    color: Colors.black,
                                    iconSize: 22,
                                    icon: const Icon(Icons.keyboard_arrow_left),
                                    onPressed: () {
                                      widget.callback(0);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "đặt lịch giữ chỗ".toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                                height: 180,
                                decoration:
                                    const BoxDecoration(color: Colors.black)),
                            Image.asset(
                              "assets/images/Logo-White-NoBG-O-15.png",
                              width: 360,
                              height: 180,
                            ),
                            SizedBox(
                              height: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Chào mừng bạn đến với REALMEN",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      "Bạn có hai cách để đặt lịch cắt tóc:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      "• Chọn Barber:  Đặt lịch tại barber shop gần bạn nhất.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      "• Chọn Stylist:  Đặt lịch với stylist mà bạn  yêu thích.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                labelColor: Colors.black,
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                                indicator: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'Barber',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Stylist',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                // color: Colors.amber,
                                width: 400,
                                height: 500,
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    BranchOptionBooking(
                                        bloc: bookingBloc, widget.callback),
                                    // StylistOptionBooking(widget.callback),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
