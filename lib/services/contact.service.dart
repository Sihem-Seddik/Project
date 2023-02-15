import 'package:project/model/contact.model.dart';
import 'package:project/utils/contact.database.dart';

class ContactService{
  Future<List<Contact>> listeContacts() async{
 List<Map<String,dynamic>> contacts=await ContactDatabase.recuperer();
 return contacts.map((item) => Contact.fromJson(item)).toList();

  }
  //Methode d'ajout contact du service permettant d'inserer un contact
  Future<bool> ajouterContact(Contact c) async{
    int res=await ContactDatabase.inserer(c);
    return res>0 ? true :false;
  }
  //Methode modifierContact du service permettant de modifier u n contact
  Future<bool> modifierContact(Contact c) async{
    int res=await ContactDatabase.modifier(c);
    return res>0 ? true: false;
  }
  //Methode supprimerContact du service permettant de supprimer un contact
Future<bool> supprimerContact(Contact c) async{
    int res=await ContactDatabase.supprimer(c);
    return res>0? true: false;
}
}