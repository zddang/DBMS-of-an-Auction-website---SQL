CREATE TABLE SELLERS (
Seller_ID 		number(5) CONSTRAINT seller_pk PRIMARY KEY,	
Seller_fname	varchar2(25) NOT NULL,
Seller_lname	varchar2(25) NOT NULL,
Seller_email	varchar2(50) NOT NULL,
Seller_phone	varchar2(15) NOT NULL
);


CREATE TABLE BIDDERS (
Bidder_ID 		number(5) CONSTRAINT bidder_pk PRIMARY KEY,
Bidder_fname	varchar2(25) NOT NULL,
Bidder_lname	varchar2(25) NOT NULL,
Bidder_email	varchar2(50) NOT NULL,
Bidder_phone	varchar2(15) NOT NULL,
Street		varchar2(25) NOT NULL,
Apt_no		varchar2(8) NOT NULL,
City			varchar2(25) NOT NULL,
Province		varchar2(5) NOT NULL,
Postal_code		varchar2(8) NOT NULL
);

CREATE TABLE CATEGORY (
Category_ID		number(3) CONSTRAINT category_pk PRIMARY KEY,
Category_name	varchar2(15) NOT NULL
);

CREATE TABLE AUCTION_ITEM_STATUS (
Auction_status_ID		number(3) CONSTRAINT auction_status_pk PRIMARY KEY,
Status_description	varchar2(10) NOT NULL
);

CREATE TABLE AUCTION_ITEM (
Item_ID		number(5) CONSTRAINT item_pk PRIMARY KEY,
Item_name		varchar2(25) NOT NULL,
Item_description	varchar2(50) ,
Category_ID		number(3),
Seller_ID		number(5),
Auction_status_ID	number(3),
Start_bid_amount	decimal(6,2),
Auction_start	date,
Auction_end		date,
Bidder_ID		number(5)	DEFAULT NULL,
Actual_selling_price	decimal(6,2)	DEFAULT NULL,
Ship_price		decimal(3,2),
Ship_date		date	DEFAULT NULL,
Arrival_date	date	DEFAULT NULL,
CONSTRAINT item_fk1 FOREIGN KEY (Category_ID) REFERENCES CATEGORY(Category_ID),
CONSTRAINT item_fk2 FOREIGN KEY (Seller_ID) REFERENCES SELLERS(Seller_ID),
CONSTRAINT item_fk3 FOREIGN KEY (Auction_status_ID) REFERENCES AUCTION_ITEM_STATUS(Auction_status_ID),
CONSTRAINT item_fk4 FOREIGN KEY (Bidder_ID) REFERENCES BIDDERS(Bidder_ID)
);

CREATE TABLE BIDS (
Bidder_ID		number(5),
Item_ID		number(5),
Bid_amount		number(6,2),
Bid_time		date,
Bid_result		varchar(15) DEFAULT'Uncertain' ,
CONSTRAINT bit_fk1 FOREIGN KEY (Bidder_ID) REFERENCES BIDDERS(Bidder_ID),
CONSTRAINT bit_fk2 FOREIGN KEY (Item_ID) REFERENCES AUCTION_ITEM(Item_ID),
CONSTRAINT bit_pk2 PRIMARY KEY (Bidder_ID, Item_ID)
);



CREATE TABLE PAYMENT_METHODS (
Payment_method_ID		number(6) CONSTRAINT payment_mothod_pk PRIMARY KEY,
Payment_type		varchar(16),
Account_no			varchar(16),
Bidder_ID			number(5),
CONSTRAINT payment_method_fk1 FOREIGN KEY (Bidder_ID) REFERENCES BIDDERS(Bidder_ID)
);

CREATE TABLE PAYMENT_STATUS (
Payment_status_ID 	number(6) CONSTRAINT payment_status_pk PRIMARY KEY,
Status_description	varchar(10),
Payment_date		date,
Payment_method_ID		number(6),
Item_ID			number(5),
CONSTRAINT payment_status_fk1 FOREIGN KEY (Payment_method_ID) REFERENCES PAYMENT_METHODS(Payment_method_ID),
CONSTRAINT payment_status_fk2 FOREIGN KEY (Item_ID) REFERENCES AUCTION_ITEM(Item_ID)
);




 INSERT INTO SELLERS VALUES (19001, 'John', 'Smith', 'johnsmith@email.com', '345-998-1234');
 INSERT INTO SELLERS VALUES (19002, 'Larry', 'Black', 'larryblack@email.com', '864-555-2345');
 INSERT INTO SELLERS VALUES (19003, 'Channel', 'Ralph', 'channelralph@email.com', '866-123-3445');
 
 INSERT INTO BIDDERS VALUES(24001, 'David','Tras', 'davidtras@email.com', '856-456-9875', 'Keele str', '187', 'Toronto', 'ON', 'M3J 1P3');
