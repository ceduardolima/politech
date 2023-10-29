import '../domain/turma/turma.dart';

class CadastroTurmaCasoDeUso {
  late Map _turmasMap;

  CadastroTurmaCasoDeUso(Map turmas) {
    _turmasMap = turmas;
  }

  List<Turma> obterTurmas() {
    final chaves = _turmasMap.keys.toList();
    final List<Turma> turmas = [];
    for(var chave in chaves) {
      Map turmaMap = _turmasMap[chave];
      var turma = Turma(chave, turmaMap["nome"], turmaMap["codigo"]);
      turmas.add(turma);
    }
    return turmas;
  }
}