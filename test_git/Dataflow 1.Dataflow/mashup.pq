[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "sales_raw_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared sales_raw = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2afe4bed-04ca-4f51-b15d-7e4e95d7d8de"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "7d0f4949-6a4f-4ad6-996e-c5f95ef64cdf"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "sales_raw", ItemKind = "Table"]}[Data],
  #"Reordered columns" = Table.ReorderColumns(#"Navigation 2", {"OrderID", "OrderDate", "CustomerID", "CustomerName", "Segment", "City", "State", "Product", "Quantity", "UnitPrice", "Sales"})
in
  #"Reordered columns";
shared sales_raw_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "2afe4bed-04ca-4f51-b15d-7e4e95d7d8de"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "7d0f4949-6a4f-4ad6-996e-c5f95ef64cdf"]}[Data],
  TableNavigation = Navigation_2{[Id = "sales_clean", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
