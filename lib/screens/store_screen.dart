import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  final List<Product> products = [
    Product(nome: 'Arroz', preco: 5.0),
    Product(nome: 'Feijão', preco: 7.5),
    Product(nome: 'Macarrão', preco: 4.2),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: products.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final product = products[index];
            final exists = cart.products.any((p) => p.nome == product.nome);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2127),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A3138)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nome,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'R\$ ${product.preco.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF7AA7FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => cart.addProduct(product),
                    child: Text(exists ? 'Adicionado' : 'Adicionar'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
