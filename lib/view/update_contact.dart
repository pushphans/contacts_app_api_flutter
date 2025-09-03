// ignore_for_file: must_be_immutable

import 'package:contacts_app_api_flutter/model/contact.dart';
import 'package:contacts_app_api_flutter/viewmodel/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateContact extends StatefulWidget {
  Contact contact;
  UpdateContact({super.key, required this.contact});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final updatedName = TextEditingController();
  final updatedNumber = TextEditingController();

  @override
  void initState() {
    updatedName.text = widget.contact.name;
    updatedNumber.text = widget.contact.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update contact")),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: updatedName,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 20),

            TextField(
              controller: updatedNumber,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 30),

            Consumer<ApiProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  final nameEntry = updatedName.text.trim();
                  final numberEntry = updatedNumber.text.trim();

                  if (nameEntry.isNotEmpty && numberEntry.isNotEmpty) {
                    Contact newContact = Contact(
                      id: widget.contact.id,
                      name: nameEntry,
                      number: numberEntry,
                    );

                    value.updateContact(newContact);
                    updatedName.clear();
                    updatedNumber.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Contact updated successfully")),
                    );

                    Navigator.pop(context);
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
                      "Update",
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
