import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho (${cart.totalItems})'),
      ),
      body: cart.products.isEmpty
          ? const Center(
              child: Text(
                'Carrinho vazio.',
                style: TextStyle(color: Color(0xFF9CA8B5)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2127),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF2A3138)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total'),
                        Text(
                          'R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.products.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final product = cart.products[index];

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
                                child: Text(
                                  '${product.nome} - R\$ ${product.preco.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Remover produto'),
                                      content: Text(
                                        'Deseja remover "${product.nome}" do carrinho?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(true),
                                          child: const Text('Remover'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmed == true) {
                                    cart.removeProduct(index);
                                  }
                                },
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: cart.products.isEmpty ? null : () => cart.clearCart(),
                      icon: const Icon(Icons.cleaning_services_outlined),
                      label: const Text('Limpar carrinho'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
