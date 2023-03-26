import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const userCollection = "user";
const barangCollection = "barang";
const lelangCollection = "lelang";
const historylelangCollection = "historylelang";
