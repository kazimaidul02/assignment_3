import 'package:assignment_3/ProductController.dart';
import 'package:flutter/material.dart';

class ApiCrudProject extends StatefulWidget {
  const ApiCrudProject({super.key});

  @override
  State<ApiCrudProject> createState() => _ApiCrudProjectState();
}

class _ApiCrudProjectState extends State<ApiCrudProject> {

  final ProductController productController = ProductController();
  void productDialog() {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product name'),
              ),

              TextField(
                controller: productImageController,
                decoration: InputDecoration(labelText: 'Product Image'),
              ),
              TextField(
                controller: productQtyController,
                decoration: InputDecoration(labelText: 'Product Qty'),
              ),
              TextField(
                controller: productUnitPriceController,
                decoration:
                InputDecoration(labelText: 'Product unit price'),
              ),
              TextField(
                controller: productTotalPriceController,
                decoration:
                InputDecoration(labelText: 'Product Total price'),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed:(){
                    Navigator.pop(context);
                  }, child: Text('Close')),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      productController.createProducts(productNameController.text, productImageController.text, int.parse(productQtyController.text), int.parse(productUnitPriceController.text), int.parse(productTotalPriceController.text));
                      fetchData();
                      Navigator.pop(context);

                    });

                  }, child: Text("Add product ")),
                ],
              )
            ],
          ),
        ));
  }

  Future<void>fetchData() async{
    await productController.fetchProducts();
    setState(()  {

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var product = productController.products[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                //leading: Image.network(product['Img'],width: 150,fit:BoxFit.contain ,),
                title: Text(
                  product['ProductName'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'price: \$ ${product['TotalPrice']} | Qty: ${product['Qty']}',
                  style: TextStyle(),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () => productDialog(), icon: Icon(Icons.edit)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
