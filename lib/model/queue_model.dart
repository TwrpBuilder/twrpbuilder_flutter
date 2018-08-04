import 'package:firebase_database/firebase_database.dart';

class QueueModel {
  String Brand;
  String Board;
  String CodeName;
  String Model;
  String Email;
  String Date;
  String Uid;
  String FmcToken;

  QueueModel(this.Brand, this.Board, this.CodeName, this.Model, this.Email,
      this.Date, this.Uid, this.FmcToken);

  QueueModel.fromSnapshot(DataSnapshot snapshot)
      : Brand = snapshot.value["brand"],
        Board = snapshot.value["board"],
        CodeName = snapshot.value["codeName"],
        Model = snapshot.value["model"],
        Email = snapshot.value["email"],
        Date = snapshot.value["date"],
        Uid = snapshot.value["uid"],
        FmcToken = snapshot.value["fmcToken"];
}
