// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class AppDropDownField extends StatelessWidget {
//   const AppDropDownField({super.key, required this.dropDownController, this.initialValue});

//   final GetxController dropDownController;
//   final Rx<dynamic> initialValue;
//   final 


//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//                       padding: EdgeInsets.all(8.sp),
//                       child: DropdownButtonHideUnderline(
//                         child: InputDecorator(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                             contentPadding: const EdgeInsets.all(10),
//                           ),
//                           child: DropdownButton(
//                             alignment: Alignment.bottomRight,
//                             isExpanded: true,
//                             value: initialValue,
//                             items: [
//                               const DropdownMenuItem(
//                                 value: 'Select Batch No.',
//                                 child: Text('Select Batch No.'),
//                               ),
//                               if (dropDownController.batchNoValues.isNotEmpty)
//                                 ...inspectionController.batchNoValues
//                                     .map((valueItem) {
//                                   return DropdownMenuItem(
//                                     value: valueItem,
//                                     child: Text(valueItem),
//                                   );
//                                 }).toList()
//                             ],
//                             onChanged: (selectedValue) {
//                               inspectionController.batch.value = selectedValue!;
//                               // Handle onChanged event if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//   }
// }
