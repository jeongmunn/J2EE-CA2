package foods;

public class Category {
	String catName, pictureURL;
	int catId ;
	public Category(int catId,String catName, String pictureURL) {
		super();
		this.catId = catId;
		this.catName = catName;
		this.pictureURL = pictureURL;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getPictureURL() {
		return pictureURL;
	}
	public void setPictureURL(String pictureURL) {
		this.pictureURL = pictureURL;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}

}
