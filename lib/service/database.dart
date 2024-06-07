import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobimall/service/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {

  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future updateUserwallet(String id, String amount) async {
    await SharedPreferenceHelper().saveUserWallet(amount);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({"Wallet": amount});
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance
        .collection(name)
        .add(userInfoMap);
  }


  Future<String?> getUserWallet(String id) async {
    try {
      /*DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();

      if (userDoc.exists) {
        return userDoc['Wallet']?.toString();
      } else {
        print('User does not exist. in getuserwallet');
        return null;
      }*/
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(SharedPreferenceHelper.userWalletKey);
    } catch (e) {
      print('Error getting user wallet: $e');
      return null;
    }
  }

  Future<String?> getUserName(String id) async {
    try {
      /*DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();

      if (userDoc.exists) {
        return userDoc['Name']?.toString();
      } else {
        print('User does not exist. in getusername');
        return null;
      }*/
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(SharedPreferenceHelper.userNameKey);
    } catch (e) {
      print('Error getting user name: $e');
      return null;
    }
  }

  Future<String?> getUserId() async {
    try {
      /*DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc().
          .get();



      if (userDoc.exists) {
        return userDoc['Id']?.toString();
      } else {
        print('User does not exist. in getuserid');
        return null;
      }*/
      /*DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(
          await FirebaseFirestore.instance.collection('users').path
      ).get(GetOptions(
        source: Source.serverAndCache
      ));
      print(userDoc);
      print(await FirebaseFirestore.instance.collection('users').count().toString())*/;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString(SharedPreferenceHelper.userIdKey));
      /*if (userDoc.exists) {
        print("Error in if");
        return userDoc['Id']?.toString();
      } else {
        print('User does not exist. in getuserid');
        return null;
      }*/
      return prefs.getString(SharedPreferenceHelper.userIdKey);
    } catch (e) {
      print('Error getting user id: $e');
      return null;
    }
  }

}
