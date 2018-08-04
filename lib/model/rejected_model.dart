import 'package:firebase_database/firebase_database.dart';

class RejectedModel {
  String Brand;
  String Board;
  String Model;
  String Email;
  String Date;
  String Note;
  String Rejector;

  RejectedModel(
      this.Brand,
      this.Board,
      this.Model,
      this.Email,
      this.Date,
      this.Note,
      this.Rejector);

  RejectedModel.fromSnapshot(DataSnapshot snapshot)
      : Brand = snapshot.value["brand"],
        Board = snapshot.value["board"],
        Model = snapshot.value["model"],
        Email = snapshot.value["email"],
        Date = snapshot.value["date"],
        Note = snapshot.value["note"],
        Rejector = snapshot.value["rejector"];
}
