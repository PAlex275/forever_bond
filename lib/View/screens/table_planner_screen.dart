import 'package:flutter/material.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';

class TablePlannerScreen extends StatefulWidget {
  const TablePlannerScreen({super.key});
  static const String routeName = '/tables';

  @override
  _TablePlannerScreenState createState() => _TablePlannerScreenState();
}

class _TablePlannerScreenState extends State<TablePlannerScreen> {
  Dashboard dashboard = Dashboard();
  List<Table> tables = [
    Table(id: '1', capacity: 4, position: const Offset(100.0, 100.0)),
    Table(id: '2', capacity: 6, position: const Offset(300.0, 200.0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Planner'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: FlowChart(
          dashboard: dashboard,
          onDashboardTapped: (context, position) {
            // Handle dashboard tap
          },
          onHandlerPressed: (context, position, handler, element) {
            // Handle handler press
          },
          onHandlerLongPressed: (context, position, handler, element) {
            // Handle handler long press
          },
          onScaleUpdate: (newScale) {
            // Handle scale update
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTable,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTable() {
    setState(() {
      final id = UniqueKey().toString();
      final table =
          Table(id: id, capacity: 4, position: const Offset(50.0, 50.0));
      tables.add(table);
      _addElementToDashboard(table);
    });
  }

  void _addElementToDashboard(Table table) {
    final flowElement = FlowElement(
      position: table.position,
      size: const Size(100, 100),
      text: 'Table ${table.id}',
      kind: ElementKind.oval,
      handlers: [
        Handler.bottomCenter,
        Handler.topCenter,
        Handler.leftCenter,
        Handler.rightCenter,
      ],
    );
    dashboard.addElement(flowElement);
  }
}

class Table {
  final String id;
  final int capacity;
  Offset position;

  Table({required this.id, required this.capacity, required this.position});
}
