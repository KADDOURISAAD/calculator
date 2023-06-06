import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbutton(String btntext,Color ?btncolor,Color textcolor ){
     return Container(
       child: MaterialButton(
         onPressed: (){
            calculation(btntext);
         },
         child: Text(btntext,
           style: TextStyle(
             fontSize: 35,
             color: textcolor,
           ),
         ),
         shape: CircleBorder(),
         color: btncolor,
         padding: EdgeInsets.all(20),
       ),
     );
  }
  Widget zerobutton(String btntext,Color ?btncolor,Color textcolor ){
    return Container(
      child: MaterialButton(
        onPressed: (){
          calculation(btntext);
        },
        child: Text(btntext,
          style: TextStyle(
            fontSize: 35,
            color: textcolor,
          ),
        ),
        shape: StadiumBorder(),
        color: btncolor,
        padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
           color: Colors.black,
        ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  Text(
                      text,
                    textAlign: TextAlign.left,
                    style:  TextStyle(
                      fontSize: 100,
                    ),
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called
                calcbutton("AC",Colors.grey,Colors.black),
                calcbutton("+/-",Colors.grey,Colors.black),
                calcbutton("%",Colors.grey,Colors.black),
                calcbutton("/",Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called
                calcbutton("7",Colors.grey[850],Colors.white),
                calcbutton("8",Colors.grey[850],Colors.white),
                calcbutton("9",Colors.grey[850],Colors.white),
                calcbutton("x",Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called
                calcbutton("4",Colors.grey[850],Colors.white),
                calcbutton("5",Colors.grey[850],Colors.white),
                calcbutton("6",Colors.grey[850],Colors.white),
                calcbutton("-",Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // button functions will be called
                calcbutton("1",Colors.grey[850],Colors.white),
                calcbutton("2",Colors.grey[850],Colors.white),
                calcbutton("3",Colors.grey[850],Colors.white),
                calcbutton("+",Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                zerobutton("0",Colors.grey[850],Colors.white),
                calcbutton(".",Colors.blue,Colors.white),
                calcbutton("=",Colors.blue,Colors.white),

              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }


}




