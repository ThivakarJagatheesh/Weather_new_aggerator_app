// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:weather_news_aggregator_app/view_controller/news_view_controller.dart';

// class WeatherSearchBox extends ConsumerStatefulWidget {
//   const WeatherSearchBox({super.key});
//   @override
//   ConsumerState<WeatherSearchBox> createState() => _WeatherSearchRowState();
// }

// class _WeatherSearchRowState extends ConsumerState<WeatherSearchBox> {
//   static const _radius = 30.0;

//   late final _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.text = ref.read(countryProvider);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // circular radius
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: SizedBox(
//         height: _radius * 2,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _searchController,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       bottomLeft: Radius.circular(15),
//                     ),
//                   ),
//                 ),
//                 onSubmitted: (value) =>
//                     ref.read(countryProvider.notifier).state = value,
//               ),
//             ),
//             InkWell(
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: Colors.cyanAccent,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Text('search',
//                       style: Theme.of(context).textTheme.bodyLarge),
//                 ),
//               ),
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//                 ref.read(countryProvider.notifier).state = _searchController.text;
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
