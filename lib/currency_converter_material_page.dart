import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  void convert() {
    try {
      result = double.parse(textEditingController.text) * 80;
      if (result.isNaN) throw Exception("Nan");
    } catch (e) {
      result = 0;

      MotionToast(
        displaySideBar: true,
        icon: Icons.warning_outlined,
        primaryColor: Colors.black,
        secondaryColor: Colors.orange.shade400,
        backgroundType: BackgroundType.solid,
        title: Text(
          'Invalid input',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        description: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            textEditingController.text.isEmpty
                ? 'Please provide a numeric amount'
                : '"${textEditingController.text}" is invalid. Provide a number.',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, .85),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        position: MotionToastPosition.bottom,
        animationType: AnimationType.fromLeft,
        height: 100,
        width: 300,
        displayBorder: false,
        animationDuration: Duration(milliseconds: 200),
        toastDuration: const Duration(seconds: 3),
      ).show(context);
    }
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(60)),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text('Currency Converter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (result > 0)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.shade100),
                  child: FittedBox(
                    child: Text(
                      '₹ ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              TextField(
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                controller: textEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: convert,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
