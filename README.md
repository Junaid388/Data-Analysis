# Data-Analysis
The objective is to collect financials from the CDS table in N-Q, and N-CSR reports of SEC/EDGAR database servers.



Collect CDS table data 

Collect CDS table data with texts and table components / information. Search Keywords: CDS, Credit Swap, Credit Default Swap, Credit Default Swaps
Note: 
1.	The net notional is sometimes in (000s), keep track of it in output file.
2.	The unrealized appreciation/depreciation is also sometimes in (000s), keep track of it in output file.




Text analysis 

Text analysis of CDS Text to parse text and extract i). ii). iii) and iv) as below. Develop patterns and develop regex (regular expressions) to identify and extract following: 
i) Underlying
ii) Counterparty
iii) Exact underlying bond
Note: 
Sometimes we may miss the identification of the counterparty when the mutual fund sells the CDS – the phrasing is usually “Receive from …” for example “Receive from Morgan Stanley, Inc., upon default”. 
CDS Text: “Receive quarterly notional amount multiplied by .87% and pay Merrill Lynch, Inc. upon default of Raytheon Co., par value of the notional amount of Raytheon Co. 5.375% 4/1/13”
CDS Text contains a lot of useful information, the way it is reported varies from report to report.
i) Underlying (Raytheon Co.)
ii) Counterparty (Merrill Lynch)
iii) Exact underlying bond is the Raytheon Co 5.375% 4/1/13.
