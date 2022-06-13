package foods;

public class Order {	
	
int orderId, foodId ;
double totalPrice ;
String date, username ;

public Order(int orderId, String username, double totalPrice, String date) {
	super();
	this.orderId = orderId;
	this.username = username;
	this.totalPrice = totalPrice;
	this.date = date;
}

public String getDate() {
	return date;
}

public void setDate(String date) {
	this.date = date;
}
public int getOrderId() {
	return orderId;
}
public void setOrderId(int orderId) {
	this.orderId = orderId;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public double getTotalPrice() {
	return totalPrice;
}
public void setTotalPrice(double totalPrice) {
	this.totalPrice = totalPrice;
}

}