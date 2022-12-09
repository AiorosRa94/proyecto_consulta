import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboard.dart';

class MainFragment extends StatelessWidget {
  const MainFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerMenuDashboard = Provider.of<ProviderMenuDashboard>(context);

    return providerMenuDashboard.opcion;
  }
}
