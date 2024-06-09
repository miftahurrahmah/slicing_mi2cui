// import 'package:flutter/material.dart';
// import 'list_kabupaten.dart';
// import 'list_provinsi.dart';
//
// class PageFilter extends StatefulWidget {
//   const PageFilter({Key? key}) : super(key: key);
//
//   @override
//   _PageFilterState createState() => _PageFilterState();
// }
//
// class _PageFilterState extends State<PageFilter> {
//   late int selectedProvinsiId;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedProvinsiId = -1; // Initialize with invalid value
//   }
//
//   void setSelectedProvinsiId(int id) {
//     setState(() {
//       selectedProvinsiId = id;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: const Text('Filter Kabupaten'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PageProvinsi(
//                       onSelectProvinsi: setSelectedProvinsiId,
//                     ),
//                   ),
//                 );
//               },
//               child: Text(selectedProvinsiId == -1 ? 'Pilih Provinsi' : 'Provinsi Terpilih: $selectedProvinsiId'),
//             ),
//           ),
//           if (selectedProvinsiId != -1)
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigate to PageKabupaten with selectedProvinsiId
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PageKabupaten(idProvinsi: selectedProvinsiId),
//                     ),
//                   );
//                 },
//                 child: const Text('Tampilkan Kabupaten'),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
