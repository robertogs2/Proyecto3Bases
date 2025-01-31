 
--Select the parks with Parque nacional in the name, by years and with economy
 SELECT NON EMPTY { [Measures].[TotalUtility], [Measures].[TotalCost], [Measures].[TotalGain] } 
 ON COLUMNS, NON EMPTY { ([Service].[Park].[Park].ALLMEMBERS * [Date].[Year].[Year].ALLMEMBERS ) } 
 DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_VALUE, MEMBER_UNIQUE_NAME 
ON ROWS FROM 
( 
SELECT ( 
Filter( [Service].[Park].[Park].ALLMEMBERS, 
Instr( [Service].[Park].currentmember.Properties( 'Member_Caption' ), 'Parque nacional ' )  > 0  ) ) 
ON COLUMNS FROM [GREENTECDW]) 
CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, 
FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

--Takes costs and amount of excursions per year
SELECT NON EMPTY { [Measures].[Entry Count], [Measures].[TotalCost] } 
ON COLUMNS, NON EMPTY { ([Date].[Year].[Year].ALLMEMBERS ) } 
DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_VALUE, MEMBER_UNIQUE_NAME 
ON ROWS FROM ( SELECT ( { [Service].[Zone Type].&[Tour] } ) 
ON COLUMNS FROM [GREENTECDW]) WHERE ( [Service].[Zone Type].&[Tour] ) CELL PROPERTIES VALUE, 
BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS

--Expression for percentage

=IIf(IsNothing(Previous(Fields!TotalSales.Value)),nothing,
(Fields!TotalSales.Value-Previous(Fields!TotalSales.Value))/Previous(Fields!TotalSales.Value))