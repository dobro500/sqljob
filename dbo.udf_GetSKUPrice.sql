CREATE FUNCTION dbo.udf_GetSKUPrice
	(  @ID_SKU INT 
	)
RETURNS DECIMAL(18,2)
    BEGIN

	DECLARE @Quantity INT = (
		SELECT SUM(Quantity) 
		FROM Basket as b 
		WHERE b.ID_SKU = @ID_SKU
		);

	DECLARE @Value DECIMAL(18,2) = (
		SELECT SUM(Value) 
		FROM Basket as b 
		WHERE b.ID_SKU = @ID_SKU
		);
		
	RETURN @Value / @Quantity
	END
	
	
--DECLARE @ret decimal(18,2);
--EXEC @ret = dbo.udf_GetSKUPrice @ID_SKU = 1;
--SELECT @ret;