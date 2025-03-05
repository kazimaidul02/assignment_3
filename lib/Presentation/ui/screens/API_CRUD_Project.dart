import 'package:assignment_3/Presentation/ui/widget/ProductController.dart';
import 'package:assignment_3/Presentation/ui/widget/product_Card.dart';
import 'package:flutter/material.dart';

class ApiCrudProject extends StatefulWidget {
  const ApiCrudProject({super.key});

  @override
  State<ApiCrudProject> createState() => _ApiCrudProjectState();
}

class _ApiCrudProjectState extends State<ApiCrudProject> {

  final ProductController productController = ProductController();

  void productDialog({String ? id, String ? name, int ?qty, String ? img, int? unitPrice, int? totalPrice}) {

    TextEditingController productNameController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productQtyController.text =qty  !=null ? qty.toString() :'0' ;
    productImageController.text =img ?? '';
    productUnitPriceController.text =unitPrice !=null ? unitPrice.toString() : '0';
    productTotalPriceController.text =totalPrice !=null ? totalPrice.toString() : '0';

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8
        ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var product = productController.products[index];
            return ProductCard(product:product,
              onEdit: ()=> productDialog(
                id: product.sId,
                name: product.productName,
                img: product.img,
                qty: product.qty,
                unitPrice: product.unitPrice,
                totalPrice: product.totalPrice,
              ),
              onDelete: (){
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
            );
          }, ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
