import 'dart:ffi';

import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/exchange_model.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatefulWidget {
  List<coins> coinList;
  final Function updateExCoin;
  final int userID;
  final Exchange previousCoin;
  UpdateDialog(
      {Key? key,
      required this.coinList,
      required this.updateExCoin,
      required this.userID,
      required this.previousCoin})
      : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  late String _chosenCoin;
  var binanceCheckEnabled = false;
  var FTXCheckEnabled = false;
  var octaFXCheckEnabled = false;

  late TextEditingController binanceInput;

  late TextEditingController binanceBuyInput;
  late TextEditingController FTXInput;
  late TextEditingController FTXBuyInput;
  late TextEditingController octaFXInput;
  late TextEditingController octaFXBuyInput;

  double enteredBinaceInput = 0;
  double enteredBinaceBuyInput = 0;

  double enteredFTXInput = 0;
  double enteredFTXBuyInput = 0;
  double enteredOctaInput = 0;
  double enteredOctaBuyInput = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chosenCoin = widget.coinList.first.coinName;
    binanceInput =
        TextEditingController(text: widget.previousCoin.Binance.toString());
          binanceBuyInput=
        TextEditingController(text: widget.previousCoin.BinaceBuyPrice.toString());
          FTXInput =
        TextEditingController(text: widget.previousCoin.FTX.toString());
          FTXBuyInput =
        TextEditingController(text: widget.previousCoin.FTXBuyPrice.toString());
          octaFXInput =
        TextEditingController(text: widget.previousCoin.OctaFX.toString());
          octaFXBuyInput =
        TextEditingController(text: widget.previousCoin.OctaFXBuyPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Dialog(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: 4,
              ),
              DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _chosenCoin,

                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: widget.coinList
                      .map((coin) => coin.coinName as String)
                      .toList()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a langauage",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _chosenCoin = value.toString();
                    });
                  }),
              Row(
                children: [
                  Checkbox(
                    value: binanceCheckEnabled,
                    onChanged: (newValue) {
                      setState(() {
                        binanceCheckEnabled = newValue as bool;
                      });
                    },
                  ),
                  Text("Binance"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      enabled: binanceCheckEnabled,
                      controller: binanceInput,
                      decoration: InputDecoration(
                          labelText: 'Holdings',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,
                      //flutter returns value
                    ),
                    TextField(
                      enabled: binanceCheckEnabled,
                      controller: binanceBuyInput,
                      decoration: InputDecoration(
                          labelText: 'Bought Price',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,

                      //flutter returns value
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: FTXCheckEnabled,
                    onChanged: (newValue) {
                      setState(() {
                        FTXCheckEnabled = newValue as bool;
                      });
                    },
                  ),
                  Text("FTX"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      enabled: FTXCheckEnabled,
                      controller: FTXInput,
                      decoration: InputDecoration(
                          labelText: 'Holdings',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,
                      //flutter returns value
                    ),
                    TextField(
                      enabled: FTXCheckEnabled,
                      controller: FTXBuyInput,
                      decoration: InputDecoration(
                          labelText: 'Bought Price',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,
                      //flutter returns value
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: octaFXCheckEnabled,
                    onChanged: (newValue) {
                      setState(() {
                        octaFXCheckEnabled = newValue as bool;
                      });
                    },
                  ),
                  Text("Octa FX"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      enabled: octaFXCheckEnabled,
                      controller: octaFXInput,
                      decoration: InputDecoration(
                          labelText: 'Holdings',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,
                      //flutter returns value
                    ),
                    TextField(
                      enabled: octaFXCheckEnabled,
                      controller: octaFXBuyInput,
                      decoration: InputDecoration(
                          labelText: 'Bought Price',
                          labelStyle: Theme.of(context).textTheme.bodyText2),
                      keyboardType: TextInputType.number,
                      //flutter returns value
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: submitData, child: Text("ADD"))
            ]),
          ),
        ),
      ],
    );
  }

  void submitData() {
    if (binanceInput.text.isNotEmpty) {
      enteredBinaceInput = double.parse(binanceInput.text);
    }
    if (binanceBuyInput.text.isNotEmpty) {
      enteredBinaceBuyInput = double.parse(binanceBuyInput.text);
    }
    if (FTXInput.text.isNotEmpty) {
      enteredFTXInput = double.parse(FTXInput.text);
    }
    if (FTXBuyInput.text.isNotEmpty) {
      enteredFTXBuyInput = double.parse(FTXBuyInput.text);
    }
    if (octaFXInput.text.isNotEmpty) {
      enteredOctaInput = double.parse(octaFXInput.text);
    }
    if (octaFXBuyInput.text.isNotEmpty) {
      enteredOctaBuyInput = double.parse(octaFXBuyInput.text);
    }

    if (enteredBinaceInput < 0 || enteredBinaceBuyInput < 0) return;

    final coinID = widget.coinList
        .firstWhere((element) => element.coinName == _chosenCoin)
        .coinID;
    Exchange exCoin = Exchange(
        userID: widget.userID,
        BinaceBuyPrice: enteredBinaceBuyInput,
        Binance: enteredBinaceInput,
        FTX: enteredFTXInput,
        FTXBuyPrice: enteredFTXBuyInput,
        OctaFX: enteredOctaInput,
        OctaFXBuyPrice: enteredOctaBuyInput,
        coinID: coinID);

    widget.updateExCoin(exCoin);

    Navigator.of(context).pop();
  }
}
