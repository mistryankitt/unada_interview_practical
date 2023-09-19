import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:unada_interview/model/list_model.dart';
import 'package:unada_interview/service/api_service.dart';
import 'package:unada_interview/widgets/my_expansion_tile_widget.dart';

import 'provider.dart';
import 'dart:io' show Platform, Process;

import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<HomeProvider>();

    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 150,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/img.png",
                      fit: BoxFit.contain,
                      height: 80,
                      width: 80,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "The",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Row(
                          children: [
                            Text(
                              "Medi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.green),
                            ),
                            Text(
                              "bank",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Doctor summary",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.dashboard)),
                  ],
                )
              ],
            ),
            actions: [],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<ResponseData?>(
                future: ApiService.getAllApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: LinearProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final data = snapshot.data?.toJson();
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Wrap(
                                  children: [
                                    Text(
                                      "Summary ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Of Doctor",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      provider.sharePdf(snapshot.data?.toJson());
                                      // provider.printDoc();
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: data!.keys.map((key) {
                                final value = data[key];
                                // print(value);
                                if (key == "patientDetails" ||
                                    key == "emergencyContact" ||
                                    key == "latestSymptoms" ||
                                    key == "familyHistory" ||
                                    key == "dietAndNutritions" ||
                                    key == "lifestyle" ||
                                    key == "treatments" ||
                                    key == "hospitalizations" ||
                                    key == "insurancePolicies" ||
                                    key == "advancehistoryList") {
                                  return MyExpansionTile(
                                      title: data[key][0]["header"],
                                      content: ListView.builder(
                                          itemCount: value.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final similarDataKeysList =
                                                value[index].keys.toList();
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.green
                                                            .withOpacity(0.2),
                                                        width: 2)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List<Widget>.from(
                                                      similarDataKeysList.map(
                                                          (similarDataKeysListKey) {
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '$similarDataKeysListKey :',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${value[index][similarDataKeysListKey]}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                } else if (key == "latestMedications") {
                                  print(
                                      '${data["latestMedications"].keys.toList()} ');
                                  final lm =
                                      data["latestMedications"].keys.toList();
                                  return MyExpansionTile(
                                      title: value["header"],
                                      content: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.green
                                                    .withOpacity(0.2),
                                                width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List<Widget>.from(
                                              lm.map((lmKey) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '$lmKey :',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${value[lmKey]}',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                );

                                                return Row(
                                                  children: [
                                                    Text(
                                                      '$lmKey : ${value[lmKey]}',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Container();
                                }
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // return Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey.withOpacity(0.2),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: ListView.builder(
                  //         itemCount: snap.data!.length,
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, index) {
                  //           if (snap.data![index] == "patientDetails" || snap
                  //               .data![index] == "emergencyContact") {
                  //             return Container();
                  //           }
                  //           return Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       "${snap.data?[index]}",
                  //                       style: const TextStyle(
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                     IconButton(
                  //                         onPressed: () {},
                  //                         icon: const Icon(Icons.add)),
                  //                   ],
                  //                 ),
                  //               )
                  //             ],
                  //           );
                  //         }),
                  //   ),
                  // );
                }),
          )
        ],
      ),
    );
  }
}
