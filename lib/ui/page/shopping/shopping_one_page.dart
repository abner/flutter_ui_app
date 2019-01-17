import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/product_bloc.dart';
import 'package:flutter_uikit/model/product.dart';
import 'package:flutter_uikit/ui/widgets/common_scaffold.dart';
import 'package:flutter_uikit/ui/page/shopping/shopping_details_page.dart';

class ShoppingOnePage extends StatefulWidget {
  @override
  _ShoppingOnePage createState() => _ShoppingOnePage();
}
class _ShoppingOnePage extends State<ShoppingOnePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<int> items = List.generate(1, (i) => i);
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  BuildContext _context;

  //stack1
  Widget imageStack(String img) => Image.network(
        img,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(Product product) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),

                  ),
                ),
                Text(product.price,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(double rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget productGrid(List<Product> products,context) => GridView.count(
        crossAxisCount:
            MediaQuery.of(_context).orientation == Orientation.portrait ? 2 : 3,
        shrinkWrap: true,
        children: products
            .map((product) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onDoubleTap: () => showSnackBar(),
                    onTap: () {
                 _pushPage(context, product.goods_id);
                    },
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(product.image),
                          descStack(product),
                          ratingStack(product.rating),
                        ],
                      ),
                    ),

                  ),
                ))
            .toList(),
      );

  Widget bodyData() {
    ProductBloc productBloc = ProductBloc('list','1');
    return StreamBuilder<List<Product>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? productGrid(snapshot.data,context)
              : Center(child: CircularProgressIndicator());
        });
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Added to cart.",
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Products",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
//        bodyData: bodyData(),
      bodyData:ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          print(index); print(items);
          if (index == items.length) {
//            return  bodyData();
            return _buildProgressIndicator();
          } else {
            return  bodyData();
//            return ListTile(title: new Text("Number $index"));
          }
        },
        controller: _scrollController,
      ),

    );
  }


  _pushPage(context,goods_id){

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ShoppingDetailsPage(goods_id);
    },));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
//        ProductBloc productBloc = ProductBloc('list','1');
//        print(productBloc);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<int> newEntries = await fakeRequest(items.length, items.length); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge -offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => i + from);
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }





}
