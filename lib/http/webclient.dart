import 'dart:convert';

import 'package:bytebank/screens/transactions_list.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../models/contact.dart';
import 'logging_interceptor.dart';

const String baseUrl = 'http://localhost:8080/transactions';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);
