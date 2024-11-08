import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  // Add data
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> body = TextEditingController().obs;

  // Update data
  Rx<TextEditingController> uTitle = TextEditingController().obs;
  Rx<TextEditingController> uBody = TextEditingController().obs;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
}
