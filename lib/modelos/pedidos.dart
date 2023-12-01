class Pedidos {
  dynamic enderecoPedido;
  dynamic clientePedido;
  dynamic nomeItensPedido;
  dynamic quantidadeItensPedido;
  dynamic imagemRestaurantePedido;
  dynamic nomeRestaurantePedido;
  dynamic cepRestaurantePedido;


Pedidos(this.cepRestaurantePedido, this.clientePedido, this.enderecoPedido, this.nomeItensPedido,this.quantidadeItensPedido, this.imagemRestaurantePedido, this.nomeRestaurantePedido);

  Pedidos.iniciar() {
    enderecoPedido = "";
    clientePedido = "";
    nomeItensPedido = "";
    quantidadeItensPedido = 0;
    imagemRestaurantePedido = "";
    nomeRestaurantePedido = "";
    cepRestaurantePedido = "";
  }
}