import 'package:api_exception/services/api_handling/api_services.dart';

class HomeController {
  final url = 'http://api.publicapis.org/entries';

  getData() async {
    // Example GET request
    final getResponse = await ApiService().makeApiCall(url, HttpMethod.GET);
    if (getResponse is Map<String, dynamic> &&
        getResponse.containsKey('error')) {
      print('GET Request Error: ${getResponse['error']}');
    } else {
      print('GET Request Response: $getResponse');
    }
  }

  postData() async {
    // Example POST request
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer your_token_here'
    };
    final postData = {'name': 'John', 'age': 25};
    final postResponse = await ApiService()
        .makeApiCall(url, HttpMethod.POST, data: postData, headers: headers);
    print(postResponse);
  }

  updateData() async {
    // Example PUT request
    final putData = {'name': 'Jane', 'age': 30};
    final putResponse =
        await ApiService().makeApiCall(url, HttpMethod.PUT, data: putData);
    print(putResponse);
  }

  deleteData() async {
    // Example DELETE request
    final deleteResponse =
        await ApiService().makeApiCall(url, HttpMethod.DELETE);
    print(deleteResponse);
  }
}
