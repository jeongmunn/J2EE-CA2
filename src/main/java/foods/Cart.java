package foods;

public class Cart {
	String foodName, category, pictureURL ;
	int foodId, stock, quantity ;
	double retailPrice ;
	
	public Cart(String foodName, String category, String pictureURL, int foodId, int stock, int quantity, double retailPrice) {
		super();
		this.foodName = foodName;
		this.category = category;
		this.pictureURL = pictureURL;
		this.foodId = foodId;
		this.stock = stock;
		this.quantity = quantity;
		this.retailPrice = retailPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPictureURL() {
		return pictureURL;
	}

	public void setPictureURL(String pictureURL) {
		this.pictureURL = pictureURL;
	}

	public int getFoodId() {
		return foodId;
	}

	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public double getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(double retailPrice) {
		this.retailPrice = retailPrice;
	}
}
