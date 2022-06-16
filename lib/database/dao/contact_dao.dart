import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String tableSql = 'CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY, $_name TEXT, $_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';
  static const String _pathDB = 'byte_bank.db';

  Future<Database> getDatabases() async {
    final String path = join(await getDatabasesPath(), _pathDB);
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(ContactDao.tableSql);
        },
      version: 1,
      //  onDowngrade: onDatabaseDowngradeDelete
    );
  }

  Future<int> save(Contact contact) async {
    final Database db = await getDatabases();
    final Map<String, dynamic> contactsMap = {};
    contactsMap[_name] = contact.name;
    contactsMap[_accountNumber] = contact.accountNumber;
    return db.insert(_tableName, contactsMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabases();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return _toList(result);
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = <Contact>[];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
