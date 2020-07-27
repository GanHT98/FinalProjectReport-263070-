import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fit_shoe/adminproduct.dart';
import 'package:fit_shoe/paymenthistoryscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_shoe/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartscreen.dart';
import 'profilescreen.dart';
import 'package:clippy_flutter/ticket.dart';
import 'package:avatar_glow/avatar_glow.dart';
 
//void main() => runApp(MainScreen());
 
class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key key, this.user}):super(key:key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<RefreshIndicatorState>refreshKey;
  List productdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  bool _isadmin = false;
  String titlecenter = "Loading the cart now";

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadCartQuantity();
    refreshKey = GlobalKey<RefreshIndicatorState>();
   // print("loadshoe");
    if (widget.user.email == "admin@fitshoe.com") {
      _isadmin = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    return WillPopScope(
     onWillPop: _onBackPressed,
        child: Scaffold(
          drawer: mainDrawer(context),
          appBar: AppBar(backgroundColor: Colors.purple[200],
            title: Text(
              'SHOES',
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
          body: RefreshIndicator(
            key: refreshKey,
            color:Colors.purple[700],
            onRefresh: ()async{
              await refreshList();
            },
          
          child: Container(
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
                                    color: Colors.black,
                                  ),
                                  autofocus: false,
                                  controller: _prdController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      border: OutlineInputBorder())),
                            )),
                            Flexible(
                                child: MaterialButton(
                                    color: Colors.blue[300],
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700])),
                productdata == null
                    ? Flexible(
                        child: Container(
                            child: Center(
                                child: Text(
                        titlecenter,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))))
                    : Expanded(
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio:
                                (screenWidth / screenHeight) / 0.9,
                            children:
                                List.generate(productdata.length, (index) {
                              return Container(decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.blue[100],Colors.red[100]],)),
                                  child: Card( 

                                     color: Colors.deepOrange[50],
                                      elevation: 10,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () =>
                                                  _onImageDisplay(index),
                                              child: Container(//color: Colors.white10,
                                                height: screenHeight / 4.9,
                                                width: screenWidth / 2.5,
                                                child: //ClipRect(
                                                  Ticket(
                                                    radius: 30.0,
                                                    child: Container(
                                                    width: double.infinity,
                                                     height: 200.0,
                                                    child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl:
                                                      "http://minemp98.com/fitshoe/image/${productdata[index]['id']}.jpg",
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                )),
                                              ),
                                            )),
                                            Text(productdata[index]['name'],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text(
                                              "RM " +
                                                  productdata[index]['price'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Quantity available:" +
                                                  productdata[index]
                                                      ['quantity'],
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
                                            AvatarGlow(
                                            startDelay: Duration(milliseconds: 1000),
                                            glowColor: Colors.purple,
                                            endRadius: 40.0,
                                            duration: Duration(milliseconds: 2000),
                                            repeat: true,
                                            showTwoGlows: true,
                                            repeatPauseDuration: Duration(milliseconds: 100),
                                            child:MaterialButton(
                                               shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              minWidth: 130,
                                              height: 30,
                                              child: Text(
                                                'ADD ',
                                               
                                              ),
                                              color: Colors.blue[100],
                                              elevation: 10,
                                              onPressed: () =>
                                                  _addtocartdialog(index),

                                              // shape: RoundedRectangleBorder(
                                              //     borderRadius:
                                              //         BorderRadius.circular(
                                              //             20.0)),
                                              // minWidth: 100,
                                              // height: 30,
                                              // child: Text(
                                              //   'Add to Cart',
                                              // ),
                                              // color: Colors.blue[300],
                                              // textColor: Colors.black,
                                              // elevation: 10,
                                              // onPressed: () =>
                                              //     _addtocartdialog(index),
                                            ),
        )],
                                        ),
                                      )));
                            })))
              ],
            ),
          )),
          floatingActionButton: FloatingActionButton.extended(backgroundColor: Colors.deepPurple,
            onPressed: ()async {
              if (widget.user.email == "unregistered") {
                Toast.show("Please register first!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.email == "admin@fitshoe.com") {
                Toast.show("Admin mode!!!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.quantity == "0") {
                Toast.show("Cart empty", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else {
               await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen(
                              user: widget.user,
                            )));
                            _loadData();
                            _loadCartQuantity();
              }
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text(cartquantity),
          ),
        ));
  }

  _onImageDisplay(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              color: Colors.purple[100],
              height: screenHeight / 2.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // GestureDetector(
                  //    onTap: () =>
                  //   _onImage(index),
                  Container(
                      height: screenWidth / 1.5,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(color: Colors.blue[50],
                          //border: Border.all(color: Colors.black),
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(
                                  "http://minemp98.com/fitshoe/image/${productdata[index]['id']}.jpg")))),
                ],
              ),
            ));
      },
    );
  }

  void _loadData() async{
  //  print("loadshoe");
    String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_product.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      //if(res.body.contains("nodata")){
      if(res.body == "nodata"){
      cartquantity ="0";
      titlecenter ="No product found";
      setState(() {
        productdata = null;
      });
    }else{
      setState(() {
        var extractdata = json.decode(res.body);
        productdata = extractdata["products"];
        cartquantity = widget.user.quantity;
      });
    }
    }).catchError((err) {
      print(err);
    });
  }
  void _loadCartQuantity()async{
    String urlLoadJobs = "https://minemp98.com/fitshoe/php/load_cartquantity.php";
    await http.post(urlLoadJobs,body:{
      "email":widget.user.email,
    }).then((res){
      //if(res.body.contains ("nodata")){
      if(res.body == "nodata"){
      }else{
        widget.user.quantity = res.body;
      }
    }).catchError((err){
      print(err);
    });
  }

  Widget mainDrawer(BuildContext context) {
    return Drawer(
      child: Container(color: Colors.pink[50],
      child: ListView(
        children: <Widget>[
         new Container(
              color: Colors.purple[200],
          child:UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple[300],
            ),
            //arrowColor: Colors.deepPurple,
            accountName: Text(widget.user.name,style: TextStyle(color: Colors.black),),
            accountEmail: Text(widget.user.email,style: TextStyle(color: Colors.black87),),
            otherAccountsPictures: <Widget>[
              Text("RM " + widget.user.credit,
                  style: TextStyle(fontSize: 16.0, color: Colors.black)),
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.black
                      : Colors.black,
              child: Text(
                widget.user.name.toString().substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 40.0),
              ),
               backgroundImage: NetworkImage(
                   "http://minemp98.com/fitshoe/profile/${widget.user.email}.jpg?"),
            ),
            onDetailsPressed: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(
                            user: widget.user,
                          )))
            },
         )),
          ListTile(leading: Icon(Icons.message,color: Colors.red[300]),
              title: Text(
                "Product List",
                style: TextStyle(
                  color: Colors.indigo[400], fontWeight:FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () => {
                    Navigator.pop(context),
                    _loadData(),
                  }),
          ListTile(leading: Icon(MdiIcons.shopping,color: Colors.red[300]),
              title: Text(
                "Shopping Cart",
                style: TextStyle(
                  color: Colors.indigo[400],fontWeight:FontWeight.bold
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () => {
                    Navigator.pop(context),
                    gotoCart(),
                  }),
          ListTile(leading: Icon(MdiIcons.history,color: Colors.red[300]),
            title: Text(
              "My Payment History",
              style: TextStyle(
                color: Colors.indigo[400],fontWeight:FontWeight.bold
              ),
            ),
            trailing: Icon(Icons.arrow_right),
            onTap: ()=>{
              Navigator.pop(context),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(BuildContext context)=>PaymentHistoryScreen(
                    user:widget.user,
                  )
                )
              ),
            }
          ),
          ListTile(leading: Icon(MdiIcons.faceProfile, color: Colors.red[300]),
              title: Text(
                "User Profile",
                style: TextStyle(
                  color: Colors.indigo[400],fontWeight:FontWeight.bold
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen(
                                  user: widget.user,
                                )))
                  }),
          Visibility(
            visible: _isadmin,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                Center(
                  child: Text(
                    "Admin Menu",
                    style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold),
                  ),
                ),
                ListTile(leading: Icon(Icons.edit, color: Colors.red[300]),
                    title: Text(
                      "My Products",
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminProduct(
                                        user: widget.user,
                                      )))
                        }),
               
              ],
            ),
          )
        ],
      ),
    ));
  }

  _addtocartdialog(int index) {
    if (widget.user.email == "unregistered@fitshoe.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@fitshoe.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + productdata[index]['name'] + " to Cart?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Select quantity of product",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.blue[400],
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(productdata[index]['quantity']) -
                                        2)) {
                                  quantity++;
                                } else {
                                  Toast.show("Quantity not available", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.blue[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _addtoCart(index);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    )),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    )),
              ],
            );
          });
        });
  }

  void _addtoCart(int index) {
    if(widget.user.email=="unregistered@fitshoe.com"){
      Toast.show("Please register first",context,
      duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM);
      return;
    }
    if(widget.user.email=="admin@fitshoe.com"){
      Toast.show("Admin mode",context,
      duration:Toast.LENGTH_LONG, gravity:Toast.BOTTOM);
      return;
    }
    try {
      int cquantity = int.parse(productdata[index]["quantity"]);
      print(cquantity);
      print(productdata[index]["id"]);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs =
            "https://minemp98.com/fitshoe/php/insert_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "proid": productdata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
         // if (res.body.contains("failed")) {
          if (res.body == "failed") {
            Toast.show("Failed add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartquantity = respond[1];
              widget.user.quantity=cartquantity;
            });
            Toast.show("Success add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          pr.dismiss();
        }).catchError((err) {
          print(err);
          pr.dismiss();
        });
        pr.dismiss();
      } else {
        Toast.show("Out of stock", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Failed add to cart", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortItem(String type) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs ="https://minemp98.com/fitshoe/php/load_product.php";
      http.post(urlLoadJobs, body: {
        "type": type,
      }).then((res) {
        if(res.body.contains("nodata")){
       // if(res.body=="nodata"){
          setState(() {
            productdata=null;
            curtype=type;
            titlecenter="Opps, no product available now ><'";
          });
          pr.dismiss();
        }else{
            setState(() {
              curtype=type;
            var extractdata=json.decode(res.body);
            productdata =extractdata["products"];
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
      String urlLoadJobs =
          "https://minemp98.com/fitshoe/php/load_product.php";
      http
          .post(urlLoadJobs, body: {
            "name": prname.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if (res.body.contains("nodata")) {
           // if (res.body == "nodata") {
              Toast.show("Product not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              pr.dismiss();
              setState(() {
                titlecenter="Product No Found";
                curtype="search for"+""+prname+"";
                productdata=null;
              });
              FocusScope.of(context).requestFocus(new FocusNode());
              return;
            }else{
            setState(() {
              var extractdata = json.decode(res.body);
              productdata = extractdata["products"];
              FocusScope.of(context).requestFocus(new FocusNode());
              curtype = "search for"+""+prname+"";
              pr.dismiss();
            });}
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

  gotoCart()async {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.email == "admin@fitshoe.com") {
      Toast.show("Admin mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.quantity == "0") {
      Toast.show("Cart empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
                  _loadData();
                  _loadCartQuantity();
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.blue[300],
                    ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue[300],
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }
  
   Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    //_getLocation();
    _loadData();
    return null;
  }
}

