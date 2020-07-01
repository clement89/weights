import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NetworkHandler {
  Future getUserInfo(String value) async {
    print('**** getUserInfo');

    var bodyNew = json.encode({"set_wt": "$value"});

    http.Response response = await http.post(
        'http://ec2-3-22-55-23.us-east-2.compute.amazonaws.com:5010/WeighMe/getData',
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: bodyNew);

    var data = response.body;

    return data;
  }
}
