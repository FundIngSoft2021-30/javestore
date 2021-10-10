// import 'package:flutter/material.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:EdgeInsets.all(0.5),
//       child: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) => Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Dismissible(
//             key: Key(demoCarts[index].product.id.toString()),
//             direction: DismissDirection.endToStart,
//             onDismissed: (direction) {
//               setState(() {
//                 demoCarts.removeAt(index);
//               });
//             },
//             background: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFE6E6),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 children: [
//                   Spacer(),
//                 ],
//               ),
//             ),
//             child: CartCard(cart: demoCarts[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }