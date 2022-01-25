import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/db_helper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }

}

class _ProductListState extends State{
  var dbHelper = DbHelper();
  List<Product> products=[];
  int productCount=0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child: const Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.amberAccent,
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.amber, child: Text("P"),),
              title: Text(products[position].name),
              subtitle: Text(products[position].description),
              onTap: (){
                goToDetail(products[position]);
              },
            ),
          );
        });
  }

  void goToProductAdd() async{
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAdd()));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }

  void getProducts() async{
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((value){
      setState(() {
        products = value;
        productCount = value.length;
      });
    });
  }

  void goToDetail(Product product) async{
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
}