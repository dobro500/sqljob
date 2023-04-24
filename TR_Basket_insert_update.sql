--Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
--6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, 
--то значение в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%
--, иначе DiscountValue = 0

CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
FOR INSERT 
AS
	BEGIN
		IF (EXISTS(SELECT ID_SKU
					FROM inserted
					GROUP BY ID_SKU
					HAVING COUNT(*) >= 2
					)
			)
			
			UPDATE basket 
			SET basket.DiscountValue = basket.Value * 0.05
			FROM dbo.Basket AS basket
			inner join inserted
				on inserted.ID = basket.ID
			WHERE inserted.ID_SKU IN (SELECT ID_SKU
									FROM inserted
									GROUP BY ID_SKU
									HAVING COUNT(*) >= 2
									)
		ELSE 
			UPDATE basket 
			SET basket.DiscountValue = 0
			FROM dbo.Basket AS basket
			inner join inserted
				on inserted.ID = basket.ID
			WHERE inserted.ID_SKU NOT IN (SELECT ID_SKU
									FROM inserted
									GROUP BY ID_SKU
									HAVING COUNT(*) >= 2
									)
		
	END