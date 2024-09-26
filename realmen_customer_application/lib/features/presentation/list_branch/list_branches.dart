// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print, use_build_context_synchronously, prefer_conditional_assignment

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/presentation/home/bloc/home_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/home/ui/home_page.dart';
import 'package:realmen_customer_application/features/presentation/list_branch/bloc/list_branch_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/landing_page.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ListBranchesScreen extends StatefulWidget {
  final HomePageBloc bloc;
  ListBranchesScreen({super.key, required this.bloc});
  var province = Get.arguments;

  @override
  State<ListBranchesScreen> createState() => _ListBranchesScreenState();
  static const String ListBranchesScreenRoute = "/list-branches-screen";
}

class _ListBranchesScreenState extends State<ListBranchesScreen> {
  final ListBranchPageBloc listBranchPageBloc = ListBranchPageBloc();
  FocusNode focusNode = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final ScrollController _scrollController = ScrollController();

  String displayStringForOption(BranchDataModel branch) =>
      "${branch.branchName} - ${branch.branchAddress}";

  @override
  void initState() {
    super.initState();
    listBranchPageBloc
        .add(ListBranchPageInitialEvent(province: widget.province));
  }

  List<BranchDataModel> branchsList = [];
  List<BranchDataModel> branchListForAutocomplete = [];
  String cityController = "TP/Tỉnh";
  List<String> cities = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBranchPageBloc, ListBranchPageState>(
      bloc: listBranchPageBloc,
      builder: (context, state) {
        LBLoadedBookingBranchListState? currentState;
        FutureOr<Iterable<BranchDataModel>> autocompleteBranchList =
            const Iterable.empty();

        if (state is LBLoadedBookingBranchListState) {
          currentState = state as LBLoadedBookingBranchListState;
          branchsList = currentState.branchList ?? [];
          branchListForAutocomplete =
              currentState.branchListForAutocomplete ?? [];
          cityController = currentState.cityController ?? "TP/Tỉnh";
          cities = currentState.cities ?? [];
          focusScopeNode.unfocus();
        }

        if (state is LBAutocompleteOnSelectedState) {
          focusScopeNode.unfocus();
          focusNode.unfocus();
        }
        if (state is LBSearchOnSubmitState) {
          focusScopeNode.unfocus();
          focusNode.unfocus();
        }
        if (state is LBAutocompleteOptionsBuilderState) {}

        return WillPopScope(
          onWillPop: () async {
            // Gửi sự kiện đến bookingBloc khi nút Back được nhấn
            Get.back();

            // Trả về false để chặn hành vi quay lại mặc định của hệ thống
            return false;
          },
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
                                            onPressed: () async {
                                              Get.back();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              "hệ thống chi nhánh"
                                                  .toUpperCase(),
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
                                        height: 160,
                                        decoration: const BoxDecoration(
                                            color: Colors.black)),
                                    Image.asset(
                                      "assets/images/Logo-White-NoBG-O-15.png",
                                      width: 360,
                                      height: 160,
                                    ),
                                    Container(
                                      height: 160,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "các barber CỦA REALMEN"
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Text(
                                            "Tận hưởng trải nghiệm cắt tóc nam đỉnh \ncao tại các chi nhánh của RealMen trải dài khắp \n Hà Nội, TP.HCM và các tỉnh lân cận!",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              height: 1.4,
                                            ),
                                            // textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // search autocomplete
                                SizedBox(
                                  // width: 80.w,
                                  // height: 50,
                                  child: FocusScope(
                                    node: focusScopeNode,
                                    child: Autocomplete<BranchDataModel>(
                                      displayStringForOption:
                                          displayStringForOption,
                                      // initialValue: null,
                                      optionsBuilder: (textEditingValue) async {
                                        // listBranchPageBloc.add(
                                        //     AutocompleteOptionsBuilderEvent(
                                        //         textEditingValue:
                                        //             textEditingValue));
                                        // if (state
                                        //         is! AutocompleteOnSelectedState ||
                                        //     state is! SearchOnSubmitEvent ||
                                        //     state
                                        //         is! LoadedBookingBranchListState) {
                                        //   focusNode.hasFocus;
                                        // }

                                        if (textEditingValue.text.isEmpty ||
                                            textEditingValue.text == '') {
                                          return const Iterable.empty();
                                        } else if (branchsList.isNotEmpty) {
                                          var optionsBuilderBranchList =
                                              branchListForAutocomplete.where(
                                                  (element) => removeDiacritics(
                                                          element.branchName!
                                                              .trim())
                                                      .toLowerCase()
                                                      .contains(removeDiacritics(
                                                              textEditingValue
                                                                  .text
                                                                  .split(
                                                                      ' - ')[0]
                                                                  .toString()
                                                                  .trim())
                                                          .toLowerCase()));
                                          return optionsBuilderBranchList;
                                        }

                                        return [];
                                      },
                                      onSelected: (address) {
                                        listBranchPageBloc.add(
                                            LBAutocompleteOnSelectedEvent(
                                                address: address));
                                        debugPrint(
                                            'You just selected $address');
                                      },
                                      fieldViewBuilder: (context, controller,
                                          focusNode, onEditingComplete) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextField(
                                            // controller: firstNameController,
                                            controller: controller,
                                            focusNode: focusNode,
                                            onEditingComplete:
                                                onEditingComplete,
                                            onSubmitted: (value) {
                                              listBranchPageBloc
                                                  .add(LBSearchOnSubmitEvent());
                                              focusNode.unfocus();
                                            },

                                            cursorColor: Colors.black,
                                            cursorWidth: 1,
                                            style: const TextStyle(
                                                height: 1.17,
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    controller.clear();
                                                  },
                                                  icon:
                                                      const Icon(Icons.clear)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffC4C4C4)),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffC4C4C4)),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      // top: 10,
                                                      // bottom: 20,
                                                      left: 15,
                                                      right: 15),
                                              hintText: "Tìm kiếm Barber",
                                              hintStyle: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffC4C4C4)),
                                            ),
                                          ),
                                        );
                                      },
                                      optionsViewBuilder: (BuildContext context,
                                          AutocompleteOnSelected<
                                                  BranchDataModel>
                                              onSelected,
                                          Iterable<BranchDataModel> options) {
                                        return Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Material(
                                            elevation: 4.0,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 200),
                                              child: SizedBox(
                                                width: 90.w,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final BranchDataModel
                                                        option = options
                                                            .elementAt(index);

                                                    return InkWell(
                                                      onTap: () {
                                                        onSelected(option);
                                                      },
                                                      child: Builder(builder:
                                                          (BuildContext
                                                              context) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Text(
                                                              displayStringForOption(
                                                                  option)),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                state.runtimeType ==
                                        LBLoadedBookingBranchListState
                                    ? Column(children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 200,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff8E1D1D),
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .shade800, // Màu của bóng
                                                    offset: const Offset(0,
                                                        2), // Độ dịch chuyển theo trục x và y
                                                    blurRadius:
                                                        2, // Bán kính làm mờ của bóng
                                                    spreadRadius:
                                                        0, // Bán kính lan rộng của bóng
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                style: const ButtonStyle(),
                                                onPressed: () {
                                                  listBranchPageBloc.add(
                                                      LBLoadedBranchNearEvent());
                                                },
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.location_on),
                                                    Text(
                                                      "Barber gần anh",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              width: 150,
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'TP/Tỉnh',
                                                    style: TextStyle(
                                                      // fontSize: 14,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  value: cityController,
                                                  items: cities
                                                      .map((city) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: city,
                                                            child: Text(
                                                              city,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (city) =>
                                                      listBranchPageBloc.add(
                                                          LBChooseBranchLoadedBranchListEvent(
                                                              cityController:
                                                                  city)),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 160,
                                                    width: 150,
                                                    // padding: EdgeInsets.only(right: 5),
                                                    decoration: BoxDecoration(
                                                      // borderRadius: BorderRadius.circular(14),
                                                      color:
                                                          Colors.grey.shade200,
                                                    ),
                                                    offset:
                                                        const Offset(-5, -2),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      // radius: const Radius.circular(40),
                                                      // thickness: MaterialStateProperty.all(6),
                                                      thumbVisibility:
                                                          WidgetStateProperty
                                                              .all(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      const MenuItemStyleData(
                                                    height: 40,
                                                    padding: EdgeInsets.only(
                                                        left: 14, right: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        // nội dung branch

                                        branchsList != null &&
                                                branchsList!.isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: branchsList!.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: branchsList[
                                                                index]
                                                            .branchThumbnail!,
                                                        height: 140,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: progress
                                                                .progress,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/images/barber1.jpg",
                                                          height: 140,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.2,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      ListTile(
                                                        title: Wrap(
                                                          spacing:
                                                              8.0, // Khoảng cách giữa các widget con theo chiều ngang
                                                          runSpacing:
                                                              4.0, // Khoảng cách giữa các dòng theo chiều dọc
                                                          children: [
                                                            Text(branchsList![
                                                                    index]
                                                                .branchName
                                                                .toString()),
                                                            branchsList![index]
                                                                        .distanceKm !=
                                                                    null
                                                                ? Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.6),
                                                                      ),
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Icon(
                                                                            Icons.location_on,
                                                                            color:
                                                                                Colors.black.withOpacity(0.9),
                                                                          ),
                                                                        ),
                                                                        const WidgetSpan(
                                                                          child:
                                                                              SizedBox(width: 4),
                                                                        ),
                                                                        TextSpan(
                                                                            text:
                                                                                branchsList![index].distanceKm,
                                                                            style: TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              color: Colors.black.withOpacity(0.8),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 4),
                                                          child: Text(
                                                              branchsList![
                                                                      index]
                                                                  .branchAddress
                                                                  .toString()),
                                                        ),
                                                        trailing: Container(
                                                          height: 40,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffE3E3E3),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800, // Màu của bóng
                                                                offset: const Offset(
                                                                    0,
                                                                    2), // Độ dịch chuyển theo trục x và y
                                                                blurRadius:
                                                                    2, // Bán kính làm mờ của bóng
                                                                spreadRadius:
                                                                    0, // Bán kính lan rộng của bóng
                                                              ),
                                                            ],
                                                          ),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.to(() =>
                                                                  LandingPage(
                                                                      index:
                                                                          2));
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                              ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                            ),
                                                            child: const Text(
                                                              'Đặt lịch',
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      (index !=
                                                              branchsList!
                                                                      .length -
                                                                  1)
                                                          ? const Divider(
                                                              color: Color(
                                                                  0x73444444),
                                                              height: 1,
                                                              thickness: 1,
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  );
                                                },
                                              )
                                            : Container(
                                                child: const Center(
                                                  child: Text(
                                                    "Không tìm thấy Barber.\nVui lòng thử lại.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                      ])
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 30),
                                            height: 50,
                                            width: 50,
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
