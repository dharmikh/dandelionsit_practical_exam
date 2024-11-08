import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviews/src/constant/colors.dart';
import 'package:interviews/src/constant/strings.dart';
import 'package:interviews/src/controller/Homecontroller/home_controller.dart';
import 'package:interviews/src/presentation/views/Adddata/add_data.dart';
import 'package:interviews/src/utils/Dbhelper/db_helper.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

Controller homeController = Get.put(Controller());

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    db_helper.database.noteStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringData.aData),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddData());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: db_helper.database.noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final Notes = snapshot.data!;
          return ListView.builder(
            itemCount: Notes.length,
            itemBuilder: (context, index) {
              final note = Notes[index];
              final noteId = note['id'].toString();

              return Card(
                child: ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['body']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 1000,
                                  width: double.infinity,
                                  child: Form(
                                    key: homeController.formkey,
                                    child: SimpleDialog(
                                      title: Text(StringData.A_data.toString()),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: TextFormField(
                                            controller:
                                            homeController.uTitle.value,
                                            decoration: InputDecoration(
                                              labelText:
                                              StringData.title.toString(),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please enter  title";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: TextFormField(
                                            controller:
                                            homeController.uBody.value,
                                            decoration: InputDecoration(
                                              labelText:
                                              StringData.title.toString(),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "please enter  body";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: InkWell(
                                            onTap: () {
                                              if (homeController
                                                  .formkey.currentState!
                                                  .validate()) {
                                                db_helper.database.updateNote(
                                                    noteId,
                                                    homeController
                                                        .uBody.value.text,
                                                    homeController
                                                        .uTitle.value.text);
                                                Get.back();
                                              } else {
                                                Get.snackbar("Alert",
                                                    "Please Add Your Data");
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              decoration: const BoxDecoration(
                                                  color: ColorsHelper.primery1,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12))),
                                              alignment: Alignment.center,
                                              child: Text(
                                                StringData.uData.toString(),
                                                style: const TextStyle(
                                                    color: ColorsHelper.second,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            db_helper.database.deleteNote(noteId);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
