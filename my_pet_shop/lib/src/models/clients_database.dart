import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'clients_database.g.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text().withLength(min: 2, max: 50)();

  TextColumn get lastName => text().withLength(min: 2, max: 50)();

  IntColumn get age => integer()();

  TextColumn get picture => text().withLength(min: 2, max: 250)();

  TextColumn get phone => text().withLength(min: 2, max: 20)();

  TextColumn get cardNumber => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Clients])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  void clearClients() {
    delete(clients).go();
  }

  Future deleteClient(Client client) {
    return (delete(clients)..where((tbl) => tbl.id.equals(client.id))).go();
  }

  Future<List<Client>> get allClients => select(clients).get();

  Future<int> insertClient(Client client) =>
      into(clients).insert(ClientsCompanion.insert(
          firstName: client.firstName,
          lastName: client.lastName,
          age: client.age,
          picture: client.picture,
          phone: client.phone,
          cardNumber: client.cardNumber));

  Future<bool> updateClient(Client client) => update(clients).replace(client);

  Stream<List<Client>> get clientsStream =>
      select(clients).watch(); //getClientStream().watch();

  @override
  int get schemaVersion => 1;
}
