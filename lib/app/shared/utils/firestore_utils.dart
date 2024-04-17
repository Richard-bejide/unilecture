import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'debug_print.dart';

class FirestoreUtils {

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String usersColl = 'users';
  static String coursesColl = 'courses';
  static String chatsColl = 'chats';

  static Future<void> setDoc(String collectionName, String key, Map<String, dynamic> value) async {
    await firestore.collection(collectionName).doc(key).set(value);
  }

  static Future<void> updateDoc(String collectionName, String key, Map<String, dynamic> value) async {
    await firestore.collection(collectionName).doc(key).update(value);
  }

  static Future<void> deleteDoc(String collectionName, String key) async {
    firestore.collection(collectionName).doc(key).delete();
  }

  static Future<Map<String, dynamic>?> getDoc(String collectionName, String key) async {
    DocumentReference<Map<String, dynamic>> documentReference =  firestore.collection(collectionName).doc(key);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      return data;
    } else {
      dPrint('Document does not exist');
      null;
    }
    return null;
   }

  static Future<List<Map<String, dynamic>>?> getSnapshotWithKey(String collectionName,String searchKey,String searchValue) async {
    CollectionReference<Map<String, dynamic>> collectionReference = firestore.collection(collectionName);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.where(searchKey, isEqualTo:searchValue).get();
    List<Map<String, dynamic>> data = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
      data.add(docSnapshot.data());
    }
    return data;
  }

  static Future<void> updateSnapshotListWithKey(String collectionName,String searchKey,String searchValue, String updateKey,dynamic updateValue) async {
    CollectionReference<Map<String, dynamic>> collectionReference = firestore.collection(collectionName);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.where(searchKey, isEqualTo: searchValue).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
      DocumentReference<Map<String, dynamic>> docRef = docSnapshot.reference;
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await docRef.get();
      Map<String, dynamic>? data = documentSnapshot.data();
      List<dynamic> listToUpdate = data?[updateKey].cast<dynamic>();
      listToUpdate.add(updateValue);
      await docRef.update({updateKey: listToUpdate});
      return;
    }
  }

  static Future<String?> uploadFile(String refName, File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique filename
      Reference ref = FirebaseStorage.instance.ref(refName).child(fileName);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      dPrint('downloadUrl is $downloadUrl');
      return downloadUrl;
    } catch (e) {
      dPrint('Error uploading image: $e');
      return null;
    }
  }

}
