import 'package:firebase_storage/firebase_storage.dart';
import 'DynamicLinkk/DynamicLinkService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DataBaseService {
  FirebaseStorage storage = FirebaseStorage.instance;
  Firestore firestore = Firestore.instance;
  DynamicLinkService dynamicLinkService=new DynamicLinkService();
  Future<List<DocumentSnapshot>> GetNews(String categ ){
//    getUser();
    try {
      print("Trying to get news");
      return firestore.collection("articles").document(categ).collection("articles").orderBy("date",descending: true)
          .getDocuments()
          .then((snaps) {
        print(snaps.documents.length.toString()+"   this is the length of main news");
        return snaps.documents;
      });
    }on Exception {
      print("fuck");
    }

  }

  Future<DocumentSnapshot> GetMainCateg(){
//    getUser();
    try {
      return firestore.collection("Interface").document("Home").get();
    }on Exception {
      print("fuck"); }

  }

  Future<DocumentSnapshot> GetsocialMedia(){
//    getUser();
    try {
      return firestore.collection("Interface").document("PoliticalSocialMedia").get();
//          .then((snaps) {
//        print(snaps.documents.length.toString()+"   this is the length of main news");
//        return snaps.documents;
//      });
    }on Exception {
      print("fuck"); }

  }

  Future<DocumentSnapshot> GetSpecificPost(String Id,String Cat){
//    getUser();
    try {
      return firestore.collection("articles").document(Cat).collection("articles").document(Id)
          .get();
//          .then((snaps) {
//        print(snaps.documents.length.toString()+"   this is the length of main news");
//        return snaps.documents;
//      });
    }on Exception {
      print("fuck"); }

  }
  Future<DocumentReference> UploadArticle(
      String Cat,
      String title,
      String desc,
      String date,
      String Ar,
      String Eng,
      String pic,
      ){
    try {
       firestore.collection("articles").document(Cat).collection("articles").add(
         {
           "contentAR":Ar,
           "contentENG":Eng,
           "date":date,
           "desc":desc,
           "title":title,
           "url":pic,
           "isDone":0,
         }
       ).then((value1){
          dynamicLinkService.generateLink(value1.documentID, Cat).then((value){
            AddDynamicLinkToDocument(Cat,value1.documentID,value);
          });
       });
    }on Exception {
      print("fuck");
    }

  }
  Future<bool> AddDynamicLinkToDocument(
      String Cat,
      String id,
      String dynamicLink,
      ){
    try {
       firestore.collection("articles").document(Cat).collection("articles").document(id).updateData(
         {
           "PostLink":dynamicLink,
           "isDone":1,
         }
       ).then((value){
         return true;
       });
    }on Exception {
      print("fuck");
    }

  }

  Future<bool> EditMainNews(String Cat,){
    try {
       firestore.collection("Interface").document("Home").updateData(
         {
           "CatDisplay":Cat,
         }
       ).then((value){
         return true;
       });
    }on Exception {
      print("fuck");
    }

  }

  bool deleteProduct({String Cat,String Id,String pic}){
    try
    {
      firestore.collection("articles").document(Cat).collection("articles").document(Id)
          .delete().whenComplete((){

             storage.getReferenceFromUrl(pic).then((value){
              StorageReference p=value;
             p.delete();
         });
            return true;}).catchError(((error){return false;}));

            return true;}on Exception{}
  }

}
