import 'package:firebase_database/firebase_database.dart';

class CompletedModel {
  String Brand;
  String Board;
  String CodeName;
  String Model;
  String Email;
  String Date;
  String Uid;
  String Url;
  String DeveloperEmail;
  String FmcToken;

  CompletedModel(this.Brand, this.Board, this.CodeName, this.Model, this.Email,
      this.Date, this.Uid, this.Url, this.DeveloperEmail, this.FmcToken);

  CompletedModel.fromSnapshot(DataSnapshot snapshot)
      : Brand = snapshot.value["brand"],
        Board = snapshot.value["board"],
        CodeName = snapshot.value["codeName"],
        Model = snapshot.value["model"],
        Email = snapshot.value["email"],
        Date = snapshot.value["date"],
        Uid = snapshot.value["uid"],
        Url = snapshot.value["url"],
        DeveloperEmail = snapshot.value["developerEmail"],
        FmcToken = snapshot.value["fmcToken"];
}
