import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _accountNumberControler = TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('New Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Column(
                      children:  <Widget>[
                          TextField(
                            controller: _nameControler,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                            ),
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: _accountNumberControler,
                                decoration: InputDecoration(
                                  labelText: 'Account number',
                                ),
                                style: TextStyle(fontSize: 24.0),
                                keyboardType: TextInputType.number,
                              ),
                          ),
                      ],
                    ),
                  ),
                  FractionalTranslation(
                    translation: Offset(0.0, -0.4),
                    child: Align(
                      alignment: FractionalOffset(0.5, 0.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) { return Colors.redAccent; } //<-- SEE HERE
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  child:  const Text('Create', style: TextStyle(fontSize: 24.0),),
                  onPressed: () {
                    final String name = _nameControler.text;
                    final int? accountNumber = int.tryParse(_accountNumberControler.text);

                    if (name != null && accountNumber != null){
                      final Contact newContact = Contact(0, name, accountNumber);
                      _dao.save(newContact).then((int) {
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
