// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'api.dart';

// class APIService {
//   final API api = API();

//   // HTTP
//   static var httpClient = http.Client();

//   Future<Map<String, dynamic>> getHttpData({
//     required Endpoints endpoint,
//   }) async {
//     final uri = api.endpointUri(endpoint);
//     final response = await httpClient.get(
//       uri,
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       // print(data);
//       if (data.isNotEmpty) {
//         return data;
//       }
//     }
//     print(
//       'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
//     );
//     throw response;
//   }

//   Future<Map<String, dynamic>> postHttpData({
//     required Endpoints endpoint,
//     required Map<String, dynamic> body,
//   }) async {
//     final uri = api.endpointUri(endpoint);

//     print(uri);
//     final response = await http.post(uri, body: jsonEncode(body));

//     print(response.body.length);
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     }
//     print(
//       '*** Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
//     );
//     throw response;
//   }
// }
