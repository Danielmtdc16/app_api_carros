
class Car {
  int id;
  int ano;
  String combustivel;
  int numPortas;
  String cor;
  String nomeModelo;
  double valor;

  Car({
    required this.id,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.nomeModelo,
    required this.valor,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    ano: json["ano"],
    combustivel: json["combustivel"],
    numPortas: json["num_portas"],
    cor: json["cor"],
    nomeModelo: json["nome_modelo"],
    valor: json["valor"]?.toDouble(),
  );

}