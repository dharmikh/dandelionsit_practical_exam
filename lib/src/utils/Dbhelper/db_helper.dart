import 'package:supabase_flutter/supabase_flutter.dart';

class db_helper {
  db_helper.db_helper();

  static final db_helper database = db_helper.db_helper();
  final supabase = Supabase.instance.client;

//Create Note
  Future<void> insert({required String title, required String body}) async {
    await supabase.from('ts_databse').insert({'title': title, 'body': body});
  }

//Update Note
  Future<void> updateNote(
      String noteId, String updateBody, String updateTitle) async {
    await supabase
        .from('ts_databse')
        .update({'body': updateBody, 'title': updateTitle}).eq('id', noteId);
  }

  //Delete Note
  Future<void> deleteNote(String noteId) async {
    await supabase.from('ts_databse').delete().eq('id', noteId);
  }

  //Getdata Note
  final noteStream =
  Supabase.instance.client.from('ts_databse').stream(primaryKey: ['id']);
}
