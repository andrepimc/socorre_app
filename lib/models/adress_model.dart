import 'dart:convert';

class AdressModel {
  final String id;
  final String profile_id;
  final String cep;
  final String rua;
  final String bairro;
  final String numero;
  final String cidade;
  final String uf;
  final String? complemento;
  final String? ponto_ref;
  final String? nome; //aoelido: casa ou trabalho
  AdressModel({
    required this.id,
    required this.profile_id,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.numero,
    required this.cidade,
    required this.uf,
    this.complemento,
    this.ponto_ref,
    this.nome,
  });

  AdressModel copyWith({
    String? id,
    String? profile_id,
    String? cep,
    String? rua,
    String? bairro,
    String? numero,
    String? cidade,
    String? uf,
    String? complemento,
    String? ponto_ref,
    String? nome,
  }) {
    return AdressModel(
      id: id ?? this.id,
      profile_id: profile_id ?? this.profile_id,
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      bairro: bairro ?? this.bairro,
      numero: numero ?? this.numero,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      complemento: complemento ?? this.complemento,
      ponto_ref: ponto_ref ?? this.ponto_ref,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'profile_id': profile_id});
    result.addAll({'cep': cep});
    result.addAll({'rua': rua});
    result.addAll({'bairro': bairro});
    result.addAll({'numero': numero});
    result.addAll({'cidade': cidade});
    result.addAll({'uf': uf});
    if(complemento != null){
      result.addAll({'complemento': complemento});
    }
    if(ponto_ref != null){
      result.addAll({'ponto_ref': ponto_ref});
    }
    if(nome != null){
      result.addAll({'nome': nome});
    }
  
    return result;
  }

  factory AdressModel.fromMap(Map<String, dynamic> map) {
    return AdressModel(
      id: map['id'] ?? '',
      profile_id: map['profile_id'] ?? '',
      cep: map['cep'] ?? '',
      rua: map['rua'] ?? '',
      bairro: map['bairro'] ?? '',
      numero: map['numero'] ?? '',
      cidade: map['cidade'] ?? '',
      uf: map['uf'] ?? '',
      complemento: map['complemento'],
      ponto_ref: map['ponto_ref'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdressModel.fromJson(String source) => AdressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdressModel(id: $id, profile_id: $profile_id, cep: $cep, rua: $rua, bairro: $bairro, numero: $numero, cidade: $cidade, uf: $uf, complemento: $complemento, ponto_ref: $ponto_ref, nome: $nome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AdressModel &&
      other.id == id &&
      other.profile_id == profile_id &&
      other.cep == cep &&
      other.rua == rua &&
      other.bairro == bairro &&
      other.numero == numero &&
      other.cidade == cidade &&
      other.uf == uf &&
      other.complemento == complemento &&
      other.ponto_ref == ponto_ref &&
      other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      profile_id.hashCode ^
      cep.hashCode ^
      rua.hashCode ^
      bairro.hashCode ^
      numero.hashCode ^
      cidade.hashCode ^
      uf.hashCode ^
      complemento.hashCode ^
      ponto_ref.hashCode ^
      nome.hashCode;
  }
}
