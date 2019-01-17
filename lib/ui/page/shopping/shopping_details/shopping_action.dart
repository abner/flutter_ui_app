import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/cart_bloc.dart';
import 'package:flutter_uikit/model/product.dart';
import 'package:flutter_uikit/ui/widgets/common_divider.dart';
import 'package:flutter_uikit/ui/widgets/custom_float.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingAction extends StatefulWidget {
  final Product product;
  ShoppingAction({this.product});
  @override
  ShoppingActionState createState() {
    return new ShoppingActionState(this.product);
  }
}

class ShoppingActionState extends State<ShoppingAction> {
  final Product product;
  ShoppingActionState(this.product);
  String _value = "Cyan";
  String _sizeValue = "M";
  String _spec1Value = '';
  String _spec2Value = '';
  String _spec3Value = '';

  Widget colorsCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Colors",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: widget.product.colors
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: pc.color,
                          label: Text(
                            pc.colorName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: _value == pc.colorName,
                          onSelected: (selected) {
                            setState(() {
                              _value = selected ? pc.colorName : null;
                            });
                          }),
                    ))
                .toList(),
          ),
        ],
      );

  Widget sizesCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sizes",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.sizes
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.yellow,
                          label: Text(
                            pc,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: _sizeValue == pc,
                          onSelected: (selected) {
                            setState(() {
                              _sizeValue = selected ? pc : null;
                            });
                          }),
                    ))
                .toList(),
          ),
        ],
      );

//  widget.product.sizes.forEach( (key, value) =>  getMap(key, value) );
  Widget specCard1(specName) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            specName,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.specValueNames1
                .map((sp) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.yellow,
                          label: Text(
                            sp,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: (_spec1Value == ''? this.product.specValueNames1[0] == sp : _spec1Value==sp),
                          onSelected: (selected) {
                            if(sp!=_spec1Value){
                            setState(() {
                              _spec1Value = selected ? sp : this.product.specValueNames1[0];
                            });}
                          }),
                    ))
                .toList(),
          ),
        ],
      );
  Widget specCard2(specName) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            specName,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.specValueNames2
                .map((sp) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.red,
                          label: Text(
                            sp,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: (_spec2Value == ''? this.product.specValueNames2[0] == sp : _spec2Value==sp),
                          onSelected: (selected) {
                     if(sp!=_spec2Value){
                            setState(() {
                              _spec2Value = selected ? sp : this.product.specValueNames2[0];
                            });
                     }
                          }),
                    ))
                .toList(),
          ),
        ],
      );
  Widget specCard3(specName) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            specName,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.specValueNames3
                .map((sp) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.red,
                          label: Text(
                            sp,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: (_spec3Value == ''? this.product.specValueNames3[0] == sp : _spec3Value==sp),
                          onSelected: (selected) {
                    if(sp!=_spec3Value) {
                      setState(() {
                        _spec3Value =
                        selected ? sp : this.product.specValueNames3[0];
                      });
                    }}),
                    ))
                .toList(),
          ),
        ],
      );

  Widget quantityCard() {
    CartBloc cartBloc = CartBloc(widget.product);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Quantity",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomFloat(
              isMini: true,
              icon: FontAwesomeIcons.minus,
              qrCallback: () => cartBloc.subtractionController.add(true),
            ),
            StreamBuilder<int>(
              stream: cartBloc.getCount,
              initialData: 0,
              builder: (context, snapshot) => Text(
                    snapshot.data.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
            ),
            CustomFloat(
              isMini: true,
              icon: FontAwesomeIcons.plus,
              qrCallback: () => cartBloc.additionalController.add(true),
            ),
          ],
        )
      ],
    );
  }

  Widget specInfos(){
    var length = product.specNames.length;
    var tabs = new List<Widget>();

    for(var i = 0;i<length;i++){
   switch(i){
     case 0: tabs.add( specCard1(product.specNames[i]));
     tabs.add( CommonDivider());
     tabs.add(  SizedBox(
       height: 5.0,
     ));
     break;
     case 1: tabs.add( specCard2(product.specNames[i]));
     tabs.add( CommonDivider());
     tabs.add(  SizedBox(
       height: 5.0,
     ));
     break;
     case 2: tabs.add( specCard3(product.specNames[i]));
     tabs.add( CommonDivider());
     tabs.add(  SizedBox(
       height: 5.0,
     ));
     break;
   }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tabs,
    );

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        colorsCard(),
//        CommonDivider(),
//        SizedBox(
//          height: 5.0,
//        ),
//        sizesCard(),
//        CommonDivider(),
//        SizedBox(
//          height: 5.0,
//        ),
        specInfos(),
        CommonDivider(),
        SizedBox(
          height: 5.0,
        ),
        quantityCard(),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
