import 'package:espresso_demo/domain/entities/pricing.dart';
import 'package:espresso_demo/utils/datetime_extension.dart';
import 'package:espresso_demo/utils/double_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PricingChartWidget extends StatelessWidget {
  final List<Pricing> price;

  final noTile = const AxisTitles(sideTitles: SideTitles(showTitles: false));

  double get min =>
      reducePrice.map((e) => e.price).reduce((a, b) => a < b ? a : b);

  double get max =>
      reducePrice.map((e) => e.price).reduce((a, b) => a > b ? a : b);

  List<Pricing> get reducePrice {
    final List<Pricing> reduced = [];
    var lenght = price.length ~/ 50;
    for (var i = 0; i < price.length; i += 2) {
      if (i % lenght == 0) reduced.add(price[i]);
    }
    return reduced;
  }

  const PricingChartWidget({super.key, required this.price});

  final Color color = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color.withOpacity(0.3),
          border: Border.all(color: color),
        ),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 25,
          bottom: 10,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final currency = touchedSpot.y;
                    final date = reducePrice[touchedSpot.x.toInt()].date;
                    return LineTooltipItem(
                      '\$${currency.formatCurrency()}\n',
                      const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: date.formatDate(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
              handleBuiltInTouches: true,
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: reducePrice
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value.price))
                    .toList(),
                isCurved: true,
                dotData: const FlDotData(show: false),
                color: color,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color, color.withOpacity(0)],
                  ),
                ),
              ),
            ],
            maxX: reducePrice.length.toDouble() - 1,
            minY: min + (min - max) * 0.2,
            maxY: max,
            titlesData: FlTitlesData(
              rightTitles: noTile,
              topTitles: noTile,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  interval: reducePrice.length.toDouble() / 6,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (meta.min == value || meta.max == value) {
                      return Icon(
                        Icons.circle,
                        color: Colors.teal.withAlpha(100),
                        size: 10,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        reducePrice[value.toInt()].date.formatDate(),
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: noTile,
            ),
          ),
        ),
      ),
    );
  }
}
