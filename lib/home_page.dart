import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'ethereum_utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _value = 0;
  EthereumUtils ethUtils = EthereumUtils();
  BigInt? _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ethUtils.initial();
    ethUtils.getBalance().then((value) {
      _data = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my app'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    'current balance',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _data == null
                      ? CircularProgressIndicator()
                      : Text(
                          '${_data!.toInt()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                ],
              ),
            ),
          ),
          SfSlider(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            interval: 1,
            activeColor: Colors.white,
            enableTooltip: true,
            stepSize: 1.0,
            showLabels: true,
            min: 0,
            max: 10,
          ),
          SizedBox(
            height: 70,
          ),
          CustomButton(
            title: 'get balance',
            ontapfun: () {
              ethUtils.getBalance().then((value) {
                _data = value;
                setState(() {});
              });
            },
          ),
          CustomButton(
            title: 'send balance',
            ontapfun: () async {
              //  await ethUtils.sendBalance(_value!.toInt());
              if (_value == 0) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDalogIncorrectSend();
                    });
              } else {
                await ethUtils.sendBalance(_value!.toInt()).then((value) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDalogCorrectSend();
                      });
                });

                ethUtils.getBalance().then((value) {
                  _data = value;
                  setState(() {});
                });
              }
            },
          ),
          CustomButton(
            title: 'withdraw ',
            ontapfun: () async {
              //|| (_value!.toInt() > _data)
              if (_value == 0 || _value! > _data!.toDouble()) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDalogInCorrectWithdraw();
                    });
              } else {
                await ethUtils.withDrawBalance(_value!.toInt()).then((value) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDalogCorrectWithdraw();
                      });
                });

                ethUtils.getBalance().then((value) {
                  _data = value;
                  setState(() {});
                });
              }
            },
          ),
          //   },
          // ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  String? title;
  Function()? ontapfun;
  CustomButton({this.title, this.ontapfun});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapfun,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Center(child: Text('${title}')),
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.blue[200]),
      ),
    );
  }
}

class CustomDalogIncorrectSend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Column(
          children: [
            Center(child: Text('Invaild value')),
            Center(
              child: Text('Please put value greater than 0'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'))
          ],
        ),
      ),
    );
  }
}

class CustomDalogInCorrectWithdraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Column(
          children: [
            Center(child: Text('Invaild value')),
            Center(
              child: Text('Not have this value to withdraw'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'))
          ],
        ),
      ),
    );
  }
}

class CustomDalogCorrectSend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Column(
          children: [
            Center(child: Text('success send')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'))
          ],
        ),
      ),
    );
  }
}

class CustomDalogCorrectWithdraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Column(
          children: [
            Center(child: Text('success withdraw')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'))
          ],
        ),
      ),
    );
  }
}
