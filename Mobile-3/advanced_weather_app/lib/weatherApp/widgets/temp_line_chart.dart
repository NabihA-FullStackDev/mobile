import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TempLineChart extends StatelessWidget {
  final List<String> hours;
  final List<double> temperatures;

  const TempLineChart({
    Key? key,
    required this.hours,
    required this.temperatures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color line = const Color.fromARGB(255, 225, 129, 161);
    Color legends = const Color.fromARGB(255, 0, 137, 205);

    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.85,
      child: LineChart(
        LineChartData(
          maxX: hours.length - 1,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameSize: 15,
              sideTitles: SideTitles(
                reservedSize: 30,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: legends,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 4,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < hours.length) {
                    return Text(
                      hours[index].split('T')[1],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: legends,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(
              axisNameSize: 42,
              axisNameWidget: Text(
                "Weather of the day",
                style: TextStyle(
                  color: legends,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                temperatures.length,
                (index) => FlSpot(index.toDouble(), temperatures[index]),
              ),
              isCurved: true,
              barWidth: 3,
              color: line,
            ),
          ],
        ),
      ),
    );
  }
}
