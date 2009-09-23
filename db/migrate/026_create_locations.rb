class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.timestamps
      t.datetime :deleted_at
    end
  
    city_names = ["Agra","Delhi","Kolkata","Puri","Ahmedabad","Faridabad","Lucknow","Raipur","Ajmer","Ghaziabad","Ludhiana","Rajkot","Allahabad","Goa","Madurai","Ranchi","Amritsar","Greater Noida","Mangalore","Secunderabad","Aurangabad","Gurgaon","Meerut","Shimla","Bangalore","Guwahati","Mumbai","Srinagar","Bharatpur","Hoshiarpur","Mysore","Surat","Bhopal","Hyderabad","Nagpur","Thane","Bhubaneswar","Indore","Navi Mumbai","Thiruvananthapuram","Calicut","Coorg","Nashik","Thanjavur","Chandigarh","Jaipur","Noida","Tirupati","Chennai","Jalandhar","Patiala","Udaipur","Cochin","Jammu","Patna","Vadodara","Coimbatore","Jodhpur","Pondicherry","Varanasi","Cuttack","Kanpur","Pune","Vishakapatnam","Dehradun","Bhiwadi","Itanagar","Guntur","Solapur","Haridwar","Munnar","Satara","Kolhapur","Kanchipuram","Kodiakanal","Rishikesh","Durgapur","Ooty","Mussoorie"]

    city_names.each do |city_name|
      Location.create(:name => city_name)
    end
  end
  
  def self.down
    drop_table :locations
  end

end
