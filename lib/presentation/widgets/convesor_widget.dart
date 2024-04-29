import 'package:espresso_demo/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class Conversor extends StatefulWidget {
  final String coin;
  final double price;

  const Conversor({super.key, required this.coin, required this.price});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController _coinController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  bool _isUpdating = false;

  @override
  void initState() {
    _currencyController.addListener(_onCurrencyChange);
    _coinController.addListener(_onCoinChange);
    super.initState();
  }

  void _onCurrencyChange() {
    if (!_isUpdating) {
      final currency = double.tryParse(_currencyController.text);

      if (currency != null) {
        setState(() {
          _isUpdating = true;
          _coinController.text = (currency / widget.price).toString();
          _isUpdating = false;
        });
      } else {
        setState(() {
          _coinController.text = '';
        });
      }
    }
  }

  void _onCoinChange() {
    if (!_isUpdating) {
      final coin = double.tryParse(_coinController.text);

      if (coin != null) {
        setState(() {
          _isUpdating = true;
          _currencyController.text = (widget.price * coin).toString();
          _isUpdating = false;
        });
      } else {
        setState(() {
          _currencyController.text = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Conversor'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextFieldWidget(_coinController, title: widget.coin),
                  const SizedBox(width: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Icon(Icons.compare_arrows, size: 30),
                  ),
                  const SizedBox(width: 10),
                  TextFieldWidget(_currencyController, title: '\$USD'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