INSERT INTO BIDDERS VALUES(24002, 'Zubeka','Dane', 'zubekadane@email.com', '365-998-6789', 'Carberry', '12', 'Brampton', 'ON', 'L6J 9E8');
INSERT INTO BIDDERS VALUES(24003, 'Roy','Lin', 'roylin@email.com', '541-546-4569', 'Sherbrooke St W', '845', 'Montreal', 'QC', 'H3A 0G4');


INSERT INTO CATEGORY VALUES (301, 'Art');
INSERT INTO CATEGORY VALUES (302, 'Car');
INSERT INTO CATEGORY VALUES (303, 'Sculpture');
INSERT INTO CATEGORY VALUES (304, 'Jewelry');
INSERT INTO CATEGORY VALUES (305, 'Real Estate');
INSERT INTO CATEGORY VALUES (306, 'Music');


INSERT INTO AUCTION_ITEM_STATUS VALUES (101, 'Future');
INSERT INTO AUCTION_ITEM_STATUS VALUES (102, 'Current');
INSERT INTO AUCTION_ITEM_STATUS VALUES (103, 'Closed');



INSERT INTO AUCTION_ITEM VALUES (90001, 'Starry Night', 'Famous oil painting by Van Gogh', 301, 19001, 101, 50000.00,  '8/31/2022', '9/30/2022', NULL, NULL, 0.00, NULL, NULL);
INSERT INTO AUCTION_ITEM VALUES (90002, '1909 Volkswagen Beetle', 'Classical red Volkswagen Beetle, sunroof', 302, 19001, 102, 3000.00, '2/26/2022', '3/26/2022', NULL, NULL, 0.00, '4/3/2022', NULL);
INSERT INTO AUCTION_ITEM VALUES (90003, 'Millenia necklace', 'Octagon cut, Pink, Rose gold-tone plated', 304, 19002, 103, 155.00,  '1/10/2022', '1/20/2022', 24002, 300.00, 0.00, '1/21/2022', '1/25/2022');
INSERT INTO AUCTION_ITEM VALUES (90004, 'Best Of Bob Marley', 'Audio CD', 306, 19003, 103, 27.00, '3/1/2022', '3/26/2022', 24001, 50.00, 0.00, NULL, NULL);


INSERT INTO BIDS VALUES (24001, 90004, 50.00, '3/15/2022', 'Winner');
INSERT INTO BIDS VALUES (24001, 90002, 8000.00, '3/15/2022', 'Uncertain');
INSERT INTO BIDS VALUES (24002, 90003, 300.00, '1/20/2022', 'Winner');
INSERT INTO BIDS VALUES (24002, 90002, 6000.00, '3/22/2022', 'Uncertain');
INSERT INTO BIDS VALUES (24003, 90003, 200.00, '1/10/2022','Loser');
INSERT INTO BIDS VALUES (24003, 90002, 5000.00, '3/10/2022', 'Uncertain');
INSERT INTO BIDS VALUES (24002, 90004, 30.00, '3,11/2022','Loser');

INSERT INTO PAYMENT_METHODS VALUES (161301, 'Visa', '4550-1977-56489', 24001);
INSERT INTO PAYMENT_METHODS VALUES (161302, 'Master Card', '6932-5640-56325', 24002);
INSERT INTO PAYMENT_METHODS VALUES (161303, 'Paypal', '564582', 24003);

INSERT INTO PAYMENT_STATUS VALUES (161901, 'Paid', '1/20/2022', 161302 ,90003);
INSERT INTO PAYMENT_STATUS VALUES (161902, 'Pending', Null, Null ,90004);

/*1.	Display the number of Auction item from the AUCTION_ITEM table*/

Select Count(*)
From AUCTION_ITEM;


/*2.	Rename table “Category” to “Categories”*/

Alter Table Category Rename To Categories;
/*2.	Find all items and their category that John Smith has for sell.*/

Select * from categories;

Select a.item_id, a.item_name, c.category_name, s.seller_fname||''||s.seller_lname
From auction_item a 
Inner Join sellers s 
On a.seller_id = s.seller_id
Inner Join categories c
On a.category_id = c.category_id
Where s.seller_fname ='John'
And s.seller_lname = 'Smith';

/*3.	List all the items that are in current auction.*/

Select *
From auction_item
Where auction_status_id = 102;


/*4.	Find all sold items, their actual sold price and the different between start bid amount and the sold price.*/

Select item_id, item_name, item_description, actual_selling_price, actual_selling_price - start_bid_amount As Higher_Amount
From auction_item
Where actual_selling_price is Not Null;

/*5.	List all items has been sold but the bidders have not paid yet.*/

Select a.item_id, a.item_name
From auction_item a 
Inner Join payment_status p
On a.item_id = p.item_id
Where p.payment_status_id = 161902;

Drop Table payment_status;
INSERT INTO PAYMENT_STATUS VALUES (161901, 'Paid', '1/20/2022', 161302 ,90003);
INSERT INTO PAYMENT_STATUS VALUES (161902, 'Pending', Null, Null ,90004);

/*6.	List all the auction that occur before March 10, 2022.*/

