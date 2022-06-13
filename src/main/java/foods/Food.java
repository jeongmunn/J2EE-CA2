package foods;

public class Food {
	String foodName, briefDesc, category, detailDesc, pictureURL ;
	int foodId, stock, sales;
	double retailPrice, costPrice ;
	
	public Food(int foodId,String foodName, String briefDesc, double costPrice, double retailPrice, int stock, String category, String pictureURL, String detailDesc, int sales) {
		super();
		this.foodId = foodId;
		this.foodName = foodName;
		this.briefDesc = briefDesc;
		this.costPrice = costPrice;
		this.retailPrice = retailPrice;
		this.stock = stock;
		this.category = category;
		this.pictureURL = pictureURL;
		this.detailDesc = detailDesc;
		this.sales = sales;
	}
	
	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	public String getBriefDesc() {
		return briefDesc;
	}
	public void setBriefDesc(String briefDesc) {
		this.briefDesc = briefDesc;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDetailDesc() {
		return detailDesc;
	}
	public void setDetailDesc(String detailDesc) {
		this.detailDesc = detailDesc;
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
	public double getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(double costPrice) {
		this.costPrice = costPrice;
	}
	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}
	
}
