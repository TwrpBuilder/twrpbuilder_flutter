import 'package:firebase_database/firebase_database.dart';
class DeveloperModel {
  String email;
  String name;
  String photoUrl;
  String xdaUrl;
  String gitId;
  String donationUrl;
  String description;

  DeveloperModel(this.email, this.name, this.photoUrl, this.xdaUrl, this.gitId,
      this.donationUrl, this.description);

  DeveloperModel.fromSnapshot(DataSnapshot snapshot)
    : email = snapshot.value["email"],
      name = snapshot.value["name"],
      photoUrl = snapshot.value["photoUrl"],
      xdaUrl = snapshot.value["xdaUrl"],
      gitId = snapshot.value["gitId"],
      donationUrl = snapshot.value["donationUrl"],
      description = snapshot.value["description"];
}