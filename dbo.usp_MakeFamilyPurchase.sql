   CREATE PROCEDURE dbo.usp_MakeFamilyPurchase @FamilySurName varchar(255)
   AS BEGIN
		IF EXISTS (SELECT 1 FROM dbo.Family WHERE ID = @FamilySurName) 
				UPDATE family
				SET family.BudgetValue = 
									(SELECT 
										SUM(b.Value)
									FROM dbo.Family AS f
									INNER JOIN dbo.Basket AS b
										ON b.ID_Family = f.Id
									WHERE f.Id = @FamilySurName
									)
				FROM dbo.Family AS family
				WHERE family.Id = @FamilySurName
			ELSE 
				SELECT 'NO FAMILY WITH THIS ID'
   END;


   EXEC dbo.usp_MakeFamilyPurchase  1

   