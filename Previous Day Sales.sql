select 
     --s.WarehouseId [Warehouse ID],
       tr.ProductVariantId [PVID],
	   pv.Name [Product],
	   Count(tr.SalePrice) [Sale Qty]

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId

where s.ReconciledOn is not null
and s.ReconciledOn>= '2022-02-23 00:00 +06:00'
and s.ReconciledOn< '2022-02-24 00:00 +06:00'
and ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and s.WarehouseId not in (22,23,24,25,37,40)
and pv.Id in (8789,20462)

group by tr.ProductVariantId,
         pv.Name
		 --s.WarehouseId


--SELECT PV.Id [PVID]
--FROM ProductVariant PV
--WHERE PV.Name LIKE '%Apple Jujube (Apple Kul Boroi) 500 gm%'
