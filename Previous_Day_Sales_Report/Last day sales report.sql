--Last Day Sales Report Meat + Egg + Tofu

Select  s.WarehouseId [ID],
        w.Name [Warehouse],
		tr.ProductVariantId [PVID],
		pv.Name [Product],
		Count(tr.SalePrice) [Sale QTY],
		Sum(tr.SalePrice) [Amount]

from ThingRequest tr
join Shipment s on s.id=tr.ShipmentId
join ProductVariant pv on pv.id=tr.ProductVariantId
join Warehouse w on w.id=s.WarehouseId

where s.ReconciledOn is not null
and s.ReconciledOn>= '2022-01-25 00:00 +06:00'
and s.ReconciledOn< '2022-01-26 00:00 +06:00'
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and tr.ProductVariantId in (
	select ProductVariantId from ProductVariantCategoryMapping where CategoryId in (25,61) or ProductVariantId in (6568)
)
group by tr.ProductVariantId,pv.Name,s.WarehouseId,w.Name