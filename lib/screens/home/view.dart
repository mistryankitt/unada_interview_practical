import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unada_interview/model/list_model.dart';
import 'package:unada_interview/service/api_service.dart';
import 'package:unada_interview/widgets/my_expansion_tile_widget.dart';

import 'provider.dart';

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
                        padding: const EdgeInsets.all(10),
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
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Of Doctor",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      provider
                                          .sharePdf(snapshot.data?.toJson());
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                            ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: data!.keys.map((key) {
                                final value = data[key];
                                // print(value);
                                if( key == "familyHistory" ||
                                    key == "treatments" ||
                                    key == "hospitalizations" ||
                                    key == "insurancePolicies"){}
                                if (key == "latestSymptoms") {
                                  return MyExpansionTile(
                                      title: data["latestSymptoms"][0]["header"],
                                      content: ListView.builder(
                                          itemCount: data["latestSymptoms"].length,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${value[index]["symptomId"]} :',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${value[index]["symptomName"]}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            );
                                          }));
                                }
                                if (key == "patientDetails" ||
                                    key == "emergencyContact" ||
                                    key == "dietAndNutritions" ||
                                    key == "lifestyle" ||
                                    key == "advancehistoryList") {
                                  return MyExpansionTile(
                                      title: data[key][0]["header"],
                                      content: ListView.builder(
                                          itemCount: value.length,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${value[index]["question"]} :',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${value[index]["answer"]}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
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
                                          child:

                                                 Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${value["doctorName"]} :',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${value["medicineNames"]}',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                )


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
                }),
          )
        ],
      ),
    );
  }
}
