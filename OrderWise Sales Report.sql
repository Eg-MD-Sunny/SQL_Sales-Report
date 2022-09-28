select  cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		w.id [WID],
		w.Name [WarehouseName],
		o.Id [OrderId],
		count(pv.Id) [Product Qty],
		pv.id [PVID],
		pv.name [Product]

from ThingRequest tr
join Shipment s on s.Id = tr.shipmentId
join [Order] o on o.Id = s.OrderId 
join Warehouse w on w.Id = s.WarehouseId 
join ProductVariant pv on pv.Id = tr.ProductVariantId

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-06-09 00:00 +06:00'
and s.ReconciledOn < '2022-06-11 00:00 +06:00'
and s.ShipmentStatus not in (1,9,10)
and tr.IsReturned=0
and tr.IsCancelled=0
and tr.HasFailedBeforeDispatch=0
and tr.IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and pv.id in (2443)
and w.id in (25)

group by cast(dbo.ToBdt(s.ReconciledOn)as date) ,
		w.id ,
		w.Name ,
		o.Id ,
		pv.id ,
		pv.name 

order by 1 