Select *
From auction_item
Where auction_start < '3.10.2022'
And  auction_start > '2.10.2022' ;

/*7.	Show all the bidders full name, and their payment methods*/
Select b.bidder_fname||''||b.bidder_lname, p.payment_type, p.account_no
From bidders b
Inner Join payment_methods p
On b.bidder_id = p.bidder_id;

/*1.	Show total number of bidders who bid for item “'1909 Volkswagen Beetle'*/

Select Count(bidder_id)
From Bids
Where item_id = 90002;

/*2.	What is the average bid price of each sold item received?*/

Select a.item_id, a.Item_name, AVG(b.bid_amount) as Bid_average_amount
From auction_item a
Inner Join bids b
On  a.item_id = b.item_id
Where a.auction_status_ID = 103
Group By a.item_id, a.Item_name, a.auction_status_ID;


Select a.item_id, a.Item_name, COUNT(b.bidder_id)
From auction_item a
Inner Join bids b
On a.item_id = b.item_id
Group By a.item_id, a.Item_name
Having Count(b.bidder_id) > 1;

Select item_id, Avg(bid_amount)
from bids
group by item_id;

/*4.	Show the bidder and the number of bids that they placed*/

Select bidders.bidder_fname||' '||bidders.bidder_lname as Bidder_Fullname, Count(bids.bid_time) as times_of_bid
From Bids
Inner Join Bidders
On bids.bidder_id = bidders.bidder_id
Group By bidders.bidder_fname, bidders.bidder_lname;


Select * from bids; SUM(b.bid_amount)
Select * from auction_item_status;

/*10.	Show the item that has the most number of bids.*/
Create View Total_Bids AS
Select a.item_id  as I_ID, a.Item_name as I_name, COUNT(b.bidder_id) as Num_of_bids
From auction_item  a
Inner Join bids b
On a.item_id = b.item_id
Group By a.item_id, a.Item_name
Order by COUNT(b.bidder_id) DESC ;

Select I_name, sum(Num_of_bids) 
From Total_Bids
Group By  I_name ;

Select *
From Total_Bids;

Create View Total_of_Bids AS
Select a.item_id  as I_ID, a.Item_name as I_name, COUNT(b.bidder_id) as Num_of_bids
From auction_item  a
Inner Join bids b
On a.item_id = b.item_id
Group By a.item_id, a.Item_name;

Select I_ID, (Num_of_bids) from Total_Bids ;
select sum(Num_of_bids)from Total_of_Bids;
select max(Num_of_bids)from Total_of_Bids;
Select I_ID, Count(Num_of_bids) from Total_of_Bids group by I_ID;


Select I_ID, Rank() Over (Order By Num_of_bids DESC) AS max_of_bids 
From Total_Bids;

With special_rank As (
Select I_ID, I_name, Num_of_bids, Rank() Over (Order By Num_of_bids DESC) AS bid_rank
From Total_Bids)
Select  I_ID, I_name, Num_of_bids, bid_rank
From  special_rank
Where bid_rank = 1;

/*1.	Set the winner for item ‘1909 Volkswagen Beetle' to the bidder Davis Tras*/

Update Bids
Set Bid_result = 'winner'
Where bidder_ID = 24001
and item_id = 90002;

Select a.item_name, bidders.bidder_fname||' '||bidders.bidder_lname As Bidder_fullname, bids.bid_result
From bids
Inner Join bidders
On bids.bidder_id = bidders.bidder_id
Inner Join Auction_item a
On a.item_id = bids.item_id
Where a.item_id = 90002
and bids.bid_result = 'winner';

Rollback;

Update Bids
Set Bid_result = 'Loser'
Where Bid_result = 'Uncertain'
and item_id = 90002;

Select * from bids where item_id = 90002;

/*3.	Update actual selling price for item ‘1909 Volkswagen Beetle' as the price that bidder Davis Tras offered.*/
Select bid_amount
From Bids 
Where bid_result = 'winner'
and item_id = 90002;

Update Auction_item
Set Actual_selling_price = (Select bid_amount From Bids 
Where bid_result = 'winner'
and item_id = 90002)
Where item_id = 90002;

Select item_id, Item_name, actual_selling_price
From auction_item
Where item_id = 90002;

Select *
From auction_item;

Select * From bids Where item_id = 90002;

Rollback;


/*5.	Delete Item with auction status is ‘close’.*/

Delete From auction_item where auction_status_id = 103;

/*6.	Delete bids with bid status is ‘Loser’*/
 Delete From Bids Where bid_result = 'Loser';
 Select * From bids;
 
 Delete From Payment_status Where status_description = 'Paid';
 
 Select * from Payment_status;
 
 Select * from auction_item where auction_status_id = 103;
 
 Select * from Sellers;
 
 Delete From Payment_methods Where payment_type = 'Paypal';
 
 Select * From Payment_methods;
 
  Delete From Categories Where category_name = 'Real Estate';
  
   Select * From Categories ;