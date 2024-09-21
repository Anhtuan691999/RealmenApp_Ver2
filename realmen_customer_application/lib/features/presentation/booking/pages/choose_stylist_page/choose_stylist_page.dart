// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_stylist_booking/choose_stylist_booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_stylist_page/bloc/choose_stylist_page_bloc.dart';

class ChooseStylistPage extends StatefulWidget {
  final ChooseStylistBookingBloc bloc;

  const ChooseStylistPage({
    super.key,
    required this.bloc,
  });

  @override
  State<ChooseStylistPage> createState() => _ChooseStylistPageState();
  static const String ChooseStylistPageRoute = "/choose-stylist-screen";
}

class _ChooseStylistPageState extends State<ChooseStylistPage> {
  final ChooseStylistPageBloc chooseStylistPageBloc = ChooseStylistPageBloc();

  @override
  void initState() {
    super.initState();
    chooseStylistPageBloc.add(CSPInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    List<AccountModel> stylists = [];
    List<String> urlStylistList = [
      "1.jpg",
      "2.jpg",
      "3.jpg",
      "4.jpg",
    ];
    List<String> urlBranchList = [
      "barber1.jpg",
      "barber2.jpg",
      "barber3.jpg",
    ];

    return BlocConsumer<ChooseStylistPageBloc, ChooseStylistPageState>(
      bloc: chooseStylistPageBloc,
      listener: (context, state) {
        switch (state.runtimeType) {
          case CSPLoadedState:
            stylists = (state as CSPLoadedState).stylistList;
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                        height: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: ListView(
                          controller: _scrollController,
                          children: <Widget>[
                            Container(
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
                                        icon: const Icon(
                                            Icons.keyboard_arrow_left),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "chọn stylist".toUpperCase(),
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
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Tìm kiếm stylist",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(10.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         height: 40,
                            //         width: 190,
                            //         padding: const EdgeInsets.only(left: 5),
                            //         decoration: BoxDecoration(
                            //           border: Border.all(
                            //             color: Colors.black,
                            //           ),
                            //           borderRadius: BorderRadius.circular(4.0),
                            //         ),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton2<String>(
                            //             isExpanded: true,
                            //             alignment: Alignment.centerLeft,
                            //             value: _selectedOption,
                            //             onChanged: (String? newValue) {
                            //               setState(() {
                            //                 _selectedOption = newValue!;
                            //               });
                            //             },
                            //             items: <String>[
                            //               'Stylist theo lịch sử cắt',
                            //               'Stylist gần đây nhất',
                            //               'Stylist được cắt nhiều nhất',
                            //               'Tất cả stylist',
                            //             ].map<DropdownMenuItem<String>>(
                            //                 (String value) {
                            //               return DropdownMenuItem<String>(
                            //                 value: value,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(8.0),
                            //                   child: Text(
                            //                     value,
                            //                     style: const TextStyle(
                            //                         fontSize: 17,
                            //                         color: Colors.black,
                            //                         fontWeight: FontWeight.w400),
                            //                   ),
                            //                 ),
                            //               );
                            //             }).toList(),
                            //             dropdownStyleData: DropdownStyleData(
                            //               maxHeight: 160,
                            //               width: 170,
                            //               // padding: EdgeInsets.only(right: 5),
                            //               decoration: BoxDecoration(
                            //                 // borderRadius: BorderRadius.circular(14),
                            //                 color: Colors.grey.shade200,
                            //               ),
                            //               offset: const Offset(-5, -2),
                            //               scrollbarTheme: ScrollbarThemeData(
                            //                 // radius: const Radius.circular(40),
                            //                 // thickness: MaterialStateProperty.all(6),
                            //                 thumbVisibility:
                            //                     MaterialStateProperty.all(true),
                            //               ),
                            //             ),
                            //             menuItemStyleData: const MenuItemStyleData(
                            //               height: 40,
                            //               padding:
                            //                   EdgeInsets.only(left: 10, right: 14),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            // Column(
                            //     crossAxisAlignment:
                            //         CrossAxisAlignment.center,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         margin: const EdgeInsets.only(top: 30),
                            //         height: 50,
                            //         width: 50,
                            //         child:
                            //             const CircularProgressIndicator(),
                            //       )
                            //     ],
                            //   )
                            buildStylistList(stylists),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  Widget buildStylistList(List<AccountModel> stylistDataList) {
    return Column(
      children: stylistDataList.map((AccountModel stylistData) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // anh avatar
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: stylistData.thumbnail!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/s1.jpg'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // tên stylist
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Stylist: ",
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${stylistData.firstName.toString()} ${stylistData.lastName.toString()}",
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //  rate
                          // stylistData.staff!.averageRating != null
                          //     ? Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           const SizedBox(
                          //             height: 5,
                          //           ),
                          //           RichText(
                          //             text: TextSpan(
                          //               children: [
                          //                 TextSpan(
                          //                   text: "Đánh giá: ",
                          //                   style: GoogleFonts.quicksand(
                          //                     textStyle: const TextStyle(
                          //                         fontSize: 17,
                          //                         color: Colors.black,
                          //                         fontWeight: FontWeight.w400),
                          //                   ),
                          //                 ),
                          //                 TextSpan(
                          //                   text: stylistData
                          //                       .staff!.averageRating!
                          //                       .toString(),
                          //                   style: GoogleFonts.quicksand(
                          //                     textStyle: const TextStyle(
                          //                         fontSize: 18,
                          //                         color: Colors.black,
                          //                         fontWeight: FontWeight.w500),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                stylistData.branch != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Barber:  ",
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: stylistData.branch!.branchName
                                                .toString(),
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Địa chỉ:  ",
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: stylistData
                                                .branch!.branchAddress
                                                .toString(),
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Các phần khác của Widget Column
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    : Container(),
                // _selectedOption != 'Tất cả stylist'
                //     ? Column(
                //         children: [
                //           const Divider(
                //             color: Colors.black,
                //             thickness: 1.0,
                //             height: 16.0,
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Row(
                //             children: [
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //                     const Text(
                //                       "Lịch Sử Cắt",
                //                       style: TextStyle(
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     const SizedBox(height: 10),
                //                     RichText(
                //                       maxLines: 3,
                //                       overflow: TextOverflow.ellipsis,
                //                       text: TextSpan(
                //                         children: [
                //                           TextSpan(
                //                             text: "Chi nhánh:  ",
                //                             style: GoogleFonts.quicksand(
                //                               textStyle: const TextStyle(
                //                                   fontSize: 17,
                //                                   color: Colors.black,
                //                                   fontWeight: FontWeight.w400),
                //                             ),
                //                           ),
                //                           TextSpan(
                //                             text: stylistData['branch'],

                //                             //  "Cắt",
                //                             // utf8.decode(_selectedStylist!.name
                //                             //     .toString()
                //                             //     .runes
                //                             //     .toList()),
                //                             style: GoogleFonts.quicksand(
                //                               textStyle: const TextStyle(
                //                                   fontSize: 18,
                //                                   color: Colors.black,
                //                                   fontWeight: FontWeight.w400),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                     const SizedBox(height: 5),
                //                     // Các phần khác của Widget Column
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(height: 5),
                //           stylistData['services'] != null
                //               ? Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     const Text(
                //                       "Dịch Vụ:",
                //                       style: TextStyle(
                //                           fontSize: 17,
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w400),
                //                     ),
                //                     const SizedBox(width: 8.0),
                //                     ...List.generate(
                //                       stylistData['services'].length,
                //                       (index) => Container(
                //                         margin: const EdgeInsets.only(
                //                             right:
                //                                 8.0), // Khoảng cách giữa các border
                //                         decoration: BoxDecoration(
                //                           border: Border.all(
                //                             color: Color(0xff888888),
                //                             width:
                //                                 1.0, // Độ rộng của đường viền
                //                           ),
                //                           borderRadius: const BorderRadius.all(
                //                               Radius.circular(4.0)),
                //                         ),
                //                         padding: const EdgeInsets.symmetric(
                //                           horizontal: 6.0,
                //                           vertical: 3.0,
                //                         ),
                //                         child: Text(
                //                             stylistData['services'][index]),
                //                       ),
                //                     ).toList(),
                //                   ],
                //                 )
                //               : Container(),
                //           const SizedBox(height: 10),
                //         ],
                //       )
                //     : Container(),
                // stylistData['images'] != null
                //     ? SizedBox(
                //         height: 120,
                //         child: ListView(
                //           scrollDirection: Axis.horizontal,
                //           children: [
                //             ...List.generate(
                //                 stylistData['images'].length,
                //                 (index) => Row(
                //                       children: [
                //                         Container(
                //                           width: 105,
                //                           height: 75,
                //                           margin: const EdgeInsets.only(
                //                               left: 0, right: 5),
                //                           child: Image.asset(
                //                             stylistData['images'][index],
                //                             width: 105.0,
                //                             height: 105.0,
                //                             fit: BoxFit.cover,
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //           ],
                //         ),
                //       )
                //     : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        onPressed: () {
                          // btnChoose(selectedProvider, stylistData);
                          widget.bloc.add(CSBSelectedStylistEvent(
                              selectedStylist: stylistData));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          side: const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Chọn",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 4,
                      child: Container(
                        // width: 100,

                        child: ElevatedButton(
                          onPressed: () {
                            // Define the action for the "Xem thêm" button
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Xem thêm",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Logic

  // void checkLoadMore() async {
  //   current = currentResult;
  //   current = current + 1;
  //   if (totalPages == 0) {
  //     await getStaff(current);
  //   } else {
  //     if (current <= totalPages) {
  //       await getStaff(current);
  //     }
  //   }
  // }

  // // v1/auth/accounts
  // Future<void> getStaff(int current) async {
  //   if (!_isDisposed && mounted) {
  //     try {
  //       AccountService accountService = AccountService();

  //       final result =
  //           await accountService.getStaff(3, current, null, false, null);
  //       if (result['statusCode'] == 200) {
  //         stylists.addAll(result['data'] as List<AccountInfoModel>);
  //         massuers = List<AccountInfoModel>.from(stylists);
  //         current = result['current'];
  //         totalPages = result['totalPages'];
  //         stylists
  //             .removeWhere((staff) => staff.staff!.professional == 'MASSEUR');
  //         massuers.removeWhere(
  //             (massuer) => massuer.staff!.professional == 'STYLIST');
  //         for (var staff in stylists) {
  //           try {
  //             var reference = storage.ref('${staff.thumbnailUrl}');
  //             staff.thumbnailUrl = await reference.getDownloadURL();
  //           } catch (e) {
  //             final random = Random();
  //             var randomUrl = random.nextInt(urlStylistList.length);
  //             var reference =
  //                 storage.ref('stylist/${urlStylistList[randomUrl]}');
  //             staff.thumbnailUrl = await reference.getDownloadURL();
  //           }
  //           try {
  //             var reference = storage.ref('${staff.branch!.thumbnailUrl}');
  //             staff.branch!.thumbnailUrl = await reference.getDownloadURL();
  //           } catch (e) {
  //             final random = Random();
  //             var randomUrl = random.nextInt(urlBranchList.length);
  //             var reference = storage.ref('branch/${urlBranchList[randomUrl]}');
  //             staff.branch!.thumbnailUrl = await reference.getDownloadURL();
  //           }
  //         }
  //         if (!_isDisposed && mounted) {
  //           setState(() {
  //             stylists;
  //             massuers;
  //             isLoading = false;
  //           });
  //         }
  //         current++;
  //         if (stylists.length < 3 && current <= totalPages) {
  //           await getStaff(current);
  //         }
  //       } else {
  //         _errorMessage(result['message']);
  //         print(result);
  //       }
  //     } on Exception catch (e) {
  //       _errorMessage("Vui lòng thử lại");
  //       print(e.toString());
  //       if (!_isDisposed && mounted) {
  //         setState(() {
  //           stylists;
  //           massuers;
  //           isLoading = false;
  //         });
  //       }
  //     }
  //   }
  //   isLoading = false;
  // }

  // void _errorMessage(String? message) {
  //   try {
  //     ShowSnackBar.ErrorSnackBar(context, message!);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void btnChoose(selectedProvider, AccountInfoModel stylistData) {
  //   massuers = massuers
  //       .where((massuer) //
  //           =>
  //           massuer.staff!.bookingList!.any((booking) //
  //               =>
  //               stylistData.staff!.bookingList!.any((stylist) //
  //                   =>
  //                   stylist.bookingId == booking.bookingId))) //
  //       .toList(); //

  //   //
  //   //
  //   for (var massuer in massuers) {
  //     massuer.staff!.bookingList = massuer.staff!.bookingList!
  //         .where((mbooking) //
  //             =>
  //             stylistData.staff!.bookingList!.any((sbooking) //
  //                 =>
  //                 sbooking.bookingId == mbooking.bookingId))
  //         .toList();
  //   }

  //   massuers;

  //   selectedProvider.updateSelectedStylist(stylistData);
  //   Navigator.pop(context, stylistData);
  // }
}
