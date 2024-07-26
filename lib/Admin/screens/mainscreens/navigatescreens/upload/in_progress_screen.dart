// import 'package:flutter/material.dart';
//
// class InProgressScreen extends StatefulWidget {
//   final String searchQuery;
//
//   const InProgressScreen({Key? key, required this.searchQuery})
//       : super(key: key);
//
//   @override
//   State<InProgressScreen> createState() => _InProgressScreenState();
// }
//
// class _InProgressScreenState extends State<InProgressScreen> {
//   LocalJsonServices localJsonServices = LocalJsonServices();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<RentalsModel>>(
//         future: localJsonServices.getAllData(context, widget.searchQuery),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             List<RentalsModel> data = snapshot.data;
//             return ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   var myData = data[index];
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.only(left: 12),
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundImage: NetworkImage(myData.image),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.03,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 6, vertical: 10),
//                         width: MediaQuery.of(context).size.width * 0.77,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               myData.name,
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             sizedBox5,
//                             Row(
//                               children: [
//                                 Text(myData.sDate),
//                                 const SizedBox(width: 8),
//                                 const Icon(Icons.arrow_forward),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(myData.eDate),
//                                 const Spacer(),
//                                 const Icon(Icons.arrow_forward_ios),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                               ],
//                             ),
//                             sizedBox5,
//                             Text(myData.carName),
//                             sizedBox10,
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2),
//                                       border:
//                                       Border.all(color: gOffBlack)),
//                                   child: Text(myData.lNumber),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 12),
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     color: gOffWhite,
//                                     borderRadius: BorderRadius.circular(2),
//                                     border: Border.all(
//                                       color: gOffWhite,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     myData.status,
//                                     style:
//                                     const TextStyle(color: gOffBlack),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             sizedBox10,
//                             const Divider(
//                               color: gOffBlack,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 });
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }