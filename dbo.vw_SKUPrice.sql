CREATE VIEW dbo.vw_SKUPrice (id , code , name , cost)
AS 
 SELECT
	sku.ID id
	, sku.Code AS code
	, sku.Name as name
	, dbo.udf_GetSKUPrice(sku.Id) AS cost
FROM dbo.SKU AS sku


