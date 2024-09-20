import 'package:flutter/cupertino.dart';
import 'package:payu_ppi_flutter/PayUConstantKeys.dart';
//Remove this plugin when you implement the salt at your server..
import 'package:crypto/crypto.dart';
import 'dart:convert';

class HashService {


  static Map generateHash(Map response) {

    
    var hashName = response[PayUHashConstantsKeys.hashName];
    var hashStringWithoutSalt = response[PayUHashConstantsKeys.hashString];

    var hash = "<hash from server>";
    //Don't use calculate hash locally, send hashStringWithoutSalt to server and append salt there and then convert it to SHA512 Hash and get the hash from your backend. 
    var finalHash = {hashName: hash};
    return finalHash;
  }

  //Don't use this method get the hash from your backend.
  static String getSHA512Hash(String hashData) {
    var bytes = utf8.encode(hashData); // data being hashed
    var hash = sha512.convert(bytes);
    return hash.toString();
  }
}
