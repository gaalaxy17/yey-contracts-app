import 'dart:convert';

import 'package:teste/common/HttpBase.dart';
import 'package:teste/model/contract/Contract.dart';
import 'package:teste/model/contract/ContractDTO.dart';
import 'package:teste/model/contract/ContractFilter.dart';
import 'package:teste/model/contract/PatchContractStatusDTO.dart';

class ContratoService {
  static Future<ContractDTO> buscar(ContractFilter filtro) async {
    var results = await HttpBase.get('/v1/contracts', filtro.toJson());

    ContractDTO contracts = new ContractDTO(contracts: [], total: 0);

    if (results['contracts'].length > 0) {
      results['contracts'].forEach(
          (item) => {contracts.contracts.add(Contract.fromJson(item))});
    }
    contracts.total = results['total'];

    return contracts;
  }

  static Future<Map<String, dynamic>> patchStatus(
      PatchContractStatusDTO dto) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params['status'] = dto.status;
    params['revocationReasonId'] = dto.revocationReasonId;

    var results = await HttpBase.patch('/v1/contract/${dto.id}/status', params);

    return results;
  }
}
