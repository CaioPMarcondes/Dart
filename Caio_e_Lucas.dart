import 'dart:io';

// Classe Produto representa um produto com nome, preço e quantidade
class Produto {
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  // Sobrescreve o método toString para exibir as informações do produto de forma legível
  @override
  String toString() => 'Nome: $nome, Preço: R\$${preco.toStringAsFixed(2)}, Quantidade: $quantidade';
}

// Classe Estoque gerencia um conjunto de produtos
class Estoque {
  Map<int, Produto> produtos = {}; // Mapa para armazenar produtos com seus códigos
  int _codigoAtual = 0; // Código atual para novos produtos

  // Método para cadastrar um novo produto
  cadastrarProduto(String nome, double preco, int quantidade) {
    produtos[++_codigoAtual] = Produto(nome, preco, quantidade);
    print('Produto cadastrado! Código: $_codigoAtual');
  }

  // Método para consultar um produto pelo código
  consultarProduto(int codigo) {
    print(produtos[codigo] ?? 'Produto não encontrado!');
  }

  // Método para atualizar o preço e/ou quantidade de um produto
  atualizarProduto(int codigo, {double? preco, int? quantidade}) {
    var p = produtos[codigo];
    if (p != null) {
      p.preco = preco ?? p.preco;
      p.quantidade = quantidade ?? p.quantidade;
      print('Produto atualizado!');
    } else {
      print('Produto não encontrado!');
    }
  }

  // Método para remover um produto pelo código
  removerProduto(int codigo) {
    print(produtos.remove(codigo) != null ? 'Produto removido!' : 'Produto não encontrado!');
  }

  // Método para listar todos os produtos cadastrados
  listarProdutos() {
    produtos.isEmpty ? print('Nenhum produto cadastrado.') : produtos.forEach((k, p) => print('Código: $k, $p'));
  }
}

main() {
  var estoque = Estoque();
  var acoes = {
    '1': () => estoque.cadastrarProduto(lerString('Nome: '), lerDouble('Preço: '), lerInt('Quantidade: ')),
    '2': () => estoque.consultarProduto(lerInt('Código: ')),
    '3': () => estoque.atualizarProduto(lerInt('Código: '), preco: lerOpcional<double>('Novo preço: '), quantidade: lerOpcional<int>('Nova quantidade: ')),
    '4': () => estoque.removerProduto(lerInt('Código: ')),
    '5': () => estoque.listarProdutos(),
  };

  while (true) {
    print('\n1. Cadastrar\n2. Consultar\n3. Atualizar\n4. Remover\n5. Listar\n6. Sair');
    var opcao = stdin.readLineSync();
    if (opcao == '6') break;
    acoes[opcao]?.call() ?? print('Opção inválida!');
  }
}

// Função para ler uma entrada opcional do tipo T (int ou double)
T lerOpcional<T>(String prompt) {
  stdout.write(prompt);
  var entrada = stdin.readLineSync();
  return entrada == null || entrada.isEmpty ? null as T : (T == int ? int.tryParse(entrada) as T : double.tryParse(entrada) as T);
}

// Função para ler uma string do usuário
String lerString(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync()!;
}

// Função para ler um double do usuário
double lerDouble(String prompt) {
  stdout.write(prompt);
  return double.parse(stdin.readLineSync()!);
}

// Função para ler um int do usuário
int lerInt(String prompt) {
  stdout.write(prompt);
  return int.parse(stdin.readLineSync()!);
}