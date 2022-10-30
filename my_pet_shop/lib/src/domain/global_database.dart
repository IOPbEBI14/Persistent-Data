import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/clients_database.dart';

MyDatabase globalDatabase = MyDatabase();

const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

Future<String?> getSecuredValue(String key) async {
  final result = await _storage.read(key: key);
  return result;
}

String? decodeCardNumber(String cardId) {
  final cardNumber = getSecuredValue(cardId);
  String? card;
  cardNumber.then((value) {
    card = value;
  });
  return card;
}

void addClient(Client client) async {
  final securedValue = '${client.id}_user_card_key';
  await _storage.write(key: securedValue, value: client.cardNumber);
  await globalDatabase.insertClient(client.copyWith(cardNumber: securedValue));
}

void deleteClient(Client client) async {
  await globalDatabase.deleteClient(client);
}

void updateClient(Client client) async {
  final securedValue = '${client.id}_user_card_key';
  await _storage.write(key: securedValue, value: client.cardNumber);
  await globalDatabase.updateClient(client.copyWith(cardNumber: securedValue));
}
