import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> storeValues() async {
  String uid = '', email = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('User Profile').add({
          'UID': '${prefs.getString('uid')}',
          'Email': '${prefs.getString('useremail')}'
        }).then((value) => {print('lol')})
      });
}

Future<void> registerUser(String name, String email, String phone) async {
  //String uid='', email='', name = '', phone = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('User Profile').add({
          'Email': '${email}',
          'Name': '${name}',
          'Phone': '${phone}'
        }).then((value) => {print('User Registered in DB')})
      });
}

Future<dynamic> getUserData(String email) async {
  Future<Map> data;
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('User Profile')
        .where('Email', isEqualTo: email)
        .get();
    print('Here');
    print('${snapshot.docs[0].data()}');
    return snapshot.docs[0].data();
  } catch (e) {
    print(e.toString());
  }
  //print(snapshot.docs[0].data()['UID']);

  // List<QueryDocumentSnapshot> docs = snapshot.docs;
  // for (var doc in docs) {
  //   if (doc.data() != null) {
  //     if ('${doc['Email']}' == email) {
  //       return doc;
  //     }
  //   }
  // }
}
// Future<List> fetchAllContact() async {
//     List contactList = [];
//     DocumentSnapshot documentSnapshot =
//         await firestore.collection('my_contact').doc('details').get();
//     contactList = documentSnapshot.data()['contacts'];
//     return contactList;
//   }
