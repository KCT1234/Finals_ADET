// import 'package:flutter/material.dart';
//
// class RecentDestinationTile extends StatelessWidget {
//   final String destination;
//   final String description;
//
//   const RecentDestinationTile({
//     required this.destination,
//     this.description = '',
//     super.key
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: const Icon(Icons.history, color: Colors.white),
//       title: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: destination,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             if (description.isNotEmpty)
//               TextSpan(
//                 text: '\n$description',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 14,
//                 ),
//               ),
//           ],
//         ),
//       ),
//       onTap: () {
//         // Handle tap on destination
//       },
//     );
//   }
// }