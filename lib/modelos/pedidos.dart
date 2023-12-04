class Pedidos {
<<<<<<< HEAD
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
=======
  dynamic loginPedidos = 'integracao@pedidos.com';
  dynamic senhaPedidos = 'querocafe';
  dynamic tokenPedidos;

Pedidos(this.loginPedidos, this.senhaPedidos, this.tokenPedidos);
>>>>>>> 3cfc29e9884940b69bd287778b46b0afab84f04e
}