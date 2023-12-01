class Pedidos {
  dynamic imagePath;
  dynamic endereco;
  dynamic qntItemPedido;
  dynamic itemPedido;
  dynamic cliente;
  dynamic nomeRestaurante;

Pedidos(this.cliente, this.endereco, this.imagePath, this.itemPedido, this.qntItemPedido, this.nomeRestaurante);

  Pedidos.inciar() {
    imagePath = "";
    endereco = "";
    qntItemPedido = 0;
    itemPedido = "";
    cliente = "";
    nomeRestaurante = "";
  }
}