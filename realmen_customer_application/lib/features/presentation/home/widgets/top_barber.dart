// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, avoid_unnecessary_containers, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/features/data/models/account_model.dart';

class barberTop extends StatelessWidget {
  Function callback;
  List<AccountModel> stylistList;
  barberTop(this.callback, {super.key, required this.stylistList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: const Text(
            "Top Stylist",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 290,
          child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: stylistList.length > 5 ? 5 : stylistList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.5,
                childAspectRatio: 310 / 240,
              ),
              itemBuilder: (context, index) {
                return Container(
                  // height: 200,
                  // width: MediaQuery.of(context).size.width / 0.4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xA6444444),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      stylistList[index].thumbnail.toString(),
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/stylist.png",
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 26,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            stylistList[index]
                                                .nickName
                                                .toString(),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 66,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text.rich(
                              //         TextSpan(
                              //           style: TextStyle(
                              //             fontSize: 17,
                              //             color: Colors.black.withOpacity(0.6),
                              //           ),
                              //           children: const [
                              //             WidgetSpan(
                              //               child: Icon(
                              //                 Icons.star,
                              //                 color: Color(0xff323232),
                              //               ),
                              //             ),
                              //             WidgetSpan(
                              //               child: SizedBox(width: 4),
                              //             ),
                              //             TextSpan(
                              //               text: '5.0',
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       const SizedBox(width: 5),
                              //       Row(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           const Icon(
                              //             Icons.location_on,
                              //             color: Color(0xff323232),
                              //           ),
                              //           const SizedBox(width: 4),
                              //           SizedBox(
                              //             width: 229 - 63,
                              //             child: Text(
                              //               "Thợ Cắt Tóc",
                              //               maxLines: 2,
                              //               style: TextStyle(
                              //                 fontSize: 17,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 color: Colors.grey.shade800,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
