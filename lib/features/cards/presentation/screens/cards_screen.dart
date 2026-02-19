import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/domain/entities/entities.dart';
import 'package:expense_control_app/features/cards/presentation/providers/providers.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(availableCardsProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');

    return Scaffold(
      body: cardsAsync.when(
        data: (cards) {
          if (cards.isEmpty) {
            return const CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(pinned: true, title: Text('Tarjetas')),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('No hay tarjetas registradas')),
                ),
              ],
            );
          }

          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverAppBar(pinned: true, title: Text('Tarjetas')),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.list(
                  children: [
                    for (final card in cards)
                      Card(
                        child: ListTile(
                          title: Text(card.label),
                          subtitle: Text(
                            '${card.bank} | Cierre ${card.closingDay} | Pago ${card.dueDay}',
                          ),
                          trailing: Text(currency.format(card.creditLimit)),
                          onTap: () => _showCardForm(context, ref, card: card),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCardForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Agregar tarjeta'),
      ),
    );
  }

  Future<void> _showCardForm(
    BuildContext context,
    WidgetRef ref, {
    CreditCardEntity? card,
  }) async {
    final aliasController = TextEditingController(text: card?.alias ?? '');
    final bankController = TextEditingController(text: card?.bank ?? '');
    final last4Controller = TextEditingController(text: card?.last4 ?? '');
    final closingController = TextEditingController(
      text: card?.closingDay.toString() ?? '25',
    );
    final dueController = TextEditingController(
      text: card?.dueDay.toString() ?? '10',
    );
    final limitController = TextEditingController(
      text: card?.creditLimit.toStringAsFixed(2) ?? '0.00',
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                card == null ? 'Nueva tarjeta' : 'Editar tarjeta',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: aliasController,
                decoration: const InputDecoration(labelText: 'Alias'),
              ),
              TextField(
                controller: bankController,
                decoration: const InputDecoration(labelText: 'Banco'),
              ),
              TextField(
                controller: last4Controller,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ultimos 4 digitos',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: closingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Dia cierre',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: dueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Dia pago'),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: limitController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Linea de credito',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    final entity = CreditCardEntity(
                      id: card?.id ?? 0,
                      alias: aliasController.text.trim(),
                      bank: bankController.text.trim(),
                      last4: last4Controller.text.trim(),
                      closingDay:
                          int.tryParse(closingController.text.trim()) ?? 25,
                      dueDay: int.tryParse(dueController.text.trim()) ?? 10,
                      creditLimit:
                          double.tryParse(limitController.text.trim()) ?? 0,
                    );

                    await ref
                        .read(cardCommandsProvider.notifier)
                        .saveCard(entity);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
