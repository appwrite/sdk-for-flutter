import 'package:appwrite/appwrite.dart';

void main() { // Init SDK
  Client client = Client();
  Vcs vcs = Vcs(client);

  client
    .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('5df5acd0d48c2') // Your project ID
  ;
  Future result = vcs.updateExternalDeployments(
    installationId: '[INSTALLATION_ID]',
    repositoryId: '[REPOSITORY_ID]',
    providerPullRequestId: '[PROVIDER_PULL_REQUEST_ID]',
  );

  result
    .then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
  });
}
