import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/viewmodel/product_view_model.dart';
import 'package:flutter_uikit/model/product.dart';
import 'package:flutter_uikit/api/common_api.dart';


class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();
  List<Product> productsItems;
  Stream<List<Product>> get productItems => productController.stream;
  ProductBloc(String type, page) {
//    productController.add(productViewModel.getProducts());
    if (type == 'list') {
      api.goodsList(page).then((goodslist) {
        var prolist = new List<Product>();
        if(goodslist==null) return prolist;
        for (var goods_info in goodslist) {
          prolist.add(Product(
              goods_id: goods_info['goods_id'],
              brand: goods_info['goods_name'],
              description: goods_info['goods_name'],
              image: goods_info['goods_image'],
              name: goods_info['goods_name'],
              price: goods_info['goods_price'],
              rating: double.parse(goods_info['sort'].toString()),
              totalReviews: int.parse(goods_info['selected_num'].toString())));
        }
        getProducts() => prolist;
        productController.add(getProducts());
        return prolist;
      });
    }

    if(type=='detail'){
      api.goodsDetail(page).then((goodsdetail){
        var goodsImages = goodsdetail['goods_image'];
        var goodsInfo = goodsdetail['goods_info'];
        var specNames =new List();
        var specValueNames =new List();
        var imgs = new List<String>();
        var bimgs = new List<String>();
        for(var img in goodsImages){
          imgs.add(img['medium_image'].toString());
          bimgs.add(img['average_image'].toString());
        }
        if(goodsInfo['spec_name']!=null){
        for(var spec in goodsInfo['spec_name']){
          var specOne = goodsInfo['spec_value'][spec['spec_value'].toString()];
          specNames.add(spec['spec_name'].toString()) ;
           if(specOne!=null)    specValueNames.add(specOne.values.toList()) ;
        }}
        var spec1 = specValueNames.length > 0 ? specValueNames[0] : [];
        var spec2 = specValueNames.length > 1 ? specValueNames[1] : [];
        var spec3 = specValueNames.length > 2 ? specValueNames[2] : [];

        var proinfo = new List<Product>();
        proinfo.add(Product(
            brand:  goodsInfo['brand_name'],
            description: goodsInfo['goods_jingle'],
            image: goodsInfo['goods_image'],
            name: goodsInfo['goods_name'],
            price: goodsInfo['goods_promotion_price'].toString(),
            rating: 4.0,
            specNames: specNames,
            specValueNames1: spec1,
            specValueNames2: spec2,
            specValueNames3: spec3,
            smallimages: imgs,
            bigimages: bimgs,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170));
        getPro() => proinfo;
        productController.add(getPro());
      });
    }

    if(type=='default'){
      productController.add(productViewModel.getProducts());
    }


  }
}

