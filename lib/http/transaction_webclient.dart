import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../models/transaction.dart';
import 'logging_interceptor.dart';

class TransactionWebClient {

  Future<List<Transaction>> findAll() async {
    final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
    final Response response = await client.get(Uri.parse(baseUrl));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }

  // List<Transaction> _toTransactions(Response response) {
  //   final List<Transaction> transactions = [];
  //   final List<dynamic> decodedJson = jsonDecode(response.body);
  //   for(Map<String, dynamic> transactionJson in decodedJson){
  //     transactions.add(Transaction.fromJson(transactionJson));
  //   }
  //   return transactions;
  // }

// Transaction _toTransaction(Response response) {
//   Map<String, dynamic> json = jsonDecode(response.body);
//   return Transaction.fromJson(json);
// }

  // Map<String, dynamic> _toMap(Transaction transaction) {
  //   final Map<String, dynamic> transactionMap = {
  //     'value': transaction.value,
  //     'contact': {
  //       'name': transaction.contact.name,
  //       'accountNumber': transaction.contact.accountNumber
  //     }
  //   };
  //   return transactionMap;
  // }
}