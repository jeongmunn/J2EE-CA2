package foods;

public class User {
	int userid, zip;
	String username, email, password, phoneNumber, roadName, floorNumber, country, cityState, role;
	
	
	public User(int userid, String username, String email, String password, String phoneNumber, String roadName, String floorNumber, String country, String cityState, int zip, String role) {
		super();
		this.userid = userid;
		this.username = username;
		this.email = email;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.roadName = roadName;
		this.floorNumber = floorNumber;
		this.country = country;
		this.cityState = cityState;
		this.zip = zip;
		this.role = role;
	}
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getRoadName() {
		return roadName;
	}
	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	
	public String getFloorNumber() {
		return floorNumber;
	}
	public void setFloorNumber(String floorNumber) {
		this.floorNumber = floorNumber;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCityState() {
		return cityState;
	}

	public void setCityState(String cityState) {
		this.cityState = cityState;
	}
	
	public int getZip() {
		return zip;
	}

	public void setZip(int zip) {
		this.zip = zip;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
}