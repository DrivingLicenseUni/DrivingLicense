// views/signs_list.dart
import 'package:flutter/material.dart';
import 'package:license/view/signs_details.dart';
import 'package:license/view_model/signs_vm.dart';
import 'package:provider/provider.dart';

class SignsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignsViewModel(),
      child: Consumer<SignsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Driving License Signs'),
            ),
            body: ListView.builder(
              itemCount: viewModel.headers.length,
              itemBuilder: (context, index) {
                String header = viewModel.headers[index];
                return ExpansionTile(
                  title: Text(header),
                  children: viewModel.getSignsForHeader(header).map((sign) {
                    return ListTile(
                      title: Text(sign.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignDetails(sign: sign),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}