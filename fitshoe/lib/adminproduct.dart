import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fit_shoe/editproduct.dart';
import 'package:fit_shoe/newproduct.dart';
import 'package:fit_shoe/product.dart';
import 'package:fit_shoe/user.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartscreen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

 
//void main() => runApp(MyApp());
 
class AdminProduct extends StatefulWidget {
   final User user;
   const AdminProduct({Key key, this.user}) : super(key: key);

  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  List productdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  String titlecenter = "No product found";
  var _tapPosition;
  String scanPrId;
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple[200],
          title: Text(
            'Manage Your Products',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: _visible
                  ? new Icon(Icons.expand_more)
                  : new Icon(Icons.expand_less),
              onPressed: () {
                setState(() {
                  if (_visible) {
                    _visible = false;
                  } else {
                    _visible = true;
                  }
                });
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _visible,
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                        onPressed: () => _sortItem("Recent"),
                                        color:
                                            Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                           // Icon(MdiIcons.update,
                                             //   color: Colors.black),
                                            Text(
                                              "Recent",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Boots"),
                                        color:
                                            Colors.tealAccent[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            // Icon(
                                            //   MdiIcons.shoePrint,
                                            //   color: Colors.black,
                                            // ),
                                            Text(
                                              "Boots",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            _sortItem("Formal"),
                                        color:
                                            Colors.tealAccent[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            // Icon(
                                            //   MdiIcons.shoeFormal,
                                            //   color: Colors.black,
                                            // ),
                                            Text(
                                              "Formal",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Sandals"),
                                        color:
                                            Colors.tealAccent[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            // Icon(
                                            //   MdiIcons.shoePrint,
                                            //   color: Colors.black,
                                            // ),
                                            Text(
                                              "Sandals",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Sneakers"),
                                        color:
                                            Colors.tealAccent[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            // Icon(
                                            //   MdiIcons.shoePrint,
                                            //   color: Colors.black,
                                            // ),
                                            Text(
                                              "Sneakers",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Sports"),
                                        color:
                                            Colors.tealAccent[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            // Icon(
                                            //   MdiIcons.shoePrint,
                                            //   color: Colors.black,
                                            // ),
                                            Text(
                                              "Sports",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Others"),
                                        color:
                                            Colors.blue[300],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          // Replace with a Row for horizontal icon + text
                                          children: <Widget>[
                                            Icon(
                                              MdiIcons.more,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              "Others",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ))),
                ),
              Visibility(
                  visible: _visible,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: screenHeight / 12.5,
                      margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            height: 30,
                            child: TextField(
                                style: TextStyle(
                                  color: Colors.purple[50],
                                ),
                                autofocus: false,
                                controller: _prdController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.search),
                                    border: OutlineInputBorder())),
                          )),
                          Flexible(
                              child: MaterialButton(
                                  color: Colors.purple[200],
                                  onPressed: () =>
                                      {_sortItembyName(_prdController.text)},
                                  elevation: 5,
                                  child: Text(
                                    "Search Product",
                                    style: TextStyle(color: Colors.black),
                                  )))
                        ],
                      ),
                    ),
                  )),
              Text(curtype,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
               productdata == null? Flexible(
                          child: Container(
                              child: Center(
                                  child: Text(
                          titlecenter,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ))))
              :Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.65,
                      children: List.generate(productdata.length, (index) {
                        return Container(
                            child: InkWell(
                                onTap: () => _showPopupMenu(index),
                                onTapDown: _storePosition,
                                child: Card(color: Colors.deepOrange[50],
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(color: Colors.yellow[100],
                                            height: screenHeight / 5.9,
                                            width: screenWidth / 3.5,
                                            child: ClipRect(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    "http://minemp98.com/fitshoe/image/${productdata[index]['id']}.jpg",
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Text(productdata[index]['name'],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          Text(
                                            "RM " + productdata[index]['price'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                         Text(
                                              "Avail/Bought:" +
                                                  productdata[index]
                                                      ['quantity'] +
                                                   "/" +
                                                  productdata[index]['bought'],
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),              
                                          Text(
                                            "Weight:" +
                                                productdata[index]['weigth'] +
                                                " gram",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))));
                      })))
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,backgroundColor: Colors.blue,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add_box),backgroundColor: Colors.blue[300],
                label: "New Product",
                labelBackgroundColor: Colors.blue[50],
                onTap: createNewProduct),
            SpeedDialChild(
              child:Icon(MdiIcons.barcodeScan), backgroundColor: Colors.blue[300],
              label: "Scan Product",
              labelBackgroundColor: Colors.blue[50],
              onTap: ()=>scanProductDialog()),
            
          ],
        ),
      );
    }
    
  void scanProductDialog(){
    showDialog(
      context:context,
      builder: (BuildContext context){
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              "Select scan options:",
              style:TextStyle(color:Colors.black,),
            ),
              content:Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MaterialButton(
                    color:Colors.blue,
                    onPressed: scanBarcodeNormal,
                  elevation: 5,
                  child: Text(
                    "Bar Code",
                    style: TextStyle(color: Colors.black),
                  )),
              MaterialButton(
                  color: Colors.blue,
                  onPressed: scanQR,
                  elevation: 5,
                  child: Text(
                    "QR Code",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        );
      },
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

   
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }

  void _loadSingleProduct(String prid) {
    String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_product.php";
    http.post(urlLoadJobs, body: {
      "prid": prid,
    }).then((res) {
      print(res.body);
      if(res.body.contains("nodata")){
      //if (res.body == "nodata") {
        Toast.show("Not found", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          productdata = extractdata["products"];
          print(productdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }

  void _loadData() {
    String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_product.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      print(res.body);
      setState(() {
        var extractdata = json.decode(res.body);
        productdata = extractdata["products"];
        cartquantity = widget.user.quantity;
      });
    }).catchError((err) {
      print(err);
    });
  }

  void _sortItem(String type) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_product.php";
      http.post(urlLoadJobs, body: {
        "type": type,
      }).then((res) {
        if(res.body.contains("nodata")){
        //if (res.body == "nodata") {
          setState(() {
            curtype = type;
            titlecenter = "No product found";
            productdata = null;
          });
          pr.dismiss();
          return;
        } else {
          setState(() {
            curtype = type;
            var extractdata = json.decode(res.body);
            productdata = extractdata["products"];
            FocusScope.of(context).requestFocus(new FocusNode());
            pr.dismiss();
          });
        }
      }).catchError((err) {
        print(err);
        pr.dismiss();
      });
      pr.dismiss();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortItembyName(String prname) {
    try {
      print(prname);
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_product.php";
      http
          .post(urlLoadJobs, body: {
            "name": prname.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if(res.body.contains("nodata")){
            //if (res.body == "nodata") {
              Toast.show("Product not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              pr.dismiss();
              FocusScope.of(context).requestFocus(new FocusNode());
              return;
            }
            setState(() {
              var extractdata = json.decode(res.body);
              productdata = extractdata["products"];
              FocusScope.of(context).requestFocus(new FocusNode());
              curtype = prname;
              pr.dismiss();
            });
          })
          .catchError((err) {
            pr.dismiss();
          });
      pr.dismiss();
    } on TimeoutException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on SocketException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  gotoCart() {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
    }
  }

  _onProductDetail(int index) async {
    print(productdata[index]['name']);
    Product product = new Product(
        pid: productdata[index]['id'],
        name: productdata[index]['name'],
        price: productdata[index]['price'],
        quantity: productdata[index]['quantity'],
        weigth: productdata[index]['weight'],
        type: productdata[index]['type'],
        date: productdata[index]['date']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditProduct(
                  user: widget.user,
                  product: product,
                )));
    _loadData();
  }

  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      color: Colors.purple[50],
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        //onLongPress: () => _showPopupMenu(), //onLongTapCard(index),

        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _onProductDetail(index)},
              child: Text(
                "Update Product?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _deleteProductDialog(index)},
              child: Text(
                "Delete Product?",
                style: TextStyle(color: Colors.blue),
              )),
        ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _deleteProductDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Delete Product ID " + productdata[index]['id'],
            style: TextStyle(
              color: Colors.blue[900],
            ),
          ),
          content:
              new Text("Are you sure?", style: TextStyle(color: Colors.blue)),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(index);
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Deleting product...");
    pr.show();
    String prid = productdata[index]['id'];
    print("prid:"+prid);
    http.post("https://minemp98.com/fitshoe/php/delete_product.php", body: {
      "prodid": prid,
    }).then((res) {
      print(res.body);
      pr.dismiss();
      if(res.body.contains("success")){
      //if (res.body == "success") {
        Toast.show("Delete success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadData();
        Navigator.of(context).pop();
      } else {
        Toast.show("Delete failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
  }

  Future<void> createNewProduct() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewProduct()));
    _loadData();
  }
}
