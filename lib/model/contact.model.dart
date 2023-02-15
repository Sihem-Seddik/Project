class Contact{
  static String table="contact";
  int? id;
  String nom;
  int tel;
  //constructeur
  Contact({this.id,required this.nom,required this.tel});
  //convertir un objet Map en un contact
static Contact fromJson(Map<String,dynamic>json){
  return Contact(id: json['id'], nom: json['nom'].toString(),tel:json['tel']);
}
//Convertir un contact en un objet Map
Map<String,dynamic>toJson(){
  return{
    'id':id, 'nom':nom,'tel':tel,
  };
}
}