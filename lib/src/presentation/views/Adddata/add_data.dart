import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviews/src/constant/colors.dart';
import 'package:interviews/src/constant/strings.dart';
import 'package:interviews/src/controller/Homecontroller/home_controller.dart';
import 'package:interviews/src/utils/Dbhelper/db_helper.dart';


class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  Controller addData = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringData.newData.toString()),
      ),
      body: Form(
        key: addData.formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: addData.title.value,
                decoration: InputDecoration(
                  labelText: StringData.title.toString(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringData.p_title;
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: StringData.body.toString(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringData.p_body;
                  } else {
                    return null;
                  }
                },
                controller: addData.body.value,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                if (addData.formkey.currentState!.validate()) {
                  db_helper.database.insert(
                      title: addData.title.value.text,
                      body: addData.body.value.text);
                  Get.back();
                } else {
                  Get.snackbar(StringData.alert, StringData.y_Data);
                }
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: const BoxDecoration(
                  color: ColorsHelper.primery1,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  StringData.sData.toString(),
                  style:
                  const TextStyle(color: ColorsHelper.second, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
