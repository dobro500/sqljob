CREATE TABLE SKU (
	ID int not null IDENTITY
	, Code AS 's' + CAST(ID AS NVARCHAR(15)) PERSISTED UNIQUE--   2.1.2 Поле Code вычисляемое: "s" + ID
	, Name nvarchar(255)
	PRIMARY KEY(ID)
)
GO

CREATE TABLE Family (
	ID INT NOT NULL UNIQUE IDENTITY
	, SurName varchar(36)
	, BudgetValue decimal(18,2)
	PRIMARY KEY(ID)
);

CREATE TABLE Basket (
	ID INT NOT NULL UNIQUE IDENTITY
	, ID_SKU INT NOT NULL 
	, ID_Family INT NOT NULL
	, Quantity INT CHECK(Quantity > 0)
	, Value DECIMAL(18,2) CHECK(Value > 0)
	, PurchaseDate DATE DEFAULT (GETDATE())
	, DiscountValue DECIMAL(18,2)
	PRIMARY KEY(ID)
	CONSTRAINT Basket_ID_SKU_SKU_fk FOREIGN KEY (ID_SKU)     
		REFERENCES SKU(ID),
	CONSTRAINT Basket_ID_Family_Family_fk FOREIGN KEY (ID_Family)     
		REFERENCES Family(ID),
);