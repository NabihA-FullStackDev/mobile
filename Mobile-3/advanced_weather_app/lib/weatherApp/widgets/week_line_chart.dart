import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeekLineChart extends StatelessWidget {
  final List<String> date;
  final List<double> tempMin;
  final List<double> tempMax;

  const WeekLineChart({
    Key? key,
    required this.date,
    required this.tempMin,
    required this.tempMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color lineMin = Colors.white;
    Color lineMax = Colors.orange;
    Color legends = const Color.fromARGB(255, 0, 137, 205);

    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.85,
      child: LineChart(
        LineChartData(
          maxX: date.length - 1,
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
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(
              axisNameSize: 42,
              axisNameWidget: SizedBox(
                height: 300,
                child: Text(
                  "Weather of the Week",
                  style: TextStyle(
                    color: legends,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameSize: 30,
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    date.elementAt(value.toInt()).substring(5),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: legends,
                    ),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                tempMin.length,
                (index) => FlSpot(index.toDouble(), tempMin[index]),
              ),
              isCurved: true,
              barWidth: 3,
              color: lineMin,
            ),
            LineChartBarData(
              spots: List.generate(
                tempMax.length,
                (index) => FlSpot(index.toDouble(), tempMax[index]),
              ),
              isCurved: true,
              barWidth: 3,
              color: lineMax,
            ),
          ],
        ),
      ),
    );
  }
}
