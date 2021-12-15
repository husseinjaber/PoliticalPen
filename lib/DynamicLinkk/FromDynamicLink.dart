import 'package:flutter/material.dart';
import 'package:politicalpen/classes/News.dart';
import 'package:politicalpen/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<NewsObject> GoToPost(String PostId,String Cat) async{
  DataBaseService dataBaseService=new DataBaseService();
  NewsObject newsObject = new NewsObject();
  DocumentSnapshot data = await dataBaseService.GetSpecificPost(PostId, Cat);
  newsObject.title=data.data["title"];
  newsObject.ContentAr=data.data["contentAR"];
  newsObject.ContentEng=data.data["contentENG"];
  newsObject.desc=data.data["desc"];
  newsObject.id=data.documentID;
  newsObject.ImageUrl=data.data["url"];
  newsObject.date=data.data["date"];
  newsObject.PostLink=data.data["PostLink"];
  newsObject.categ=Cat;
//  print(newsObject.title+"from fromDynamicLink ---------------------------");
//  print(newsObject.ContentAr+"from fromDynamicLink ---------------------------");
//  print(newsObject.ContentEng+"from fromDynamicLink ---------------------------");
//  print(newsObject.desc+"from fromDynamicLink ---------------------------");
  return newsObject;
}