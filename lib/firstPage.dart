import 'package:blockchain_app/ethereum_utils.dart';
import 'package:blockchain_app/home_page.dart';
import 'package:blockchain_app/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  EthereumUtils ethUtils = EthereumUtils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ethUtils.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.only(right: 3),
              child: TextField(
                controller: provider.ownerController,
                decoration: InputDecoration(
                    hintText: 'amount',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            title: "treansfer",
            ontapfun: () {
              ethUtils.addOwner(provider.ownerController.text.trim());
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      );
    }));
  }
}
