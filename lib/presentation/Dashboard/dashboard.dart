import 'package:deciml_assignment/presentation/AddTransaction.dart';
import 'package:deciml_assignment/presentation/Dashboard/cubit/dashboard_cubit.dart';
import 'package:deciml_assignment/presentation/Dashboard/widgets/incomeExpenseCard.dart';
import 'package:deciml_assignment/utils/constants.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var box = Hive.box('Currencies');
  late Map<String, double> dataMap; 
  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final dashCubit = context.read<DashboardCubit>();
    dashCubit.getTransactionStats();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
          centerTitle: true,
          title: const Text(
            "Home",
         
          ),
        ),
        body: BlocListener<DashboardCubit, DashboardState>(
          listener: (context, state) {
            print('New state: $state');
            if (state.status == DashboardStatus.error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              print('New state: $state');
dataMap={
  "Income": state.income!.toDouble(),
  "Expense": state.expense!.toDouble(),
  
};
              if (state.status == DashboardStatus.loading) {
                // Showing the loading indicator while the user is signing in
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Widget incomeExpenseData() {
  if (state.income!.toDouble() == 0 && state.expense!.toDouble() == 0) {
    return Container(
      child: Text('No data'),
    );
  } else {
    return PieChart(
      dataMap: dataMap,
      chartRadius: 300,
      legendOptions: LegendOptions(
        legendPosition: LegendPosition.bottom,
        showLegendsInRow: true,
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValuesInPercentage: true,
        decimalPlaces: 1,
      ),
    );
  }
}

              if (state.status == DashboardStatus.loaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultSpacing),
                              child: Text(
                                  '${state.currencyCode} ${state.totalAmount}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          // color: fontHeading,
                                          fontSize: fontSizeHeading + 2,
                                          fontWeight: FontWeight.w800)),
                            ),
                            Text("Total Balance",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: fontSubHeading,
                                        fontSize: fontSizeBody,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: defaultSpacing * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: IncomeExpenseCard(
                                      bgColor: primaryDark,
                                      label: "Income",
                                      balance:
                                          '${state.currencyCode} ${state.income.toString()}',
                                      icon: Icons.arrow_upward),
                                ),
                                const SizedBox(
                                  width: defaultSpacing,
                                ),
                                Flexible(
                                  child: IncomeExpenseCard(
                                      bgColor: accent,
                                      label: "Expenses",
                                      balance:
                                          ' -${state.currencyCode} ${state.expense}',
                                      icon: Icons.arrow_downward),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultSpacing * 2,
                            ),
                          ],
                        ),
                      ),
                       Center(
                          child: incomeExpenseData()
                
                
                
                          
                        ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
            floatingActionButton: FloatingActionButton(
          
          backgroundColor: Color(0xFF8E59FF),
            child: Icon(Icons.add,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddExpense()),
              );
            }),
      ),
    );
  }
  
}
