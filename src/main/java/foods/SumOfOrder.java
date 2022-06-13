package foods;

public class SumOfOrder {
	int userId , countOfOrder;
	double sumOfOrderAmount;
	String username ;
	
	public SumOfOrder(int userId, double sumOfOrderAmount, int countOfOrder, String username) {
		super();
		this.userId = userId;
		this.sumOfOrderAmount = sumOfOrderAmount;
		this.countOfOrder = countOfOrder;
		this.username = username;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public double getSumOfOrderAmount() {
		return sumOfOrderAmount;
	}

	public void setSumOfOrderAmount(double sumOfOrderAmount) {
		this.sumOfOrderAmount = sumOfOrderAmount;
	}

	public int getCountOfOrder() {
		return countOfOrder;
	}

	public void setCountOfOrder(int countOfOrder) {
		this.countOfOrder = countOfOrder;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}