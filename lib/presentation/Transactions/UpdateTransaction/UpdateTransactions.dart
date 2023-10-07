import 'package:deciml_assignment/cubit/finance/finance_cubit.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:deciml_assignment/presentation/Transactions/UpdateTransaction/cubit/update_transaction_cubit.dart';
import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTransactionsScreen extends StatefulWidget {
  const UpdateTransactionsScreen({super.key, this.data});
  final Transactionn? data;

  @override
  State<UpdateTransactionsScreen> createState() =>
      _UpdateTransactionsScreenState();
}

class _UpdateTransactionsScreenState extends State<UpdateTransactionsScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  int activeIndex = 0;
  DateTime? selectedDate = DateTime.now();
  int categoryIndex = 0;
  List<String> transactionType = ['Income', 'Expense'];
  List<String> categoriesList = ['Clothing', 'Dining', 'Other'];
  String status = 'Clothing';
  late String currency = '';

  @override
  void initState() {
    int index = categoriesList
        .indexWhere((category) => category == widget.data!.category);
        _titleController.text = widget.data!.name!;
        _descriptionController.text = widget.data!.description!;
        _amountController.text = widget.data!.amount.toString();
    if (widget.data!.type == 'I') {
      setState(() {
        currency = widget.data!.currency!;
        status = categoriesList[index];
        activeIndex = 0;
        selectedDate = DateTime.parse(widget.data!.date!);
      });
    } else {
      setState(() {
        currency = widget.data!.currency!;
        status = categoriesList[index];
        activeIndex = 1;
        selectedDate = DateTime.parse(widget.data!.date!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final finCubit = context.read<UpdateTransactionCubit>();
    print("transaction data ${widget.data?.amount}");
    return Scaffold(
 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
                foregroundColor:  Theme.of(context).textTheme.bodyLarge!.color,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color:  Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        title: const Text(
          "Edit transaction",
        ),
      ),
      body: BlocListener<UpdateTransactionCubit, UpdateTransactionState>(
        listener: (context, state) {
          print("Current state $state");
          if (state.status == UpdateTransactionStatus.success) {
            Navigator.pop(context);
                         ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Updated Transaction Successfully")));
          }
          if (state.status == UpdateTransactionStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Something went wrong try again")));
          }
        },
        child: BlocBuilder<UpdateTransactionCubit, UpdateTransactionState>(
          builder: (context, state) {
            print("Current state $state");
            return SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: transactionType.map((e) {
                                int i = transactionType.indexOf(e);
                                return InkWell(
                                    onTap: () {
                                      setState(() => activeIndex = i);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        label: Text(e),
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        backgroundColor: activeIndex == i
                                            ?Color(0xFF8E59FF) : Theme.of(context).brightness == Brightness.light
        ? Colors.grey // Light mode color
        : Colors.grey[800],
                                      ),
                                    ));
                              }).toList()),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Enter valid name';
    }
    return null;
  },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(),
                            ),
                                                                        validator: (value) {
     if (value!.isNotEmpty) return null;
            return "Enter valid Description";
  },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: const InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(),
                            ),
                                                           validator: (value) {
     if (value!.isNotEmpty) return null;
            return "Enter valid Amount";
        
                               }
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButton<String>(
                              // value: 'INR',
                              isExpanded: true,
                              hint: Text(currency),
                              items:
                                  state.currencyList!.map((Currency currency) {
                                return DropdownMenuItem<String>(
                                  value: currency.name,
                                  child: Text(currency.name!),
                                );
                              }).toList(),
                              onChanged: (selectedCurrency) {
                                setState(() {
                                  currency = selectedCurrency!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(status),
                              items: categoriesList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (selectedCategory) {
                                setState(() {
                                  status = selectedCategory!;
                                });
                              },
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    DateTime _selectedDate =
                                        await _selectDate(context);
                                    setState(() {
                                      selectedDate = _selectedDate;
                                    });
                                  },
                                  icon: Icon(Icons.date_range)),
                              Text(selectedDate.toString().split(" ").first ??
                                  '')
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF8E59FF)),
                              onPressed: () {
                                                                   final isValid = _formKey.currentState!.validate();
                        if (!isValid) {
                          print("triggered valid");
                          return;
                        }
                                finCubit.updateTransaction(
                                    transaction: Transactionn(
                                  name: _titleController.text,
                                  description: _descriptionController.text,
                                  amount: int.parse(_amountController.text),
                                  date:
                                      selectedDate.toString().split(' ').first,
                                  category: status,
                                  type: transactionType[activeIndex]
                                      .split('')
                                      .first,
                                  id: widget.data!.id,
                                  currency: currency,
                                ));

                              },
                              child: const Text(
                                'Edit transaction',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        confirmText: 'Ok',
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    return picked!;
  }
}
