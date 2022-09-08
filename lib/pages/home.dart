import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:teste/components/BaseAlertDialog.dart';
import 'package:teste/components/StatusModalBottomSheet.dart';
import 'package:teste/model/contract/Contract.dart';
import 'package:teste/model/contract/ContractDTO.dart';
import 'package:teste/model/contract/ContractFilter.dart';
import 'package:teste/model/contract/PatchContractStatusDTO.dart';
import 'package:teste/service/ContractService.dart';

/// This is the stateful widget that the main application instantiates.
class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeWidgetState extends State<HomeWidget> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  PatchContractStatusDTO _patchContractStatusDto = new PatchContractStatusDTO();
  ContractFilter _filtro = new ContractFilter();
  List<Contract> contracts = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    _filtro.page = 1;
    _filtro.pageSize = 10;
    filtrar();
  }

  void showAlert() {
    var alert = BaseAlertDialog(
      title: "Atenção",
      content: "Deseja mesmo filtrar os contratos?",
      yesOnPressed: filtrar,
    );
    showDialog(context: context, builder: alert.build);
  }

  void showStatusOptionsModal(int contractId, String status) {
    _patchContractStatusDto.id = contractId;
    Map<String, dynamic> results;
    var modal = StatusModalBottomSheet(
      status: status,
      onPressed: (String value) async => {
        _patchContractStatusDto.status = value,
        results = await ContratoService.patchStatus(_patchContractStatusDto),
        if (results['message'] != null)
          {
            filtrar(),
          }
      },
    );
    showMaterialModalBottomSheet(
      context: context,
      builder: modal.build,
    );
  }

  void filtrar() async {
    ContractDTO dto = await ContratoService.buscar(_filtro);
    setState(() {
      this.contracts = dto.contracts;
      this.total = dto.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'ID do contrato',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => this._filtro.id = value),
          ),
          MaterialButton(
              onPressed: () => filtrar(),
              child: Text('Filtrar'),
              minWidth: double.infinity,
              textColor: Colors.white,
              color: Colors.indigo),
          Expanded(
            child: ListView.builder(
                itemCount: contracts.length,
                itemBuilder: (BuildContext ctx, int index) => Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.description,
                                size: 40,
                              ),
                              title: Text(
                                  "Contrato #${contracts[index].id ?? ''}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                contracts[index].status!.label ?? '',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              trailing: TextButton(
                                onPressed: () => showStatusOptionsModal(
                                    contracts[index].id!,
                                    contracts[index].status!.value!),
                                child: Icon(Icons.more_vert),
                              ),
                            ),
                            Text(
                                "Período: ${formatter.format(contracts[index].startDate ?? DateTime.now())} - ${formatter.format(contracts[index].endDate ?? DateTime.now())}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(""),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: new TextSpan(
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Estagiário: ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    new TextSpan(
                                        text:
                                            "${contracts[index].customerName ?? ''}"),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: new TextSpan(
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Empresa: ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    new TextSpan(
                                        text:
                                            "${contracts[index].companyName ?? ''}"),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: new TextSpan(
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Escola: ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    new TextSpan(
                                        text:
                                            "${contracts[index].schoolName ?? ''}"),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: new TextSpan(
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Salário: ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    new TextSpan(
                                        text:
                                            "${contracts[index].wage.toString()}"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          )
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}
