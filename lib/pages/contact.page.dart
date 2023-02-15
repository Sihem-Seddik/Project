
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/menu/drawer.widget.dart';
import 'package:project/model/contact.model.dart';
import 'package:project/pages/ajout_modif_contact.page.dart';
import 'package:project/services/contact.service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';

class ContactPage extends StatefulWidget {
  ContactService contactService=ContactService();
  @override
  State<ContactPage> createState()=>_contactPageState();}
  class _contactPageState extends State<ContactPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(
        child:Column(
          children: [
            SizedBox(
              height:10,
            ),
            Align(
              alignment: Alignment.centerRight,
                child: FormHelper.submitButton("Ajout", (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AjoutModifContactPage(),),
    ).then((value) { setState ((){});});
                },
                  borderRadius: 10,
                  btnColor: Colors.blue,
                  borderColor: Colors.blue,
                ),
            ),
            SizedBox(
              height: 10,

            ),
            _fetchData(),
          ],
        ),
      ),

    );
  }
_fetchData(){
    return FutureBuilder<List<Contact>>(
      future: widget.contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts ){
        if(contacts.hasData) return _buildDataTable(contacts.data!);
return Center(child: CircularProgressIndicator(),);

      },
    );
}
_buildDataTable(List<Contact> listContacts){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: ListUtils.buildDataTable( context,
      ["Nom","Telephone","Action"],
      ["nom","tel",""],
      false,0,listContacts,(Contact c){
        //Modifier Contact
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=>AjoutModifContactPage(
            modifMode: true,
            contact: c,
          ),),).then((value) {
            setState(() {

            });
          });
          ;
    },(Contact c){
        //Spprimer contact
        return showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Supprimer contact"),
            content: const Text("Etes vous sure de vouloir supprimer ce contact??"),
              actions: [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormHelper.submitButton("Oui", (){
                    widget.contactService.supprimerContact(c).then((value){
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    });
                  },
                  width: 100,
                  borderRadius: 5,
                  btnColor: Colors.green,
                  borderColor: Colors.green,),
                  const  SizedBox(
                    width: 20,
                  ),
                  FormHelper.submitButton("Non", (){
                    Navigator.of(context).pop();
                  },
                  width: 100,
                  borderRadius: 5,),
                ],
              )],
          );
        });
    },
      headingRowColor: Colors.orangeAccent,
      isScrollable: true,
      columnTextFontSize: 20,
      columnTextBold: false,
      columnSpacing: 50,
      onSort: (columnIndex,columnsName,asc){},
    ),
    );
}

}
