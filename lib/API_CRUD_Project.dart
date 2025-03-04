import 'package:assignment_3/ProductController.dart';
import 'package:flutter/material.dart';

class ApiCrudProject extends StatefulWidget {
  const ApiCrudProject({super.key});

  @override
  State<ApiCrudProject> createState() => _ApiCrudProjectState();
}

class _ApiCrudProjectState extends State<ApiCrudProject> {

  final ProductController productController = ProductController();

  void productDialog(
      {String ? id, String ? name, int ?qty, String ? img, int? unitPrice, int? totalPrice}) {

    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productQtyController.text =qty.toString() ?? '' ;
    productImageController.text =img ?? '';
    productUnitPriceController.text =unitPrice.toString() ?? '';
    productTotalPriceController.text =totalPrice.toString() ?? '';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(id ==null ? 'Add product' : 'Update product'),
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

                      if (id == null ){
                        productController.createProducts(productNameController.text, productImageController.text, int.parse(productQtyController.text), int.parse(productUnitPriceController.text), int.parse(productTotalPriceController.text));
                      }else{
                        productController.UpdateProducts(id,productNameController.text, productImageController.text, int.parse(productQtyController.text), int.parse(productUnitPriceController.text), int.parse(productTotalPriceController.text));
                      }

                      fetchData();
                      Navigator.pop(context);
                      setState(() {

                    });

                  }, child: Text(id ==null ? 'Add product' : 'Update product'),),
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
                leading: Image.network(product.img.toString(),width: 150,fit:BoxFit.contain ,),
                title: Text(
                  product.productName.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'price: \$ ${product.unitPrice} | Qty: ${product.qty}',
                  style: TextStyle(),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () => productDialog(
                      id: product.sId,
                      name: product.productName,
                      img: product.img,
                      qty: product.qty,
                      unitPrice: product.unitPrice,
                      totalPrice: product.totalPrice,



                    ), icon: Icon(Icons.edit)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {

                            productController.deleteProducts(product.sId.toString()).then((value){
                              if(value){
                                setState(() {
                                  fetchData();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Product deleted"),
                                    duration: Duration(seconds: 2),

                                  ),
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Something wrong try again"),
                                    duration: Duration(seconds: 2),

                                  ),
                                );

                              }
                            });


                        },
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
