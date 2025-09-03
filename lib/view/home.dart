// ignore_for_file: must_be_immutable

import 'package:contacts_app_api_flutter/viewmodel/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getContacts() async {
    await Provider.of<ApiProvider>(context, listen: false).fetchContacts();
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Calls",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ApiProvider>(context, listen: false).fetchContacts();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),

      body: Consumer<ApiProvider>(
        builder: (context, value, child) => Column(
          children: [
            Expanded(
              child: value.isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: value.contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        var unitContact = value.contacts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/update',
                                arguments: unitContact,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                            tileColor: Colors.grey.shade400,
                            title: Text(
                              unitContact.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),

                            subtitle: Text(
                              unitContact.number,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),

                            trailing: IconButton(
                              onPressed: () {
                                value.deleteContact(unitContact);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
