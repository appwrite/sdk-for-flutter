import 'package:appwrite/appwrite.dart';

void main() { // Init SDK
  Client client = Client();
  Migrations migrations = Migrations(client);

  client
    .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('5df5acd0d48c2') // Your project ID
  ;
  Future result = migrations.deleteFirebaseAuth();

  result
    .then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
  });
}
