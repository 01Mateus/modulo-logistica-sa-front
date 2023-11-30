class Pedidos {
  dynamic imagePath;
  dynamic endereco;
  dynamic qntItemPedido;
  dynamic itemPedido;
  dynamic cliente;

Pedidos(this.cliente, this.endereco, this.imagePath, this.itemPedido, this.qntItemPedido);

  Pedidos.inciar() {
    imagePath = "";
    endereco = "";
    qntItemPedido = 0;
    itemPedido = "";
    cliente = "";
  }
}