import 'package:flutter_test/flutter_test.dart';
import 'package:loja_app/models/produto.dart';
import 'package:loja_app/state/carrinho_model.dart';

void main() {
  const teclado =
      Produto(sku: 'TEC-001', nome: 'Teclado', preco: 289.90, estoque: 2);
  const mouse =
      Produto(sku: 'MOU-002', nome: 'Mouse', preco: 99.90, estoque: 10);

  test('começa vazio', () {
    final c = CarrinhoModel();
    expect(c.vazio, isTrue);
    expect(c.totalItens, 0);
    expect(c.valorTotal, 0);
  });

  test('adicionar soma quantidades e valor, e notifica a cada mudança', () {
    final c = CarrinhoModel();
    var avisos = 0;
    c.addListener(() => avisos++);

    c.adicionar(teclado);
    c.adicionar(mouse);
    c.adicionar(mouse);

    expect(c.totalItens, 3);
    expect(c.quantidadeDe('MOU-002'), 2);
    expect(c.valorTotal, closeTo(489.70, 0.001));
    expect(avisos, 3);
  });

  // TODO 1: não ultrapassa o estoque e não notifica quando nada muda
  test('não ultrapassa o estoque e não notifica quando nada muda', () {
    final c = CarrinhoModel();
    var avisos = 0;
    c.addListener(() => avisos++);

    expect(c.adicionar(teclado), isTrue);
    expect(c.adicionar(teclado), isTrue);
    expect(avisos, 2);

    // estoque do teclado é 2: a terceira tentativa deve falhar
    expect(c.adicionar(teclado), isFalse);
    expect(c.quantidadeDe('TEC-001'), 2);
    expect(avisos, 2); // não notificou
  });

  // TODO 2: remover decrementa e exclui o produto ao chegar a zero
  test('remover decrementa e exclui o produto ao chegar a zero', () {
    final c = CarrinhoModel();
    c.adicionar(mouse);
    c.adicionar(mouse);

    c.remover(mouse);
    expect(c.quantidadeDe('MOU-002'), 1);
    expect(c.produtos, contains(mouse));

    c.remover(mouse);
    expect(c.quantidadeDe('MOU-002'), 0);
    expect(c.produtos, isEmpty);
    expect(c.vazio, isTrue);

    // remover algo que não está no carrinho não notifica
    var avisos = 0;
    c.addListener(() => avisos++);
    c.remover(mouse);
    expect(avisos, 0);
  });

  // TODO 3: a lista exposta não pode ser alterada pela interface
  test('a lista exposta não pode ser alterada pela interface', () {
    final c = CarrinhoModel();
    c.adicionar(mouse);

    expect(() => c.produtos.add(teclado), throwsUnsupportedError);
    expect(c.produtos.length, 1);
  });
}
