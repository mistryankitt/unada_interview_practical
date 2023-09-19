// import 'package:flutter/material.dart';
// import 'package:unada_interview/service/api_service.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Nested JSON UI'),
//         ),
//         body: FutureBuilder<Map<String, dynamic>>(
//           future: ApiService.getAllApi(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No data available'));
//             } else {
//               final data = snapshot.data!;
//               return ListView(
//                 children: data.keys.map((key) {
//                   final value = data[key];
//                   // print(value);
//                   if (key == "patientDetails" ||
//                       key == "emergencyContact" ||
//                       key == "latestSymptoms" ||
//                       key == "familyHistory" ||
//                       key == "dietAndNutritions" ||
//                       key == "lifestyle" ||
//                       key == "treatments" ||
//                       key == "hospitalizations" ||
//                       key == "insurancePolicies" ||
//                       key == "advancehistoryList") {
//                     return MyExpansionTile(
//                         title: data[key][0]["header"],
//                         content: ListView.builder(
//                             itemCount: value.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final pl = value[index].keys.toList();
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: List<Widget>.from(
//                                     pl.map((vv) {
//                                       return Text(
//                                         '${vv} : ${value[index][vv]}',
//                                         style: TextStyle(fontSize: 16),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               );
//                             }));
//                   } else if (key == "latestMedications") {
//                     print('${data["latestMedications"].keys.toList()} ');
//                     final lm = data["latestMedications"].keys.toList();
//                     return MyExpansionTile(
//                         title: value["header"],
//                         content: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: List<Widget>.from(
//                               lm.map((lmKey) {
//                                 return Text(
//                                   '$lmKey : ${value[lmKey]}',
//                                   style: const TextStyle(fontSize: 16),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ));
//                   } else {
//                     return Container();
//                   }
//                 }).toList(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // The rest of your code remains unchanged.
//
// class MyExpansionTile extends StatefulWidget {
//   final String title;
//   final Widget content;
//
//   MyExpansionTile({required this.title, required this.content});
//
//   @override
//   _MyExpansionTileState createState() => _MyExpansionTileState();
// }
//
// class _MyExpansionTileState extends State<MyExpansionTile> {
//   bool _isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             title: Text(
//               widget.title,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             trailing: IconButton(
//               icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
//               onPressed: () {
//                 setState(() {
//                   _isExpanded = !_isExpanded;
//                 });
//               },
//             ),
//           ),
//           if (_isExpanded)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: widget.content,
//             ),
//         ],
//       ),
//     );
//   }
// }
