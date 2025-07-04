import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

late FirebaseApp secondaryApp;
late FirebaseFirestore secondaryFirestore;
late FirebaseDatabase secondaryDatabase;

Future<void> initSecondaryFirebaseApp() async {
  secondaryApp = await Firebase.initializeApp(
    name: 'secondaryApp',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD8zzbff_V5goHgjmy4PJOPRP0IvmKtfIQ',
      appId: '1:258801352560:android:ae5927b161bf5c775d19b5',
      messagingSenderId: '258801352560',
      projectId: 'health-agent-ffe26',
      databaseURL: 'https://health-agent-ffe26-default-rtdb.firebaseio.com',
    ),
  );

  secondaryFirestore = FirebaseFirestore.instanceFor(app: secondaryApp);
  secondaryDatabase = FirebaseDatabase.instanceFor(app: secondaryApp);
}
