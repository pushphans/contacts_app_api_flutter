import 'package:contacts_app_api_flutter/model/contact.dart';
import 'package:contacts_app_api_flutter/viewmodel/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final name = TextEditingController();
  final number = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: number,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                labelText: "Number",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            Consumer<ApiProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  final nameEntry = name.text.trim();
                  final numberEntry = number.text.trim();

                  if (nameEntry.isNotEmpty && numberEntry.isNotEmpty) {
                    Contact newContact = Contact(
                      name: nameEntry,
                      number: numberEntry,
                    );

                    value.createContact(newContact);
                    name.clear();
                    number.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("New contact saved successfully")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Fill in all details")),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),

                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
