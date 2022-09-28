--Sales Report (Yestarday)

Select w.id [WID],
	   w.Name [Warehouse],
       pv.id [PVID],
	   pv.name [Product],
	   Count(*) [Sale Quantity],
	   Sum(t.CostPrice) [CostPrice],
	   Sum(tr.SalePrice) [SalePrice],
	   Sum(tr.Mrp) [MRPValue]
	   

from ProductVariant pv
join ThingRequest tr on tr.ProductVariantId=pv.id
join thing t on t.id=tr.AssignedThingId
join Shipment s on s.id=tr.ShipmentId
join Warehouse w on w.Id = s.WarehouseId 


where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-06-01 00:00 +06:00'
and s.ReconciledOn < '2022-06-11 00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and pv.Id in (15871)
and s.WarehouseId in (48)

group by pv.id,
		 pv.name,
		 w.id,
	     w.Name

--order by 3 desc



