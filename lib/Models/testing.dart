/*
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  String productID = "consumable_id";
  InAppPurchaseConnection _inAppPurchaseConnection =
      InAppPurchaseConnection.instance;
  bool available = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription _subscription;
  int credits = 0;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize()async{
    available=await _inAppPurchaseConnection.isAvailable();
    print(available.toString()+" available");
    if(available){
      await _getProducts();
      await _getPastPurchases();
      List<Future> futures=[
        _getProducts(),_getPastPurchases()
      ];
      await Future.wait(futures);
      _verifyPurchase();
      _subscription=_inAppPurchaseConnection.purchaseUpdatedStream.listen((data)=>setState((){
        print("new purch");
        _purchases.addAll(data);
        _verifyPurchase();
      }));
    }else{

    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("asd",style: TextStyle(color: Colors.black,fontSize: 40),),
            for (var prod in _products)
              if (_hasPurchased(prod.id) != null) ...[
                Text(credits.toString()),
                FlatButton(
                  child: Text("Premium Ol"),
                  onPressed: () => _spendCredits(_hasPurchased(prod.id)),
                )
              ]
            else ...[
              Text(prod.title),
              Text(prod.description),
              Text(prod.price),
                FlatButton(child: Text("Al"),onPressed: satinal(prod),)
              ]
          ],
        ),
      ),
    );
  }

  satinal(ProductDetails prod) async {
    final PurchaseParam purchaseParam=PurchaseParam(productDetails: prod);
    //_inAppPurchaseConnection.buyNonConsumable(purchaseParam: purchaseParam);
    _inAppPurchaseConnection.buyConsumable(purchaseParam: purchaseParam,autoConsume: false);

  }

  _spendCredits(PurchaseDetails purchase)async{
    setState(() {
      credits--;
    });

    if(credits==0){
      var res=await _inAppPurchaseConnection.consumePurchase(purchase);
      await _getPastPurchases();
    }
  }

  Future<void> _getProducts()async{
    Set<String> ids=Set.from([productID]);
    ProductDetailsResponse response=await _inAppPurchaseConnection.queryProductDetails(ids);

    setState(() {
      _products=response.productDetails;
      print(_products);
    });

  }

  Future<void> _getPastPurchases()async{
    QueryPurchaseDetailsResponse response=await _inAppPurchaseConnection.queryPastPurchases();
    for(var purchase in response.pastPurchases){
      if(Platform.isIOS){
        _inAppPurchaseConnection.completePurchase(purchase);
      }
    }

    setState(() {
      _purchases=response.pastPurchases;
    });
  }

  PurchaseDetails _hasPurchased(String productID){
    return _purchases.firstWhere((purchase) => purchase.productID==productID,orElse: ()=>null);
  }

  void _verifyPurchase(){
    PurchaseDetails purchase =_hasPurchased(productID);
    if(purchase!=null&&purchase.status==PurchaseStatus.purchased){
      credits=10;
    }
  }
}
*/
