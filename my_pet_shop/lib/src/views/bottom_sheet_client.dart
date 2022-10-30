import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_pet_shop/src/domain/global_database.dart';
import 'package:my_pet_shop/src/models/clients_database.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController cardNumberController = TextEditingController();

Widget toggleBottomSheetClient(BuildContext context, Client client) {
  int updateFlag = client.age;
  firstNameController.text = client.firstName;
  lastNameController.text = client.lastName;
  ageController.text = client.age == 0 ? '' : client.age.toString();
  phoneController.text = client.phone;
  getSecuredValue(client.cardNumber)
      .then((value) => cardNumberController.text = value!);
  return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter first name';
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'First name',
                  labelStyle: const TextStyle(color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last name',
                  labelStyle: const TextStyle(color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                maxLength: 3,
                controller: ageController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: const TextStyle(color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                maxLength: 15,
                controller: phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9 ]|[()-]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: const TextStyle(color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                ),
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                controller: cardNumberController,
                maxLength: 22,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Card number',
                  labelStyle: const TextStyle(color: Colors.purple),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.purple)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    )),
                  ),
                  child: const Text('          ADD          '),
                  onPressed: () {
                    if (firstNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter your first name!')),
                      );
                    } else if (lastNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter your last name!')),
                      );
                    } else if (ageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter your age!')),
                      );
                    } else if (int.parse(ageController.text) > 150) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Enter your correct age!')),
                      );
                    } else if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter phone number!')),
                      );
                    } else if (cardNumberController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Enter your card number!')),
                      );
                    } else if (cardNumberController.text.length != 16 &&
                        cardNumberController.text.length != 18) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Card number should be 16 or 18 symbols!')),
                      );
                    } else {
                      Client newClient = client.copyWith(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          age: int.parse(ageController.text),
                          phone: phoneController.text,
                          cardNumber: cardNumberController.text,
                          picture: '  ');
                      if (updateFlag == 0) {
                        addClient(newClient);
                      } else {
                        updateClient(newClient);
                      }
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

bool showMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: Text(message));
      });
  return true;
}
