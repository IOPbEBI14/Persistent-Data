import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../models/clients_database.dart';
import '../domain/global_database.dart';
import '../views/bottom_sheet_client.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class ClientsView extends StatefulWidget {
  ClientsView({Key? key, required this.controller}) : super(key: key);
  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<StatefulWidget> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  @override
  void initState() {
    super.initState();
  }

  void _showClientBottomSheet(BuildContext context, Client client) {
    showMaterialModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return toggleBottomSheetClient(context, client);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Список довольных клиентов'),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _showClientBottomSheet(
                context,
                Client(
                    id: 0,
                    firstName: '',
                    lastName: '',
                    age: 0,
                    picture: 'hh',
                    phone: '',
                    cardNumber: ''))),
        body: StreamBuilder<List<Client>>(
          initialData: [
            Client(
                id: 1,
                firstName: '1',
                lastName: '2',
                age: 11,
                picture: '',
                phone: '89128755553',
                cardNumber: '4422331188771155')
          ],
          stream: globalDatabase.clientsStream,
          builder: (context, clients) {
            return ListView.builder(
                itemCount: clients.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45)),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onDoubleTap: () =>
                                  deleteClient(clients.data![index]),
                              onTap: () => _showClientBottomSheet(
                                  context, clients.data![index]),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    foregroundImage: AssetImage(
                                        'assets/images/${clients.data![index].id % 10}.jpeg'),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${clients.data![index].firstName} ${clients.data![index].lastName}',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                        // QuantityInput(
                                        //   inputWidth: 30,
                                        //   value: hotelInfo.rating,
                                        //   onChanged: (hotelRating) => null,
                                        //   maxValue: 10,
                                        // ),
                                        Text(
                                            'phone:${clients.data![index].phone}'),
                                        FutureBuilder<String?>(
                                            future: getSecuredValue(clients
                                                .data![index].cardNumber),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    'card number:${snapshot.data}');
                                              } else {
                                                return const Text('');
                                              }
                                            }),
                                      ]),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
