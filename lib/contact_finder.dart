import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class ContactFinder {
  static const MethodChannel _channel = const MethodChannel('contact_finder');

  static Future<Contact> selectContact() async {
    final Map<String, dynamic> result = await _channel.invokeMethod('selectContact');

    return result == null ? null : new Contact.fromJson(result);
  }
}


class Contact {

  final int _id;
  int get id => id;

  String name;
  List<Item<String>> phoneNumbers;
  Uint8List avatar;

  Contact({ int id, this.name, this.phoneNumbers, this.avatar }) : _id = id;

  factory Contact.fromJson(Map<String, dynamic> jsonMap) {
    return new Contact(
      id: jsonMap['_id'],
      name: jsonMap['name'],
      phoneNumbers: jsonMap['phoneNumbers'].map((number) => new Item<String>.fromJson(number)).toList().retype<Item<String>>(),
      avatar: jsonMap.containsKey('avatar') ? new Uint8List.fromList(jsonMap['avatar']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': _id,
    'name': name,
    'phoneNumbers': phoneNumbers.map((number) => number.toJson()).toList(),
    'avatar': avatar
  };

}

typedef dynamic Converter<T>(T basicValue);

// Used for contact fields which only have a [label] and a [value]
// like emails and phone numbers.
class Item<T> {
  String label;
  T value;

  Item({ this.label, this.value });

  factory Item.fromJson(Map<String, dynamic> jsonMap, [ Converter<dynamic> valueConverter ]) => new Item(
    label: jsonMap['label'],
    value: valueConverter == null ? jsonMap['value'] : valueConverter(jsonMap['value']),
  );

  Map<String, dynamic> toJson([ Converter<T> valueConverter ]) => {
    'label': label,
    'value': valueConverter == null ? value : valueConverter(value),
  };
}

