import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/db_helper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductAddState();
  }
}

class _ProductAddState extends State{
  var dbHelper = DbHelper();
  var txtId= TextEditingController();
  var txtName= TextEditingController();
  var txtDescription= TextEditingController();
  var txtUnitPrice= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Yeni ürün ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildIdField(), buildNameField(), buildDescriptionField(), buildUnitPriceField(),
            SizedBox(height: 30.0,),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  TextField buildIdField() {
    return TextField(
      decoration: InputDecoration(labelText: "İd"),
      controller: txtId,
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün birim fiyatı"),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return TextButton(
      child: const Text("Ekle", style: TextStyle(fontSize:20, color:Colors.deepPurpleAccent)),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async{
    await dbHelper.insert(Product.withId(id:int.tryParse(txtId.text)!, name:txtName.text, description:txtDescription.text, unitPrice:double.tryParse(txtUnitPrice.text)!));
    Navigator.pop(context,true);
  }

}