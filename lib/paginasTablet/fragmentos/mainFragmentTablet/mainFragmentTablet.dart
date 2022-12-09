import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboardTablet.dart';

class MainFragmentTablet extends StatelessWidget {
  const MainFragmentTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerMenuDashboardTablet = Provider.of<ProviderMenuDashboardTablet>(context);

    return providerMenuDashboardTablet.opcion;
  }
}
