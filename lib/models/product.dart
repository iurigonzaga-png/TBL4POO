class Product {
  final String nome;
  final double preco;

  const Product({
    required this.nome,
    required this.preco,
  });

  factory Product.fromName(String nome, {double preco = 0.0}) {
    return Product(
      nome: nome.trim(),
      preco: preco,
    );
  }
}
