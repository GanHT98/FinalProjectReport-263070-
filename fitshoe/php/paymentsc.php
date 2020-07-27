<?php
error_reporting(0);
include_once("dbconnect.php");
$userid = $_POST['userid'];
$amount = $_POST['amount'];
$orderid = $_POST['orderid'];
$newcr = $_POST['newcr'];
$receiptid ="storecr";

 $sqlcart ="SELECT CART.PRODID, CART.CQUANTITY, SHOE.PRICE FROM CART INNER JOIN SHOE ON CART.PRODID = SHOE.ID WHERE CART.EMAIL = '$userid'";
        $cartresult = $conn->query($sqlcart);
        if ($cartresult->num_rows > 0)
        {
        while ($row = $cartresult->fetch_assoc())
        {
            $prodid = $row["PRODID"];
            $cq = $row["CQUANTITY"]; //cart qty
           
            $sqlinsertcarthistory = "INSERT INTO CARTHISTORY(EMAIL,ORDERID,PRODID,BILLID,CQUANTITY) VALUES ('$userid','$orderid','$prodid','$receiptid','$cq')";
            $conn->query($sqlinsertcarthistory);
            
            $selectproduct = "SELECT * FROM SHOE WHERE ID = '$prodid'";
            $productresult = $conn->query($selectproduct);
             if ($productresult->num_rows > 0){
                  while ($rowp = $productresult->fetch_assoc()){
                    $prquantity = $rowp["QUANTITY"];
                    $prevbought = $rowp["BOUGHT"];
                    $newquantity = $prquantity - $cq; //quantity in store - quantity ordered by user
                    $newbought = $prevbought + $cq;
                    $sqlupdatequantity = "UPDATE SHOE SET QUANTITY = '$newquantity', BOUGHT = '$newbought' WHERE ID = '$prodid'";
                    $conn->query($sqlupdatequantity);
                  }
             }
        }
        
       $sqldeletecart = "DELETE FROM CART WHERE EMAIL = '$userid'";
       $sqlinsert = "INSERT INTO PAYMENT(ORDERID,BILLID,USERID,TOTAL) VALUES ('$orderid','$receiptid','$userid','$amount')";
       $sqlupdatecredit = "UPDATE USER SET CREDIT = '$newcr' WHERE EMAIL = '$userid'";
        
       $conn->query($sqldeletecart);
       $conn->query($sqlinsert);
       $conn->query($sqlupdatecredit);
       echo "success";
        }else{
            echo "failed";
        }

?>