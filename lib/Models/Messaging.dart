import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> 'Server key'
  static const String serverKey =
      'AAAA_VuxCxg:APA91bGEafsb7I1TParAslPj6uYssGNMEjO2xgc5db5IKjK2sfSSqhA0mOzMaQ106Xl-36nnXXR_8JMkAdB2dyhNN4OQPmu5cyTFnHw5zQkHCc91rA9u2h__krC8mO0uP8WZWxeqog3Q';

  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: 'all');

  static Future<Response> sendToTopic(
      {@required String title,
        @required String body,
        @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,String userid,userNickName,docID,message,ppURL,notiType,
    DateTime date,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'body': '$body', 'title': '$title',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'userNickName': '$userNickName',
            'ppURL': '$ppURL',
            'message': '$message','userid':'$userid',
            'docID': '$docID',
            'type':'$notiType',
            'date': '$date'
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}