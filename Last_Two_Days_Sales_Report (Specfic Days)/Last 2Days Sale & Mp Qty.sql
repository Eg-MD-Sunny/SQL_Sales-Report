select  Cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
		DateName(WEEKDAY,(s.ReconciledOn)) [DateName],
		pv.Id [PVID],
		pv.Name [Product],
		Count(tr.SalePrice) [SaleQty],
		Count(Case  When t.CreationEventType in (4,7,9) 
					then pv.Id 
			  else null end	
		) [MPQty]

from ThingRequest tr
join Thing t on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
where s.ReconciledOn is not null
and s.ReconciledOn>= '2022-04-14 00:00 +06:00'
and s.ReconciledOn< '2022-04-16 00:00 +06:00'
and IsCancelled=0
and IsReturned=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.Id in (
	select pvcm.ProductVariantId 
	from ProductVariantCategoryMapping pvcm
	where pvcm.CategoryId in (25,1262,1235)
)

Group by Cast(dbo.ToBdt(s.ReconciledOn)as date),
		 DateName(WEEKDAY,(s.ReconciledOn)),
		 pv.Id,
		 pv.Name

Order by 1 

