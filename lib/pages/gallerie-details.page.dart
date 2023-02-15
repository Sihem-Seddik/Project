import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/pages/Gallerie-details.page.dart';
class GallerieDetailsPage extends StatefulWidget {
  String Keyword='';
  GallerieDetailsPage(this.Keyword);
@override
State<GallerieDetailsPage> createState()=>_GallerieDetailsPageState();}
class _GallerieDetailsPageState extends State<GallerieDetailsPage>{
int currentPage=1;
int size=10;
late num totalpages=100;
ScrollController _scrollController=new ScrollController();
List<dynamic> hits=[];
  var galleryData;
  @override
void initState(){
  super.initState();
  getGalleryData(widget.Keyword);
  _scrollController.addListener(() {
    if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent) {
      if(currentPage<totalpages){
        currentPage++;
        getGalleryData(widget.Keyword);
      }
    }

  });
}
void getGalleryData(String keyword){
    print("gallery de "+keyword);
    String url="https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=${keyword}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
      this.galleryData=json.decode(resp.body);
      hits.addAll(galleryData['hits']);
      if(galleryData['totalHits']%size==0)
        totalpages=galleryData['totalHits']~/size;
      else{
        totalpages=1+(galleryData['totalHits']/size).floor();
      }
      hits=galleryData['hits'];
      print(hits); });
    }).catchError((err){
      print(err);
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.Keyword},page ${currentPage}/${totalpages}'),),
      body:(galleryData==null
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(itemCount: (getGalleryData==null ? 0 :hits.length),
          controller: _scrollController
          ,itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              width:double.infinity,
              padding: EdgeInsets.only(left: 10,right: 10),
              child:Card(
                child:Padding(
                padding:EdgeInsets.only(left: 10,right: 10),
                child:Center(
              child: Text(
                hits[index]['tags'],
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),

              ),),
                color:Colors.blue,
            ),),
            Container(
              child: Card(
                child: Image.network(hits[index]['webformatURL'],fit: BoxFit.fitWidth,),
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
            )
          ],
             );
          }))
    );
    @override
    void dispose(){
      super.dispose();
      _scrollController.dispose();
    }
  }


}
