/*===================================
   Last 30 Days Sale Report
===================================*/

select  w.Id [WID],
		w.Name [Warehouse],
        pv.Id [PVID],
		pv.Name [Product],
		Count(tr.SalePrice) [SaleQty]

from ThingRequest tr 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join Warehouse w on w.Id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-03-25 00:00 +06:00'
and s.ReconciledOn < '2022-04-24 00:00 +06:00'
and tr.IsCancelled = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and tr.IsReturned = 0
and pv.ShelfType in (5,9)
and w.MetropolitanAreaId = 1

Group by w.Id,
		 w.Name,
         pv.Id,
		 pv.Name


/*===================================
   Last 30 Days Market Purchase Qty
=====================================*/

SELECT  w.Id [WID],
		w.Name [Warehouse],
        pv.Id [PVID],
		pv.Name [Product],
	    count(t.productvariantId) [MP_Qty]

FROM thingtransaction tss
JOIN thingevent te ON tss.id = te.thingtransactionid
JOIN thing t ON t.id = te.thingid
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.id = tr.shipmentid
JOIN productvariant pv on pv.id = t.productvariantid
join warehouse w on w.id = s.WarehouseId 

WHERE tss.CreatedOn>= '2022-03-25 00:00 +06:00'
and tss.CreatedOn< '2022-04-24 00:00 +06:00'
AND fromstate IN (262144, 536870912)
AND tostate IN (65536, 16777216, 268435456)
and t.CostPrice is not null
and w.MetropolitanAreaId = 1
and pv.ShelfType in (5,9)

GROUP BY w.Id,
		 w.Name,
         pv.Id,
		 pv.Name



/*===================================
Current Stock for perisable products
=====================================*/

select  w.Id [WID],
		w.Name [Warehouse],
        pv.Id [PVID],
		pv.Name [Product],
		Sum(cwc.MarkedForRecall + cwc.Shelved) [AvailableStock]

from CurrentWarehouseStock cwc
join ProductVariant pv on pv.Id = cwc.ProductVariantId 
join Warehouse w on w.Id = cwc.WarehouseId 

where pv.ShelfType in (5,9)
and w.MetropolitanAreaId = 1

group by w.Id,
		 w.Name,
         pv.Id,
		 pv.Name




