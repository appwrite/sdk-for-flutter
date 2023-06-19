// Import the necessary packages
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite/src/enums.dart';
import 'package:appwrite/src/response.dart';

// Create a MockClient using the Mockito package.
// You could also make this a global variable if you have multiple tests.
class MockClient extends Mock implements Client {
  @override
  Future<Response> call(
    HttpMethod? method, {
    String path = '',
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
    ResponseType? responseType,
  }) async {
    super.noSuchMethod(Invocation.method(#call, [method]));
    return super.noSuchMethod(Invocation.method(#call, [method]),
        returnValue: Response());
  }
}

void main() {
  // Define a group for account tests
  group('Account', () {
    // The client and account objects we'll be testing with
    late Client client;
    late Account account;

    setUp(() {
      // Create a new mock client before each test
      client = MockClient();
      // Instantiate the Account object with the mock client
      account = Account(client);
    });

    // Test the get() method
    test('get() returns User object on success', () async {
      // Define the response data
      final Map<String, dynamic> response = {
        'name': 'Test User',
        'email': 'test@example.com',
        'status': true,
        'emailVerification': true,
        'phoneVerification': false,
        '\$createdAt': '2023-06-01',
        '\$updatedAt': '2023-06-01',
        'prefs': <String, dynamic>{}
        // Add any other properties here
      };

      // Use Mockito to set up a mock response when the call method is called
      when(client.call(
        HttpMethod.get,
        path: '/account',
        params: {},
        headers: {'content-type': 'application/json'},
      )).thenAnswer((_) async => Response(data: response));

      // Call the get method and await the result
      final user = await account.get();

      // Verify that the result is a User object with the correct properties
      expect(user, isA<User>());
      expect(user.name, equals('Test User'));
      expect(user.email, equals('test@example.com'));
    });
  });
}
